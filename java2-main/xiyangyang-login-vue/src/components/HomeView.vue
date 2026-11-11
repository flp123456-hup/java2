<template>
  <div class="home">
    <!-- 星空背景：满天星星 + 流星 -->
    <div class="sky">
      <span v-for="s in stars" :key="s.id" class="star" :style="s.style"></span>
      <span v-for="n in 3" :key="'ss' + n" class="shooting" :style="shootStyle(n)"></span>
      <div class="nebula"></div>
    </div>

    <!-- 顶部导航 + 搜索栏 -->
    <header class="topbar">
      <div class="logo">🐼 <span>熊猫影视</span></div>

      <button class="admin-entry" @click="$emit('open-admin')">🛠 后台管理系统</button>

      <!-- 功能栏：电视剧 / 少儿 / 综艺 分类入口 -->
      <div class="func-bar">
        <button class="fn" @click="$emit('open-media')">📺 电视剧</button>
        <button class="fn" @click="scrollTo('kids')">🧒 少儿</button>
        <button class="fn" @click="scrollTo('variety')">🎉 综艺</button>
      </div>

      <div class="search-wrap" @mouseleave="showHot = false">
        <div class="search-box" :class="{ active: showHot }">
          <span class="ico">🔍</span>
          <input
            v-model="keyword"
            type="text"
            placeholder="搜索电视剧、类型、演员…"
            @focus="showHot = true"
            @keyup.enter="doSearch"
          />
          <button class="go" @click="doSearch">搜索</button>
        </div>

        <!-- 搜索栏下拉：聚焦时展示 热度榜 / 排行榜 / 热搜词；输入时展示匹配建议 -->
        <div class="dropdown" v-show="showHot">
          <!-- 空关键词：展示榜单 + 热搜（搜索栏里面含 热度榜 / 排行榜） -->
          <template v-if="!keyword.trim()">
            <div class="dd-rank">
              <div class="dd-title">🔥 热度榜 <small>点击跳转搜索页</small></div>
              <ul class="dd-list">
                <li
                  v-for="(d, i) in hotRank.slice(0, 5)"
                  :key="'h' + d.id"
                  :class="{ top: i < 3 }"
                  @click="jump(d.title)"
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
                  @click="jump(d.title)"
                >
                  <span class="dd-no" :class="'no' + (i + 1)">{{ i + 1 }}</span>
                  <span class="dd-emoji">{{ d.emoji || '🎬' }}</span>
                  <span class="dd-name">{{ d.title }}</span>
                  <span class="dd-val">⭐ {{ d.score }}</span>
                </li>
              </ul>
            </div>
            <div class="dd-links">
              <a @click="jump('')">查看完整榜单 / 进入搜索页 →</a>
            </div>
            <div class="dd-title" style="margin-top: 12px">🔥 大家都在搜</div>
            <div class="hot-tags">
              <span v-for="h in hotSearches" :key="h" @click="pickHot(h)">{{ h }}</span>
            </div>
          </template>

          <!-- 有关键词：展示匹配建议（点击跳转搜索页看相关电视剧） -->
          <template v-else>
            <div class="dd-title">相关推荐（点击跳转搜索页）</div>
            <ul class="dd-list">
              <li v-for="m in suggestList" :key="m.id" @click="jump(m.title)">
                <span class="dd-emoji">{{ m.emoji || '🎬' }}</span>
                <span class="dd-name">{{ m.title }}</span>
                <span class="dd-val">{{ genresText(m) }}</span>
              </li>
            </ul>
            <p class="dd-empty" v-if="!suggestList.length">没有匹配，换个关键词试试～</p>
          </template>
        </div>
      </div>

      <div class="user">
        <span class="hi">Hi，{{ username }}</span>
        <button class="logout" @click="$emit('logout')">退出</button>
      </div>
    </header>

    <!-- 主内容 -->
    <main class="content">
      <!-- 观看历史已移至后台管理系统：AdminDashboard -> 观看历史 -->

      <!-- Hero：与时俱进 · 热门推荐 -->
      <section class="hero">
        <div class="hero-head">
          <h2>🌟 与时俱进 · 热播电视剧</h2>
          <span class="sub">每天更新，跟紧潮流</span>
        </div>
        <div class="hero-row">
          <div
            class="hero-card"
            v-for="d in featured"
            :key="d.id"
            :style="{ background: d.gradient }"
            @click="open(d)"
            @mouseenter="hoveredId = d.id"
            @mouseleave="hoveredId = null"
          >
            <div class="badge" v-if="d.status">{{ d.status }}</div>
            <img v-if="d.cover" class="hc-cover" :src="d.cover" :alt="d.title" />
            <i v-if="d.cover" class="hc-shade"></i>
            <video
              v-if="hoveredId === d.id && d.videoUrl"
              class="hover-video"
              :src="d.videoUrl"
              autoplay
              muted
              loop
              playsinline
              preload="metadata"
            ></video>
            <div class="emoji" v-if="!d.cover">{{ d.emoji }}</div>
            <div class="hc-title">{{ d.title }}</div>
            <div class="hc-meta">
              <span class="score">⭐ {{ d.score }}</span>
              <span class="hot">🔥 {{ d.hot }}</span>
            </div>
          </div>
        </div>
      </section>

      <!-- 搜索结果已移到独立的搜索页 SearchResults.vue -->

      <!-- 电视剧排行榜 / 热度榜已移到独立的搜索页 SearchResults.vue -->

      <!-- 全部电视剧 -->
      <section class="section" id="all">
        <h3>🎬 全部电视剧 <small>({{ dramas.length }} 部)</small></h3>
        <div class="grid">
          <div
            class="card"
            v-for="d in dramas"
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
                autoplay
                muted
                loop
                playsinline
                preload="metadata"
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
      </section>

      <!-- 少儿专区 -->
      <section class="section" id="kids">
        <h3>🧒 少儿专区 <small>动画 · 亲子 · 启蒙（{{ kidsMedia.length }} 部）</small></h3>
        <div class="grid">
          <div
            class="card"
            v-for="m in kidsMedia"
            :key="m.id"
            :style="{ '--g': m.gradient }"
            @click="open(m)"
          >
            <div class="poster">
              <img v-if="m.cover" class="poster-img" :src="m.cover" :alt="m.title" />
              <span v-else>{{ m.emoji }}</span>
            </div>
            <div class="info">
              <div class="name">{{ m.title }}</div>
              <div class="tags">
                <span v-for="t in m.genres" :key="t">{{ t }}</span>
              </div>
              <div class="stat">
                <span class="score">📅 {{ m.year }}</span>
                <span class="hot">📺 {{ m.episodes }}</span>
              </div>
            </div>
          </div>
        </div>
        <p class="empty" v-if="!kidsMedia.length">少儿内容正在筹备，敬请期待～</p>
      </section>

      <!-- 综艺专区 -->
      <section class="section" id="variety">
        <h3>🎉 综艺专区 <small>真人秀 · 音乐 · 访谈（{{ varietyMedia.length }} 部）</small></h3>
        <div class="grid">
          <div
            class="card"
            v-for="m in varietyMedia"
            :key="m.id"
            :style="{ '--g': m.gradient }"
            @click="open(m)"
          >
            <div class="poster">
              <img v-if="m.cover" class="poster-img" :src="m.cover" :alt="m.title" />
              <span v-else>{{ m.emoji }}</span>
            </div>
            <div class="info">
              <div class="name">{{ m.title }}</div>
              <div class="tags">
                <span v-for="t in m.genres" :key="t">{{ t }}</span>
              </div>
              <div class="stat">
                <span class="score">📅 {{ m.year }}</span>
                <span class="hot">📺 {{ m.episodes }}</span>
              </div>
            </div>
          </div>
        </div>
        <p class="empty" v-if="!varietyMedia.length">综艺内容正在筹备，敬请期待～</p>
      </section>
    </main>

    <footer class="foot">🌌 熊猫影视 · 与时俱进，陪你追剧到天亮</footer>

    <!-- 电视剧 播放 / 详情 弹窗（抽成共享组件，首页与搜索页共用） -->
    <DramaModal ref="dramaModal" @open-actor="openActor" />

    <!-- 演员主页：点演员头像 / 名字跳转到 TA 演过的电视剧 -->
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
  genresText, castNames, rankByScore, rankByHot
} from '../mediaHelpers.js'
import DramaModal from './DramaModal.vue'
import ActorPage from './ActorPage.vue'

defineProps({ username: String })
const emit = defineEmits(['logout', 'open-admin', 'open-media', 'search'])

// 影视数据准备（Mock 兜底 / 后端拉取 / 浮萍补齐）统一放在 mediaHelpers.js
const dramas = ref(buildInitialDramas())
const hotSearches = ['长月烬明', '且试天下', '古装', '热播', '星汉灿烂', '卿卿日常']
// 少儿 / 综艺：初始为空，onMounted 时拉取真实数据（失败回退 mediaData 演示数据）
const kidsMedia = ref([])
const varietyMedia = ref([])

const keyword = ref('')
const showHot = ref(false)
const dramaModal = ref(null)

// ===================== 演员主页（点演员头像 / 名字跳转） =====================
const actorName = ref(null)
// 点演员头像 / 名字 → 打开演员主页，看 TA 演过的电视剧
function openActor(name) {
  actorName.value = name
}
function closeActor() {
  actorName.value = null
}
// 从演员主页点某部剧：关掉演员页，打开该剧详情
function openFromActor(m) {
  actorName.value = null
  open(m)
}

const featured = computed(() => [...dramas.value].sort((a, b) => (b.hot || 0) - (a.hot || 0)).slice(0, 5))
const scoreRank = computed(() => rankByScore(dramas.value))
const hotRank = computed(() => rankByHot(dramas.value))

// 全部内容（电视剧 + 少儿 + 综艺）：搜索时全分类一起搜
const allMedia = computed(() => [...dramas.value, ...kidsMedia.value, ...varietyMedia.value])

// 搜索栏输入时的匹配建议（即时本地过滤，点击跳转搜索页；后端未启动时也能用）
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

// genresText / castNames 已统一从 mediaHelpers 导入


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

// 关键词命中的演员（去重，最多 8 个），点击打开演员主页
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

// 页面加载时优先从后端拉取真实数据，失败则保留 mediaData / Mock 兜底
onMounted(async () => {
  dramas.value = await fetchDramas()
  kidsMedia.value = await fetchKids()
  varietyMedia.value = await fetchVariety()
})

// 点击「搜索」→ 跳转到独立的搜索页（带关键词），由 App.vue 切换 mode
function doSearch() {
  showHot.value = false
  emit('search', keyword.value.trim())
}

// 搜索栏下拉里的榜单 / 建议条目：点击直接跳转到搜索页（带关键词）
function jump(kw) {
  showHot.value = false
  emit('search', (kw || '').trim())
}

function pickHot(h) {
  keyword.value = h
  emit('search', h)
}

// 排行榜 / 热度榜的点击跳转已移到搜索页 SearchResults.vue

// 打开某部剧的播放 / 详情弹窗（委托给共享 DramaModal 组件）
function open(m) {
  dramaModal.value && dramaModal.value.open(m)
}

// 播放器状态 / 选集 / 弹幕逻辑已移入 DramaModal.vue

function scrollTo(id) {
  showHot.value = false
  const el = document.getElementById(id)
  if (el) el.scrollIntoView({ behavior: 'smooth', block: 'start' })
}

// ---- 卡片悬停预览：当前悬停的卡片 id（hover 时动态创建 autoplay 视频）----
const hoveredId = ref(null)

// 弹窗放大、弹幕逻辑已移入 DramaModal.vue

// 生成满天星星
const stars = Array.from({ length: 150 }, (_, i) => {
  const size = Math.random() * 2 + 1
  const style = {
    top: Math.random() * 100 + '%',
    left: Math.random() * 100 + '%',
    width: size + 'px',
    height: size + 'px',
    animationDelay: (Math.random() * 4).toFixed(2) + 's',
    animationDuration: (2 + Math.random() * 3).toFixed(2) + 's'
  }
  return { id: i, style }
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
.home {
  position: relative;
  min-height: 100vh;
  color: #eaf0ff;
  background: radial-gradient(120% 120% at 50% 0%, #1b1147 0%, #0b0f2e 45%, #05071a 100%);
  overflow: hidden;
}

/* 星空层 */
.sky {
  position: fixed;
  inset: 0;
  z-index: 0;
  pointer-events: none;
}
.star {
  position: absolute;
  background: #fff;
  border-radius: 50%;
  box-shadow: 0 0 6px rgba(255, 255, 255, .9);
  animation: twinkle linear infinite;
}
@keyframes twinkle {
  0%, 100% { opacity: .25; transform: scale(.8); }
  50% { opacity: 1; transform: scale(1.2); }
}
.shooting {
  position: absolute;
  width: 140px;
  height: 2px;
  background: linear-gradient(90deg, rgba(255,255,255,0), #fff);
  border-radius: 2px;
  opacity: 0;
  transform: rotate(18deg);
  animation: shoot 6s ease-in infinite;
}
@keyframes shoot {
  0% { opacity: 0; transform: translate(0, 0) rotate(18deg); }
  6% { opacity: 1; }
  18% { opacity: 0; transform: translate(-320px, 110px) rotate(18deg); }
  100% { opacity: 0; }
}
.nebula {
  position: absolute;
  width: 60vw; height: 60vw;
  top: -10vw; right: -15vw;
  background: radial-gradient(circle, rgba(123,77,255,.35), transparent 60%);
  filter: blur(20px);
}

/* 顶部导航 */
.topbar {
  position: sticky;
  top: 0;
  z-index: 10;
  display: flex;
  align-items: center;
  gap: 20px;
  padding: 14px 28px;
  background: rgba(8, 12, 35, .72);
  backdrop-filter: blur(12px);
  border-bottom: 1px solid rgba(120, 130, 255, .25);
}
.logo {
  font-size: 22px;
  font-weight: 800;
  white-space: nowrap;
  background: linear-gradient(90deg, #7b8cff, #ff6ec4);
  -webkit-background-clip: text;
  background-clip: text;
  color: transparent;
}
.logo span { font-size: 18px; }

.admin-entry {
  border: 1px solid rgba(255, 158, 214, .5);
  background: rgba(255, 110, 196, .14);
  color: #ffb3e2;
  border-radius: 999px;
  padding: 6px 14px;
  font-size: 13px;
  font-weight: 700;
  cursor: pointer;
  white-space: nowrap;
  transition: background .2s, transform .1s;
}
.admin-entry:hover { background: rgba(255, 110, 196, .3); }
.admin-entry:active { transform: scale(.97); }

/* 功能栏：电视剧 / 少儿 / 综艺 分类入口 */
.func-bar { display: flex; align-items: center; gap: 8px; }
.fn {
  padding: 7px 14px;
  border: 1px solid rgba(255,255,255,.35);
  border-radius: 20px;
  background: rgba(255,255,255,.10);
  color: #fff;
  font-size: 13px;
  cursor: pointer;
  white-space: nowrap;
  transition: background .2s, transform .1s;
}
.fn:hover { background: rgba(123,140,255,.32); }
.fn:active { transform: scale(.97); }

.search-wrap { position: relative; flex: 1; max-width: 560px; margin: 0 auto; }
.search-box {
  display: flex;
  align-items: center;
  background: rgba(255,255,255,.08);
  border: 1px solid rgba(150,160,255,.3);
  border-radius: 999px;
  padding: 4px 6px 4px 14px;
  transition: border-color .2s, box-shadow .2s;
}
.search-box.active {
  border-color: #7b8cff;
  box-shadow: 0 0 0 3px rgba(123,140,255,.25);
}
.search-box .ico { opacity: .7; }
.search-box input {
  flex: 1;
  border: none;
  outline: none;
  background: transparent;
  color: #fff;
  font-size: 15px;
  padding: 8px 10px;
}
.search-box input::placeholder { color: #9aa3c7; }
.search-box .go {
  border: none;
  border-radius: 999px;
  padding: 8px 18px;
  background: linear-gradient(135deg, #7b8cff, #b14dff);
  color: #fff;
  font-weight: 700;
  cursor: pointer;
}
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
.dd-title { font-size: 13px; color: #9aa3c7; margin: 6px 0 8px; }
.hot-tags { display: flex; flex-wrap: wrap; gap: 8px; }
.hot-tags span {
  font-size: 13px;
  padding: 5px 12px;
  border-radius: 999px;
  background: rgba(255,110,196,.14);
  color: #ff9ad4;
  cursor: pointer;
}
.hot-tags span:hover { background: rgba(255,110,196,.3); }
.dd-links { display: flex; flex-direction: column; gap: 6px; }
.dd-links a {
  font-size: 14px;
  color: #b9c2ff;
  cursor: pointer;
  padding: 4px 0;
}
.dd-links a:hover { color: #fff; }

/* 搜索下拉里的排行榜 */
.dd-rank { margin-top: 10px; }
.dd-rank .dd-title { margin-bottom: 6px; }
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
.dd-list li .dd-val { color: #ff8a8a; } /* 热度榜数值用红色调 */
.dd-empty { font-size: 13px; color: #9aa3c7; padding: 6px 8px; }

.user { display: flex; align-items: center; gap: 12px; white-space: nowrap; }
.user .hi { font-size: 14px; color: #cdd5ff; }
.logout {
  border: 1px solid rgba(150,160,255,.4);
  background: transparent;
  color: #cdd5ff;
  border-radius: 999px;
  padding: 6px 14px;
  cursor: pointer;
}
.logout:hover { background: rgba(255,255,255,.1); }

/* 内容 */
.content { position: relative; z-index: 1; max-width: 1180px; margin: 0 auto; padding: 26px 20px 40px; }

.hero-head { display: flex; align-items: baseline; gap: 12px; margin-bottom: 16px; }
.hero-head h2 { font-size: 22px; }
.hero-head .sub { color: #9aa3c7; font-size: 13px; }

.hero-row { display: grid; grid-template-columns: repeat(5, 1fr); gap: 14px; }
.hero-card {
  position: relative;
  height: 200px;
  border-radius: 16px;
  overflow: hidden;
  cursor: pointer;
  display: flex;
  flex-direction: column;
  justify-content: flex-end;
  padding: 14px;
  box-shadow: 0 10px 30px rgba(0,0,0,.4);
  transition: transform .2s, box-shadow .2s;
}
.hero-card:hover { transform: translateY(-6px); box-shadow: 0 16px 40px rgba(123,140,255,.5); }
.hero-card .badge {
  position: absolute; top: 10px; left: 10px;
  font-size: 12px; padding: 3px 9px; border-radius: 999px;
  background: rgba(0,0,0,.45); color: #ffe08a; font-weight: 700;
}
.hero-card .emoji { font-size: 46px; margin-bottom: auto; }
/* Hero 有封面时：图铺满 + 底部压暗，保证剧名/数据可读 */
.hero-card .hc-cover {
  position: absolute; inset: 0; z-index: 0;
  width: 100%; height: 100%; object-fit: cover;
}
.hero-card .hc-shade {
  position: absolute; inset: 0; z-index: 1;
  background: linear-gradient(180deg, rgba(0,0,0,0) 25%, rgba(5,7,26,.55) 62%, rgba(5,7,26,.92) 100%);
}
.hero-card .badge,
.hero-card .hc-title,
.hero-card .hc-meta { z-index: 2; }
.hero-card .hc-title { font-size: 16px; font-weight: 700; text-shadow: 0 2px 8px rgba(0,0,0,.6); }
.hero-card .hc-meta { display: flex; gap: 12px; font-size: 13px; margin-top: 6px; text-shadow: 0 1px 4px rgba(0,0,0,.7); }
.hero-card .hover-video {
  position: absolute; inset: 0; z-index: 1;
  width: 100%; height: 100%; object-fit: cover;
  pointer-events: none;
}

.section { margin-top: 34px; }
.section h3 { font-size: 19px; margin-bottom: 16px; }
.section h3 small { color: #9aa3c7; font-size: 13px; font-weight: 400; margin-left: 6px; }

.grid { display: grid; grid-template-columns: repeat(6, 1fr); gap: 14px; }
.card {
  background: rgba(255,255,255,.05);
  border: 1px solid rgba(150,160,255,.18);
  border-radius: 14px;
  overflow: hidden;
  cursor: pointer;
  transition: transform .2s, border-color .2s, box-shadow .2s;
}
.card:hover {
  transform: translateY(-6px);
  border-color: rgba(123,140,255,.7);
  box-shadow: 0 14px 34px rgba(123,140,255,.4);
}
.card .poster {
  position: relative;
  aspect-ratio: 3 / 4;
  display: flex; align-items: center; justify-content: center;
  font-size: 44px;
  background: var(--g);
  overflow: hidden;
}
.poster-img {
  width: 100%; height: 100%;
  object-fit: cover;
  display: block;
}
.card .hover-video {
  position: absolute; inset: 0; z-index: 2;
  width: 100%; height: 100%; object-fit: cover;
  pointer-events: none;
}
.card .info { padding: 10px 12px 12px; }
.card .name { font-size: 15px; font-weight: 700; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
.card .tags { display: flex; flex-wrap: wrap; gap: 5px; margin: 8px 0; }
.card .tags span {
  font-size: 11px; padding: 2px 7px; border-radius: 6px;
  background: rgba(123,140,255,.18); color: #cdd5ff;
}
.card .stat { display: flex; justify-content: space-between; font-size: 12px; color: #ffd98a; }

.empty { color: #9aa3c7; text-align: center; padding: 30px; }

/* 观看历史 */
.hist-head { display: flex; align-items: baseline; justify-content: space-between; margin-bottom: 16px; }
.hist-clear {
  border: 1px solid rgba(255,255,255,.3);
  background: rgba(255,255,255,.08);
  color: #cdd5ff;
  border-radius: 999px;
  padding: 5px 14px;
  font-size: 13px;
  cursor: pointer;
  transition: background .2s;
}
.hist-clear:hover { background: rgba(255,110,196,.25); border-color: rgba(255,110,196,.6); }
.hist-meta { margin-top: 8px; font-size: 12px; color: #9aa3c7; }

/* 搜索命中的演员 */
.actor-hits { display: flex; flex-wrap: wrap; align-items: center; gap: 8px; margin: -6px 0 14px; }
.ah-label { font-size: 13px; color: #9aa3c7; }
.ah-chip {
  font-size: 13px;
  padding: 5px 12px;
  border-radius: 999px;
  background: rgba(123,140,255,.18);
  color: #cdd5ff;
  cursor: pointer;
  transition: background .15s;
}
.ah-chip:hover { background: rgba(123,140,255,.35); color: #fff; }

/* 常驻榜单（排行榜 / 热度榜）：左右两列 */
.two-col { display: grid; grid-template-columns: 1fr 1fr; gap: 22px; align-items: start; }
.rank-block { min-width: 0; }
.rank-list .r-poster { overflow: hidden; }
.rank-list .r-img { width: 100%; height: 100%; object-fit: cover; border-radius: 10px; display: block; }
.rank-list .r-txt { min-width: 0; }
.rank-list .r-hot { color: #ff8a8a; font-weight: 700; }

/* 排行榜 */
.rank-list { list-style: none; display: flex; flex-direction: column; gap: 10px; }
.rank-list li {
  display: grid;
  grid-template-columns: 44px 54px 1fr auto auto;
  align-items: center;
  gap: 14px;
  padding: 10px 14px;
  border-radius: 12px;
  background: rgba(255,255,255,.04);
  border: 1px solid rgba(150,160,255,.14);
  cursor: pointer;
  transition: background .2s, transform .2s;
}
.rank-list li:hover { background: rgba(123,140,255,.16); transform: translateX(4px); }
.rank-list .no {
  font-size: 18px; font-weight: 800; text-align: center;
  color: #9aa3c7;
}
.rank-list .no1 { color: #ffd24d; }
.rank-list .no2 { color: #d7e1ff; }
.rank-list .no3 { color: #ff9f5a; }
.rank-list .r-poster {
  width: 54px; height: 54px; border-radius: 10px;
  display: flex; align-items: center; justify-content: center; font-size: 26px;
}
.rank-list .r-title { font-size: 16px; font-weight: 700; }
.rank-list .r-genre { font-size: 13px; color: #9aa3c7; }
.rank-list .r-score { color: #ffd98a; font-weight: 700; }
.rank-list .r-hot { color: #ff8a8a; font-weight: 700; }
.rank-list li.top { background: rgba(123,140,255,.12); }

.foot {
  position: relative; z-index: 1;
  text-align: center; color: #8b93c4;
  padding: 26px; font-size: 14px;
}

/* 播放 / 详情弹窗 */
.mask {
  position: fixed; inset: 0; z-index: 50;
  background: rgba(2,4,15,.7);
  display: flex; align-items: flex-start; justify-content: center;
  backdrop-filter: blur(4px);
  overflow: auto; padding: 30px 16px;
}
.player-modal {
  position: relative;
  width: 860px; max-width: 94vw;
  background: rgba(16,20,48,.97);
  border: 1px solid rgba(150,160,255,.3);
  border-radius: 18px;
  padding: 24px;
  box-shadow: 0 24px 60px rgba(0,0,0,.6);
  margin: auto;
}
.player-modal::before {
  content: ''; position: absolute; inset: 0; border-radius: 18px;
  padding: 1px; background: var(--g);
  -webkit-mask: linear-gradient(#000 0 0) content-box, linear-gradient(#000 0 0);
  -webkit-mask-composite: xor; mask-composite: exclude;
  opacity: .6; pointer-events: none;
}
.player-modal .close {
  position: absolute; top: 12px; right: 12px;
  border: none; background: rgba(255,255,255,.1); color: #fff;
  width: 30px; height: 30px; border-radius: 50%; cursor: pointer; z-index: 2;
}
.pm-head { display: flex; gap: 14px; align-items: center; margin-bottom: 16px; }
.pm-poster {
  width: 76px; height: 76px; border-radius: 14px; flex: none;
  display: flex; align-items: center; justify-content: center; font-size: 40px;
  background: var(--g);
  overflow: hidden;
}
.pm-cover { width: 100%; height: 100%; object-fit: cover; display: block; }
.pm-title h2 { font-size: 22px; margin-bottom: 8px; }
.m-tags { display: flex; flex-wrap: wrap; gap: 6px; margin-bottom: 8px; }
.m-tags span {
  font-size: 12px; padding: 3px 9px; border-radius: 7px;
  background: rgba(123,140,255,.18); color: #cdd5ff;
}
.m-tags .st { background: rgba(255,216,138,.2); color: #ffd98a; }
.m-stat { display: flex; flex-wrap: wrap; gap: 12px; font-size: 13px; color: #ffd98a; }

.player {
  position: relative; height: 0; padding-bottom: 52%;
  border-radius: 14px; overflow: hidden; margin-bottom: 14px;
  display: flex; align-items: center; justify-content: center;
}
.player .play-bg {
  position: absolute; inset: 0; display: flex; align-items: center; justify-content: center;
  font-size: 120px; opacity: .35; filter: drop-shadow(0 6px 20px rgba(0,0,0,.4));
}
.player.playing .play-bg { animation: floaty 3s ease-in-out infinite; }
@keyframes floaty { 0%,100% { transform: translateY(0); } 50% { transform: translateY(-10px); } }
/* 真实片头视频：铺满播放器区域 */
.real-video {
  position: absolute; inset: 0; z-index: 2;
  width: 100%; height: 100%;
  object-fit: contain;
  background: #000;
}
.enlarge-btn {
  position: absolute; top: 10px; right: 10px; z-index: 3;
  border: 1px solid rgba(255,255,255,.6);
  background: rgba(0,0,0,.45); color: #fff;
  border-radius: 8px; padding: 6px 12px; font-size: 13px; font-weight: 700;
  cursor: pointer; backdrop-filter: blur(4px);
}
.enlarge-btn:hover { background: rgba(123,140,255,.6); border-color: #fff; }
.big-play {
  position: relative; z-index: 2; width: 76px; height: 76px; border-radius: 50%;
  border: none; cursor: pointer; font-size: 30px; color: #fff;
  background: rgba(0,0,0,.35); backdrop-filter: blur(4px);
  box-shadow: 0 0 0 8px rgba(255,255,255,.15);
}
.big-play:hover { background: rgba(0,0,0,.5); }
.play-tip {
  position: absolute; bottom: 14px; left: 0; right: 0; text-align: center;
  color: #fff; font-size: 14px; text-shadow: 0 2px 6px rgba(0,0,0,.6);
}
.play-info { position: absolute; left: 16px; right: 16px; bottom: 14px; z-index: 2; color: #fff; }
.play-info .now { font-size: 14px; margin-bottom: 8px; text-shadow: 0 2px 6px rgba(0,0,0,.7); }
.play-info .bar { height: 6px; border-radius: 999px; background: rgba(255,255,255,.3); overflow: hidden; }
.play-info .bar-in { height: 100%; background: linear-gradient(90deg,#7b8cff,#ff6ec4); }
.play-info .time { font-size: 12px; margin-top: 6px; text-align: right; opacity: .9; }

.eps { display: flex; flex-wrap: wrap; gap: 8px; align-items: center; margin-bottom: 16px; max-height: 120px; overflow: auto; }
.eps-label { font-size: 13px; color: #9aa3c7; margin-right: 4px; }
.ep {
  border: 1px solid rgba(150,160,255,.3); background: rgba(255,255,255,.05); color: #cdd5ff;
  border-radius: 8px; padding: 6px 10px; font-size: 13px; cursor: pointer; min-width: 38px;
}
.ep:hover { border-color: #7b8cff; }
.ep.on { background: linear-gradient(135deg,#7b8cff,#b14dff); color: #fff; border-color: transparent; }

.tabs { display: flex; gap: 10px; margin-bottom: 14px; }
.tabs button {
  border: 1px solid rgba(150,160,255,.3); background: transparent; color: #cdd5ff;
  border-radius: 999px; padding: 7px 16px; font-size: 14px; cursor: pointer;
}
.tabs button.on { background: rgba(123,140,255,.22); border-color: #7b8cff; color: #fff; }

.cast-list { display: grid; grid-template-columns: 1fr 1fr; gap: 12px; }
.actor { display: flex; gap: 12px; background: rgba(255,255,255,.04); border: 1px solid rgba(150,160,255,.16); border-radius: 12px; padding: 12px; }
.a-avatar {
  width: 48px; height: 48px; flex: none;
  border-radius: 12px; object-fit: cover; object-position: center top;
  cursor: pointer; border: 2px solid rgba(255,110,196,.6);
}
.a-emoji { font-size: 34px; flex: none; width: 48px; height: 48px; border-radius: 12px; background: rgba(123,140,255,.14); display: flex; align-items: center; justify-content: center; }
.a-name { font-size: 15px; font-weight: 700; }
.clickable { cursor: pointer; transition: color .15s; }
.clickable:hover { color: #ff9ad4; text-decoration: underline; }
.a-role { font-size: 12px; color: #ffd98a; font-weight: 400; margin-left: 6px; }
.a-bio { font-size: 13px; color: #c6cdf5; line-height: 1.6; margin-top: 4px; }
.m-desc { font-size: 14px; line-height: 1.8; color: #d6dcff; }
.empty { color: #9aa3c7; text-align: center; padding: 20px; }

/* 弹幕飘屏层（与播放器共用同一块区域，用容器查询单位 cqw 从右飞到左） */
.dm-layer {
  position: absolute; inset: 0; overflow: hidden;
  pointer-events: none; z-index: 6; container-type: inline-size;
}
.dm {
  position: absolute; left: 0; white-space: nowrap;
  font-size: 16px; font-weight: 700;
  text-shadow: 0 1px 3px rgba(0,0,0,.9);
  transform: translateX(100cqw);
  animation-name: dm-move; animation-timing-function: linear; animation-fill-mode: forwards;
  will-change: transform;
}
@keyframes dm-move { to { transform: translateX(-100%); } }

/* 弹幕发送条 */
.dm-bar { display: flex; align-items: center; gap: 10px; margin: 4px 0 16px; }
.dm-toggle { font-size: 13px; color: #cdd5ff; display: flex; align-items: center; gap: 5px; cursor: pointer; user-select: none; }
.dm-toggle.on { color: #ffd479; }
.dm-input {
  flex: 1; background: rgba(255,255,255,.06); border: 1px solid rgba(150,160,255,.3);
  color: #fff; border-radius: 8px; padding: 9px 12px; font-size: 14px; outline: none;
}
.dm-input:focus { border-color: #7b8cff; }
.dm-send { background: linear-gradient(135deg,#7b8cff,#b14dff); color: #fff; border: none; border-radius: 8px; padding: 9px 18px; cursor: pointer; font-size: 14px; font-weight: 700; }
.dm-send:hover { filter: brightness(1.08); }

@media (max-width: 620px) {
  .cast-list { grid-template-columns: 1fr; }
}

@media (max-width: 980px) {
  .hero-row { grid-template-columns: repeat(2, 1fr); }
  .grid { grid-template-columns: repeat(3, 1fr); }
  .two-col { grid-template-columns: 1fr; }
}
@media (max-width: 620px) {
  .grid { grid-template-columns: repeat(2, 1fr); }
  .rank-list li { grid-template-columns: 36px 44px 1fr auto; }
  .rank-list .r-genre { display: none; }
  .logo span { display: none; }
}
</style>
