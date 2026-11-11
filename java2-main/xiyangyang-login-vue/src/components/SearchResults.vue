<template>
  <div class="search-page">
    <!-- 星空背景 -->
    <div class="sky">
      <span v-for="s in stars" :key="s.id" class="star" :style="s.style"></span>
      <span v-for="n in 3" :key="'ss' + n" class="shooting" :style="shootStyle(n)"></span>
      <div class="nebula"></div>
    </div>

    <!-- 顶部：返回 + 搜索栏 -->
    <header class="topbar">
      <button class="back" @click="$emit('back')">← 返回首页</button>
      <div class="logo">🐼 <span>熊猫影视 · 搜索</span></div>
      <div class="search-wrap" @mouseleave="showDrop = false">
        <div class="search-box" :class="{ active: showDrop || keyword.trim() }">
          <span class="ico">🔍</span>
          <input
            v-model="keyword"
            type="text"
            placeholder="搜索电视剧、类型、演员…"
            @focus="showDrop = true"
            @keyup.enter="doSearch"
          />
          <button class="go" @click="doSearch">搜索</button>
        </div>

        <!-- 搜索栏下拉：聚焦时展示 热度榜 / 排行榜；输入时展示匹配建议 -->
        <div class="dropdown" v-show="showDrop">
          <template v-if="!keyword.trim()">
            <div class="dd-rank">
              <div class="dd-title">🔥 热度榜 <small>点击观看</small></div>
              <ul class="dd-list">
                <li
                  v-for="(d, i) in hotRank.slice(0, 5)"
                  :key="'h' + d.id"
                  :class="{ top: i < 3 }"
                  @click="openRank(d)"
                >
                  <span class="dd-no" :class="'no' + (i + 1)">{{ i + 1 }}</span>
                  <span class="dd-emoji">{{ d.emoji || '🎬' }}</span>
                  <span class="dd-name">{{ d.title }}</span>
                  <span class="dd-val">🔥 {{ d.hot }}</span>
                </li>
              </ul>
            </div>
            <div class="dd-rank">
              <div class="dd-title">🏆 电视剧排行榜 <small>按观众评分</small></div>
              <ul class="dd-list">
                <li
                  v-for="(d, i) in scoreRank.slice(0, 5)"
                  :key="'s' + d.id"
                  :class="{ top: i < 3 }"
                  @click="openRank(d)"
                >
                  <span class="dd-no" :class="'no' + (i + 1)">{{ i + 1 }}</span>
                  <span class="dd-emoji">{{ d.emoji || '🎬' }}</span>
                  <span class="dd-name">{{ d.title }}</span>
                  <span class="dd-val">⭐ {{ d.score }}</span>
                </li>
              </ul>
            </div>
          </template>
          <template v-else>
            <div class="dd-title">相关推荐（点击查看搜索结果）</div>
            <ul class="dd-list">
              <li v-for="m in suggestList" :key="m.id" @click="pickSug(m.title)">
                <span class="dd-emoji">{{ m.emoji || '🎬' }}</span>
                <span class="dd-name">{{ m.title }}</span>
                <span class="dd-val">{{ genresText(m) }}</span>
              </li>
            </ul>
            <p class="dd-empty" v-if="!suggestList.length">没有匹配，换个关键词试试～</p>
          </template>
        </div>
      </div>
      <div class="spacer"></div>
    </header>

    <main class="content">
      <!-- 搜索结果（有搜索词时出现） -->
      <section class="section" v-if="keyword.trim()">
        <h3>“{{ keyword }}” 的搜索结果 <small>({{ filtered.length }} 部内容)</small></h3>
        <div class="actor-hits" v-if="actorMatches.length">
          <span class="ah-label">🎭 相关演员：</span>
          <span v-for="an in actorMatches" :key="an" class="ah-chip" @click="openActor(an)">{{ an }}</span>
        </div>
        <div class="grid">
          <div
            class="card"
            v-for="d in filtered"
            :key="d.id"
            :style="{ '--g': d.gradient }"
            @click="open(d)"
            @mouseenter="hoveredId = d.id"
            @mouseleave="hoveredId = null"
          >
            <div class="poster">
              <img v-if="d.cover" class="poster-img" :src="d.cover" :alt="d.title" />
              <span v-else>{{ d.emoji }}</span>
              <video
                v-if="hoveredId === d.id && d.videoUrl"
                class="hover-video"
                :src="d.videoUrl"
                autoplay muted loop playsinline preload="metadata"
              ></video>
            </div>
            <div class="info">
              <div class="name">{{ d.title }}</div>
              <div class="tags">
                <span v-for="t in d.genres" :key="t">{{ t }}</span>
              </div>
              <div class="stat">
                <span class="score">⭐ {{ d.score }}</span>
                <span class="hot">🔥 {{ d.hot }}</span>
              </div>
            </div>
          </div>
        </div>
        <p class="empty" v-if="!filtered.length">没有找到相关内容，换个关键词试试～（支持剧名 / 类型 / 演员名）</p>
      </section>

      <!-- 热度榜 / 排行榜：搜索页常驻展示，点击任意条目直接打开该剧 -->
      <section class="section two-col">
        <div class="rank-block">
          <h3>🏆 电视剧排行榜 <small>按观众评分 · 点击观看</small></h3>
          <ol class="rank-list">
            <li v-for="(d, i) in scoreRank" :key="'ps' + d.id" :class="{ top: i < 3 }" @click="openRank(d)">
              <span class="no" :class="'no' + (i + 1)">{{ i + 1 }}</span>
              <div class="r-poster" :style="{ background: d.gradient }">
                <img v-if="d.cover" class="r-img" :src="d.cover" :alt="d.title" />
                <template v-else>{{ d.emoji }}</template>
              </div>
              <div class="r-txt">
                <div class="r-title">{{ d.title }}</div>
                <div class="r-genre">{{ genresText(d) }}</div>
              </div>
              <span class="r-score">⭐ {{ d.score }}</span>
              <span class="r-hot">🔥 {{ d.hot }}</span>
            </li>
          </ol>
        </div>
        <div class="rank-block">
          <h3>🔥 热度榜 <small>按实时热度值 · 点击观看</small></h3>
          <ol class="rank-list">
            <li v-for="(d, i) in hotRank" :key="'ph' + d.id" :class="{ top: i < 3 }" @click="openRank(d)">
              <span class="no" :class="'no' + (i + 1)">{{ i + 1 }}</span>
              <div class="r-poster" :style="{ background: d.gradient }">
                <img v-if="d.cover" class="r-img" :src="d.cover" :alt="d.title" />
                <template v-else>{{ d.emoji }}</template>
              </div>
              <div class="r-txt">
                <div class="r-title">{{ d.title }}</div>
                <div class="r-genre">{{ genresText(d) }}</div>
              </div>
              <span class="r-score">⭐ {{ d.score }}</span>
              <span class="r-hot">🔥 {{ d.hot }}</span>
            </li>
          </ol>
        </div>
      </section>
    </main>

    <!-- 播放 / 详情弹窗（与首页共用） -->
    <DramaModal ref="dramaModal" @open-actor="openActor" />

    <!-- 演员主页 -->
    <ActorPage
      v-if="actorName"
      :actor-name="actorName"
      :medias="dramas"
      @close="closeActor"
      @open-media="openFromActor"
    />
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import {
  buildInitialDramas, fetchDramas, fetchKids, fetchVariety,
  genresText, castNames, findMediaByTitle, rankByScore, rankByHot
} from '../mediaHelpers.js'
import DramaModal from './DramaModal.vue'
import ActorPage from './ActorPage.vue'

const props = defineProps({ keyword: { type: String, default: '' } })
defineEmits(['back'])

const keyword = ref(props.keyword || '')
const dramas = ref(buildInitialDramas())
const kidsMedia = ref([])
const varietyMedia = ref([])
const hoveredId = ref(null)
const dramaModal = ref(null)
const showDrop = ref(false)

const actorName = ref(null)
function openActor(name) { actorName.value = name }
function closeActor() { actorName.value = null }
function openFromActor(m) { actorName.value = null; open(m) }

onMounted(async () => {
  dramas.value = await fetchDramas()
  kidsMedia.value = await fetchKids()
  varietyMedia.value = await fetchVariety()
})

// 全部内容（电视剧 + 少儿 + 综艺）：搜索时全分类一起搜
const allMedia = computed(() => [...dramas.value, ...kidsMedia.value, ...varietyMedia.value])

const filtered = computed(() => {
  const k = keyword.value.trim().toLowerCase()
  if (!k) return []
  return allMedia.value.filter(m =>
    (m.title || '').toLowerCase().includes(k) ||
    genresText(m).toLowerCase().includes(k) ||
    (m.status || '').includes(keyword.value.trim()) ||
    castNames(m).some(n => n.toLowerCase().includes(k))
  )
})

// 关键词命中的演员（去重，最多 8 个）
const actorMatches = computed(() => {
  const k = keyword.value.trim().toLowerCase()
  if (!k) return []
  const seen = new Set()
  const out = []
  for (const m of allMedia.value) {
    for (const n of castNames(m)) {
      if (!seen.has(n) && n.toLowerCase().includes(k)) {
        seen.add(n)
        out.push(n)
      }
    }
  }
  return out.slice(0, 8)
})

const scoreRank = computed(() => rankByScore(dramas.value))
const hotRank = computed(() => rankByHot(dramas.value))

// 搜索栏输入时的匹配建议（即时本地过滤，点击后把关键词填入并展示结果）
const suggestList = computed(() => {
  const k = keyword.value.trim().toLowerCase()
  if (!k) return []
  return allMedia.value.filter(m =>
    (m.title || '').toLowerCase().includes(k) ||
    genresText(m).toLowerCase().includes(k) ||
    (m.status || '').includes(keyword.value.trim()) ||
    castNames(m).some(n => n.toLowerCase().includes(k))
  ).slice(0, 8)
})

function doSearch() { showDrop.value = false }

// 点击下拉里的匹配建议：把剧名填入搜索框，下方结果区自动更新
function pickSug(title) {
  showDrop.value = false
  keyword.value = title
}

// 点击榜单条目：按剧名补全演员、片头视频等完整数据后打开
function openRank(d) {
  const full = findMediaByTitle(d.title)
  open(full ? { ...d, ...full, score: d.score, hot: d.hot } : d)
}

function open(m) {
  dramaModal.value && dramaModal.value.open(m)
}

// 星空
const stars = Array.from({ length: 150 }, (_, i) => {
  const size = Math.random() * 2 + 1
  return {
    id: i,
    style: {
      top: Math.random() * 100 + '%',
      left: Math.random() * 100 + '%',
      width: size + 'px',
      height: size + 'px',
      animationDelay: (Math.random() * 4).toFixed(2) + 's',
      animationDuration: (2 + Math.random() * 3).toFixed(2) + 's'
    }
  }
})
function shootStyle(n) {
  const top = 5 + n * 18
  const delay = n * 4 + Math.random() * 2
  return {
    top: top + '%',
    left: (60 + n * 12) + '%',
    animationDelay: delay.toFixed(2) + 's'
  }
}
</script>

<style scoped>
.search-page {
  position: relative;
  min-height: 100vh;
  color: #eaf0ff;
  background: radial-gradient(120% 120% at 50% 0%, #1b1147 0%, #0b0f2e 45%, #05071a 100%);
  overflow: hidden;
}
.sky {
  position: fixed; inset: 0; z-index: 0; pointer-events: none;
}
.star {
  position: absolute; background: #fff; border-radius: 50%;
  box-shadow: 0 0 6px rgba(255,255,255,.9);
  animation: twinkle linear infinite;
}
@keyframes twinkle { 0%,100% { opacity:.25; transform:scale(.8);} 50% { opacity:1; transform:scale(1.2);} }
.shooting {
  position: absolute; width: 140px; height: 2px;
  background: linear-gradient(90deg, rgba(255,255,255,0), #fff);
  border-radius: 2px; opacity: 0; transform: rotate(18deg);
  animation: shoot 6s ease-in infinite;
}
@keyframes shoot {
  0% { opacity:0; transform: translate(0,0) rotate(18deg); }
  6% { opacity:1; }
  18% { opacity:0; transform: translate(-320px,110px) rotate(18deg); }
  100% { opacity:0; }
}
.nebula {
  position: absolute; width: 60vw; height: 60vw; top: -10vw; right: -15vw;
  background: radial-gradient(circle, rgba(123,77,255,.35), transparent 60%);
  filter: blur(20px);
}

.topbar {
  position: sticky; top: 0; z-index: 10;
  display: flex; align-items: center; gap: 18px;
  padding: 14px 28px;
  background: rgba(8,12,35,.72);
  backdrop-filter: blur(12px);
  border-bottom: 1px solid rgba(120,130,255,.25);
}
.back {
  border: 1px solid rgba(255,255,255,.35);
  background: rgba(255,255,255,.08); color: #fff;
  border-radius: 999px; padding: 7px 16px; font-size: 13px; cursor: pointer; white-space: nowrap;
  transition: background .2s, transform .1s;
}
.back:hover { background: rgba(123,140,255,.32); }
.back:active { transform: scale(.97); }
.logo { font-size: 20px; font-weight: 800; white-space: nowrap;
  background: linear-gradient(90deg,#7b8cff,#ff6ec4); -webkit-background-clip: text; background-clip: text; color: transparent; }
.logo span { font-size: 16px; }
.search-wrap { position: relative; flex: 1; max-width: 560px; margin: 0 auto; }
.search-box {
  display: flex; align-items: center;
  background: rgba(255,255,255,.08);
  border: 1px solid rgba(150,160,255,.3);
  border-radius: 999px; padding: 4px 6px 4px 14px;
  transition: border-color .2s, box-shadow .2s;
}
.search-box.active { border-color: #7b8cff; box-shadow: 0 0 0 3px rgba(123,140,255,.25); }
.search-box .ico { opacity: .7; }
.search-box input { flex: 1; border: none; outline: none; background: transparent; color: #fff; font-size: 15px; padding: 8px 10px; }
.search-box input::placeholder { color: #9aa3c7; }
.search-box .go {
  border: none; border-radius: 999px; padding: 8px 18px;
  background: linear-gradient(135deg,#7b8cff,#b14dff); color: #fff; font-weight: 700; cursor: pointer;
}
.spacer { width: 96px; }

/* 搜索栏下拉：聚焦时展示 热度榜 / 排行榜 / 匹配建议 */
.dropdown {
  position: absolute;
  top: 52px; left: 0; right: 0;
  background: rgba(14, 18, 45, .97);
  border: 1px solid rgba(150,160,255,.3);
  border-radius: 14px;
  padding: 14px 16px;
  box-shadow: 0 18px 40px rgba(0,0,0,.5);
  max-height: 72vh;
  overflow-y: auto;
}
.dd-rank { margin-bottom: 10px; }
.dd-rank .dd-title { margin-bottom: 6px; }
.dd-rank .dd-title small { color: #9aa3c7; font-size: 12px; font-weight: 400; margin-left: 6px; }
.dd-list { list-style: none; display: flex; flex-direction: column; gap: 4px; }
.dd-list li {
  display: grid;
  grid-template-columns: 26px 28px 1fr auto;
  align-items: center;
  gap: 10px;
  padding: 6px 8px;
  border-radius: 8px;
  background: rgba(255,255,255,.04);
  cursor: pointer;
  transition: background .15s;
}
.dd-list li:hover { background: rgba(123,140,255,.18); }
.dd-list li.top { background: rgba(123,140,255,.12); }
.dd-no { font-size: 14px; font-weight: 800; text-align: center; color: #9aa3c7; }
.dd-no.no1 { color: #ffd24d; }
.dd-no.no2 { color: #d7e1ff; }
.dd-no.no3 { color: #ff9f5a; }
.dd-emoji { font-size: 20px; text-align: center; }
.dd-name { font-size: 14px; font-weight: 600; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
.dd-val { font-size: 13px; color: #ffd98a; white-space: nowrap; }
.dd-list li .dd-val { color: #ff8a8a; }
.dd-empty { font-size: 13px; color: #9aa3c7; padding: 6px 8px; }

.content { position: relative; z-index: 1; max-width: 1180px; margin: 0 auto; padding: 26px 20px 40px; }
.section { margin-top: 34px; }
.section h3 { font-size: 19px; margin-bottom: 16px; }
.section h3 small { color: #9aa3c7; font-size: 13px; font-weight: 400; margin-left: 6px; }

.grid { display: grid; grid-template-columns: repeat(6, 1fr); gap: 14px; }
.card {
  background: rgba(255,255,255,.05); border: 1px solid rgba(150,160,255,.18);
  border-radius: 14px; overflow: hidden; cursor: pointer;
  transition: transform .2s, border-color .2s, box-shadow .2s;
}
.card:hover { transform: translateY(-6px); border-color: rgba(123,140,255,.7); box-shadow: 0 14px 34px rgba(123,140,255,.4); }
.card .poster {
  position: relative; aspect-ratio: 3/4; display: flex; align-items: center; justify-content: center;
  font-size: 44px; background: var(--g); overflow: hidden;
}
.poster-img { width: 100%; height: 100%; object-fit: cover; display: block; }
.card .hover-video { position: absolute; inset: 0; z-index: 2; width: 100%; height: 100%; object-fit: cover; pointer-events: none; }
.card .info { padding: 10px 12px 12px; }
.card .name { font-size: 15px; font-weight: 700; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
.card .tags { display: flex; flex-wrap: wrap; gap: 5px; margin: 8px 0; }
.card .tags span { font-size: 11px; padding: 2px 7px; border-radius: 6px; background: rgba(123,140,255,.18); color: #cdd5ff; }
.card .stat { display: flex; justify-content: space-between; font-size: 12px; color: #ffd98a; }

.empty { color: #9aa3c7; text-align: center; padding: 30px; }

.actor-hits { display: flex; flex-wrap: wrap; align-items: center; gap: 8px; margin: -6px 0 14px; }
.ah-label { font-size: 13px; color: #9aa3c7; }
.ah-chip { font-size: 13px; padding: 5px 12px; border-radius: 999px; background: rgba(123,140,255,.18); color: #cdd5ff; cursor: pointer; transition: background .15s; }
.ah-chip:hover { background: rgba(123,140,255,.35); color: #fff; }

/* 常驻榜单（排行榜 / 热度榜）：左右两列 */
.two-col { display: grid; grid-template-columns: 1fr 1fr; gap: 22px; align-items: start; }
.rank-block { min-width: 0; }
.rank-list { list-style: none; display: flex; flex-direction: column; gap: 10px; }
.rank-list li {
  display: grid; grid-template-columns: 44px 54px 1fr auto auto;
  align-items: center; gap: 14px; padding: 10px 14px;
  border-radius: 12px; background: rgba(255,255,255,.04);
  border: 1px solid rgba(150,160,255,.14); cursor: pointer;
  transition: background .2s, transform .2s;
}
.rank-list li:hover { background: rgba(123,140,255,.16); transform: translateX(4px); }
.rank-list .no { font-size: 18px; font-weight: 800; text-align: center; color: #9aa3c7; }
.rank-list .no1 { color: #ffd24d; }
.rank-list .no2 { color: #d7e1ff; }
.rank-list .no3 { color: #ff9f5a; }
.rank-list .r-poster { width: 54px; height: 54px; border-radius: 10px; display: flex; align-items: center; justify-content: center; font-size: 26px; overflow: hidden; }
.rank-list .r-img { width: 100%; height: 100%; object-fit: cover; border-radius: 10px; display: block; }
.rank-list .r-txt { min-width: 0; }
.rank-list .r-title { font-size: 16px; font-weight: 700; }
.rank-list .r-genre { font-size: 13px; color: #9aa3c7; }
.rank-list .r-score { color: #ffd98a; font-weight: 700; }
.rank-list .r-hot { color: #ff8a8a; font-weight: 700; }
.rank-list li.top { background: rgba(123,140,255,.12); }

@media (max-width: 980px) {
  .grid { grid-template-columns: repeat(3, 1fr); }
  .two-col { grid-template-columns: 1fr; }
}
@media (max-width: 620px) {
  .grid { grid-template-columns: repeat(2, 1fr); }
  .rank-list li { grid-template-columns: 36px 44px 1fr auto; }
  .rank-list .r-genre { display: none; }
  .logo span { display: none; }
  .spacer { display: none; }
}
</style>
