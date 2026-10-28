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
      <div class="logo">🐑 <span>喜羊羊影视</span></div>

      <button class="admin-entry" @click="$emit('open-admin')">🛠 后台管理系统</button>

      <div class="search-wrap" @mouseleave="showHot = false">
        <div class="search-box" :class="{ active: showHot }">
          <span class="ico">🔍</span>
          <input
            v-model="keyword"
            type="text"
            placeholder="搜索电视剧、类型、热播榜…"
            @focus="showHot = true"
            @keyup.enter="doSearch"
          />
          <button class="go" @click="doSearch">搜索</button>
        </div>

        <!-- 搜索栏下拉：热搜 + 榜单直达 -->
        <div class="dropdown" v-show="showHot && !keyword.trim()">
          <div class="dd-title">🔥 大家都在搜</div>
          <div class="hot-tags">
            <span v-for="h in hotSearches" :key="h" @click="pickHot(h)">{{ h }}</span>
          </div>
          <div class="dd-title">🏆 榜单直达</div>
          <div class="dd-links">
            <a @click="scrollTo('rank-score')">📺 电视剧排行榜</a>
            <a @click="scrollTo('rank-hot')">🔥 热度榜</a>
            <a @click="scrollTo('all')">🎬 全部电视剧</a>
          </div>
        </div>
      </div>

      <div class="user">
        <span class="hi">Hi，{{ username }}</span>
        <button class="logout" @click="$emit('logout')">退出</button>
      </div>
    </header>

    <!-- 主内容 -->
    <main class="content">
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
          >
            <div class="badge" v-if="d.status">{{ d.status }}</div>
            <div class="emoji">{{ d.emoji }}</div>
            <div class="hc-title">{{ d.title }}</div>
            <div class="hc-meta">
              <span class="score">⭐ {{ d.score }}</span>
              <span class="hot">🔥 {{ d.hot }}</span>
            </div>
          </div>
        </div>
      </section>

      <!-- 搜索结果 -->
      <section class="section" v-if="keyword.trim()">
        <h3>“{{ keyword }}” 的搜索结果 <small>({{ filtered.length }} 部)</small></h3>
        <div class="grid">
          <div
            class="card"
            v-for="d in filtered"
            :key="d.id"
            :style="{ '--g': d.gradient }"
            @click="open(d)"
          >
            <div class="poster"><span>{{ d.emoji }}</span></div>
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
        <p class="empty" v-if="!filtered.length">没有找到相关电视剧，换个关键词试试～</p>
      </section>

      <!-- 电视剧排行榜（按评分） -->
      <section class="section" id="rank-score">
        <h3>🏆 电视剧排行榜 <small>按观众评分</small></h3>
        <ol class="rank-list">
          <li
            v-for="(d, i) in scoreRank"
            :key="d.id"
            :class="{ top: i < 3 }"
            @click="open(d)"
          >
            <span class="no" :class="'no' + (i + 1)">{{ i + 1 }}</span>
            <span class="r-poster" :style="{ background: d.gradient }">{{ d.emoji }}</span>
            <span class="r-title">{{ d.title }}</span>
            <span class="r-genre">{{ d.genres.join(' / ') }}</span>
            <span class="r-score">⭐ {{ d.score }}</span>
          </li>
        </ol>
      </section>

      <!-- 热度榜（按实时热度） -->
      <section class="section" id="rank-hot">
        <h3>🔥 热度榜 <small>按实时热度值</small></h3>
        <ol class="rank-list hot">
          <li
            v-for="(d, i) in hotRank"
            :key="d.id"
            :class="{ top: i < 3 }"
            @click="open(d)"
          >
            <span class="no" :class="'no' + (i + 1)">{{ i + 1 }}</span>
            <span class="r-poster" :style="{ background: d.gradient }">{{ d.emoji }}</span>
            <span class="r-title">{{ d.title }}</span>
            <span class="r-genre">{{ d.genres.join(' / ') }}</span>
            <span class="r-hot">🔥 {{ d.hot }}</span>
          </li>
        </ol>
      </section>

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
          >
            <div class="poster"><span>{{ d.emoji }}</span></div>
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
    </main>

    <footer class="foot">🌌 喜羊羊影视 · 与时俱进，陪你追剧到天亮</footer>

    <!-- 电视剧 播放 / 详情 弹窗 -->
    <div class="mask" v-if="active" @click.self="closeDrama">
      <div class="player-modal" :style="{ '--g': active.gradient }">
        <button class="close" @click="closeDrama">✕</button>

        <div class="pm-head">
          <div class="pm-poster">{{ active.emoji }}</div>
          <div class="pm-title">
            <h2>{{ active.title }}</h2>
            <div class="m-tags">
              <span v-for="t in active.genres" :key="t">{{ t }}</span>
              <span class="st">{{ active.status }}</span>
            </div>
            <div class="m-stat">
              <span>⭐ {{ active.score }}</span>
              <span>🔥 {{ active.hot }}</span>
              <span>📅 {{ active.year }}</span>
              <span>📺 {{ active.episodes }}</span>
            </div>
          </div>
        </div>

        <!-- 播放器：点击即播放该剧内容（模拟） -->
        <div class="player" :class="{ playing: isPlaying }" :style="{ background: active.gradient }">
          <div class="play-bg">{{ active.emoji }}</div>
          <button class="big-play" v-if="!isPlaying" @click="play">▶</button>
          <div class="play-info" v-if="isPlaying">
            <div class="now">▶ 正在播放 《{{ active.title }}》 第 {{ currentEp }} 集</div>
            <div class="bar"><div class="bar-in" :style="{ width: progress + '%' }"></div></div>
            <div class="time">{{ fmtTime(curSec) }} / {{ fmtTime(totalSec) }}</div>
          </div>
          <div class="play-tip" v-if="!isPlaying">点击 ▶ 播放，开始观看《{{ active.title }}》</div>
        </div>

        <!-- 选集 -->
        <div class="eps">
          <span class="eps-label">选集</span>
          <button
            v-for="n in epCount"
            :key="n"
            class="ep"
            :class="{ on: n === currentEp && isPlaying }"
            @click="chooseEp(n)"
          >{{ n }}</button>
        </div>

        <!-- 标签页：演员资料 / 剧情简介 -->
        <div class="tabs">
          <button :class="{ on: tab === 'cast' }" @click="tab = 'cast'">🎭 演员资料（{{ (active.cast || []).length }}）</button>
          <button :class="{ on: tab === 'desc' }" @click="tab = 'desc'">📖 剧情简介</button>
        </div>

        <div class="tab-body">
          <div class="cast-list" v-if="tab === 'cast'">
            <div class="actor" v-for="(a, i) in (active.cast || [])" :key="i">
              <div class="a-emoji">{{ a.emoji }}</div>
              <div class="a-info">
                <div class="a-name">{{ a.name }} <span class="a-role">饰 {{ a.role }}</span></div>
                <div class="a-bio">{{ a.bio }}</div>
              </div>
            </div>
            <p class="empty" v-if="!(active.cast || []).length">暂无演员资料</p>
          </div>
          <p class="m-desc" v-else>{{ active.desc }}</p>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'

defineProps({ username: String })
defineEmits(['logout', 'open-admin'])

// 与时俱进的电视剧（Mock 数据，作为兜底；后端可用时会被真实数据覆盖）
const dramas = ref([
  { id: 1, title: '星河彼岸', genres: ['科幻', '冒险'], year: 2026, score: 9.2, hot: 9800, episodes: '更新至18集', status: '热播', emoji: '🚀', gradient: 'linear-gradient(135deg,#6a5bff,#b14dff)', desc: '地球资源枯竭，一支少年舰队穿越星河寻找新家园，在宇宙尽头邂逅了会发光的文明。' },
  { id: 2, title: '长安十二时辰·重启', genres: ['古装', '悬疑'], year: 2025, score: 8.9, hot: 8700, episodes: '已完结', status: '独家', emoji: '🏮', gradient: 'linear-gradient(135deg,#ff7a59,#ff3d77)', desc: '盛世长安暗流涌动，一名死囚在十二时辰内必须破解惊天阴谋，拯救一座城。' },
  { id: 3, title: '都市夜行人', genres: ['都市', '刑侦'], year: 2026, score: 8.7, hot: 8200, episodes: '更新至24集', status: '热播', emoji: '🌃', gradient: 'linear-gradient(135deg,#1fd1f9,#2a6cff)', desc: '霓虹下的城市从不入睡，一支深夜刑侦小队专破那些白天破不了的案子。' },
  { id: 4, title: '山海谣', genres: ['仙侠', '奇幻'], year: 2025, score: 9.0, hot: 9100, episodes: '已完结', status: '独家', emoji: '⛰️', gradient: 'linear-gradient(135deg,#43e97b,#38f9d7)', desc: '上古神兽苏醒，少女持山海图踏遍九州，在人与妖的边界寻找属于自己的道。' },
  { id: 5, title: '心跳信号', genres: ['青春', '爱情'], year: 2026, score: 8.5, hot: 7600, episodes: '更新至12集', status: '热播', emoji: '💓', gradient: 'linear-gradient(135deg,#ff6ec4,#7873f5)', desc: '校园电台的午夜节目把两个陌生人连在一起，每一次心跳都是未说出口的告白。' },
  { id: 6, title: '大江东去', genres: ['年代', '励志'], year: 2024, score: 9.1, hot: 9500, episodes: '已完结', status: '经典', emoji: '🌊', gradient: 'linear-gradient(135deg,#f6d365,#fda085)', desc: '改革开放浪潮中，一家三代人从摆地摊到做实业，写就一曲大江东去的奋斗长歌。' },
  { id: 7, title: '机甲纪元', genres: ['科幻', '动作'], year: 2026, score: 8.8, hot: 8900, episodes: '更新至20集', status: '热播', emoji: '🤖', gradient: 'linear-gradient(135deg,#30cfd0,#330867)', desc: '人类与AI共驾机甲迎战外星舰队，每一次出击都是文明存续的赌注。' },
  { id: 8, title: '人间烟火', genres: ['家庭', '温情'], year: 2025, score: 8.6, hot: 7400, episodes: '已完结', status: '治愈', emoji: '🍲', gradient: 'linear-gradient(135deg,#ffb347,#ffcc33)', desc: '一条老街、一家小馆、几户人家，最平凡的一日三餐里藏着最戳心的温柔。' },
  { id: 9, title: '暗夜追凶', genres: ['悬疑', '推理'], year: 2026, score: 9.3, hot: 9900, episodes: '更新至16集', status: '热播', emoji: '🔦', gradient: 'linear-gradient(135deg,#0f2027,#2c5364)', desc: '一桩陈年旧案重启，天才侧写师与冷面刑警联手，在谎言森林里追出真凶。' },
  { id: 10, title: '风起陇西·新章', genres: ['历史', '权谋'], year: 2025, score: 8.9, hot: 8500, episodes: '已完结', status: '独家', emoji: '📜', gradient: 'linear-gradient(135deg,#c79081,#dfa579)', desc: '三国暗战，谍影重重，一名小卒在刀光剑影的权谋棋局中左右着天下大势。' },
  { id: 11, title: '甜野之恋', genres: ['田园', '治愈'], year: 2026, score: 8.4, hot: 7100, episodes: '更新至10集', status: '热播', emoji: '🌿', gradient: 'linear-gradient(135deg,#a8e063,#56ab2f)', desc: '逃离都市的女孩在山谷开起民宿，与一位沉默的护林员慢炖出甜野味的爱情。' },
  { id: 12, title: '赛博长安', genres: ['科幻', '古风'], year: 2026, score: 9.0, hot: 9300, episodes: '更新至22集', status: '热播', emoji: '🌐', gradient: 'linear-gradient(135deg,#ee0979,#ff6a00)', desc: '大唐长安装上霓虹与义体，侠客以代码为剑，在赛博盛世的灯海里快意恩仇。' }
])

const hotSearches = ['暗夜追凶', '赛博长安', '科幻', '热播', '山海谣', '都市夜行人']

const keyword = ref('')
const showHot = ref(false)
const active = ref(null)

const featured = computed(() => [...dramas.value].sort((a, b) => b.hot - a.hot).slice(0, 5))
const scoreRank = computed(() => [...dramas.value].sort((a, b) => b.score - a.score).slice(0, 10))
const hotRank = computed(() => [...dramas.value].sort((a, b) => b.hot - a.hot).slice(0, 10))

const filtered = computed(() => {
  const k = keyword.value.trim().toLowerCase()
  if (!k) return dramas.value
  return dramas.value.filter(d =>
    d.title.toLowerCase().includes(k) ||
    d.genres.join('').toLowerCase().includes(k) ||
    d.status.includes(k)
  )
})

// 把后端返回的电视剧（genres / cast 为字符串）规整成前端需要的格式
function parseCast(str) {
  if (!str) return []
  try {
    const v = JSON.parse(str)
    return Array.isArray(v) ? v : []
  } catch (e) {
    return []
  }
}

function normalize(list) {
  return list.map(d => ({
    id: d.id,
    title: d.title,
    genres: Array.isArray(d.genres) ? d.genres : (d.genres || '').split(',').filter(Boolean),
    year: d.year,
    score: Number(d.score),
    hot: d.hot,
    episodes: d.episodes,
    status: d.status,
    emoji: d.emoji,
    gradient: d.gradient,
    desc: d.description,
    cast: parseCast(d.cast)
  }))
}

// 页面加载时优先从后端拉取真实电视剧数据，失败则保留 Mock 兜底
onMounted(async () => {
  try {
    const res = await fetch('/api/drama/list')
    const data = await res.json()
    if (data.code === 200 && Array.isArray(data.data) && data.data.length) {
      dramas.value = normalize(data.data)
    }
  } catch (e) {
    // 后端未启动：维持 Mock 数据，首页照常展示
  }
})

function doSearch() {
  showHot.value = false
  // 搜索状态仅控制"搜索结果"区域显隐，列表区自动过滤
}

function pickHot(h) {
  keyword.value = h
  showHot.value = false
}

function open(d) {
  // 规整成带 cast 数组的对象，打开播放 / 详情弹窗
  active.value = {
    ...d,
    genres: Array.isArray(d.genres) ? d.genres : (d.genres || '').split(',').filter(Boolean),
    cast: (typeof d.cast === 'string') ? parseCast(d.cast) : (d.cast || [])
  }
  tab.value = 'cast'
  isPlaying.value = false
  currentEp.value = 1
  curSec.value = 0
  progress.value = 0
  stopTimer()
}

function closeDrama() {
  stopTimer()
  isPlaying.value = false
  active.value = null
}

// ---- 播放器状态 ----
const isPlaying = ref(false)
const currentEp = ref(1)
const curSec = ref(0)
const progress = ref(0)
const tab = ref('cast')
const totalSec = 200 // 每集模拟时长（秒），仅用于演示进度

let timer = null
function stopTimer() {
  if (timer) { clearInterval(timer); timer = null }
}
function play() {
  isPlaying.value = true
  if (curSec.value >= totalSec) curSec.value = 0
  stopTimer()
  timer = setInterval(() => {
    curSec.value += 1
    progress.value = Math.min(100, Math.round((curSec.value / totalSec) * 100))
    if (curSec.value >= totalSec) {
      // 自动连播下一集
      if (currentEp.value < epCount.value) {
        currentEp.value += 1
        curSec.value = 0
        progress.value = 0
      } else {
        stopTimer()
        isPlaying.value = false
      }
    }
  }, 1000)
}
function chooseEp(n) {
  currentEp.value = n
  curSec.value = 0
  progress.value = 0
  if (isPlaying.value) play()
}
function fmtTime(s) {
  const m = Math.floor(s / 60)
  const sec = s % 60
  return `${String(m).padStart(2, '0')}:${String(sec).padStart(2, '0')}`
}
const epCount = computed(() => {
  if (!active.value) return 0
  const m = String(active.value.episodes || '').match(/\d+/)
  return m ? parseInt(m[0], 10) : 20
})

function scrollTo(id) {
  showHot.value = false
  const el = document.getElementById(id)
  if (el) el.scrollIntoView({ behavior: 'smooth', block: 'start' })
}

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
.hero-card .hc-title { font-size: 16px; font-weight: 700; text-shadow: 0 2px 8px rgba(0,0,0,.6); }
.hero-card .hc-meta { display: flex; gap: 12px; font-size: 13px; margin-top: 6px; text-shadow: 0 1px 4px rgba(0,0,0,.7); }

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
  height: 120px;
  display: flex; align-items: center; justify-content: center;
  font-size: 44px;
  background: var(--g);
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
}
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
.a-emoji { font-size: 34px; flex: none; width: 48px; height: 48px; border-radius: 12px; background: rgba(123,140,255,.14); display: flex; align-items: center; justify-content: center; }
.a-name { font-size: 15px; font-weight: 700; }
.a-role { font-size: 12px; color: #ffd98a; font-weight: 400; margin-left: 6px; }
.a-bio { font-size: 13px; color: #c6cdf5; line-height: 1.6; margin-top: 4px; }
.m-desc { font-size: 14px; line-height: 1.8; color: #d6dcff; }
.empty { color: #9aa3c7; text-align: center; padding: 20px; }

@media (max-width: 620px) {
  .cast-list { grid-template-columns: 1fr; }
}

@media (max-width: 980px) {
  .hero-row { grid-template-columns: repeat(2, 1fr); }
  .grid { grid-template-columns: repeat(3, 1fr); }
}
@media (max-width: 620px) {
  .grid { grid-template-columns: repeat(2, 1fr); }
  .rank-list li { grid-template-columns: 36px 44px 1fr auto; }
  .rank-list .r-genre { display: none; }
  .logo span { display: none; }
}
</style>
