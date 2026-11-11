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
            placeholder="搜索电视剧、类型、热播榜…"
            @focus="showHot = true"
            @keyup.enter="doSearch"
          />
          <button class="go" @click="doSearch">搜索</button>
        </div>

        <!-- 搜索栏下拉：热搜 + 电视剧排行榜 + 热度榜 -->
        <div class="dropdown" v-show="showHot && !keyword.trim()">
          <div class="dd-title">🔥 大家都在搜</div>
          <div class="hot-tags">
            <span v-for="h in hotSearches" :key="h" @click="pickHot(h)">{{ h }}</span>
          </div>

          <!-- 电视剧排行榜（按评分，前 10） -->
          <div class="dd-rank">
            <div class="dd-title">🏆 电视剧排行榜 <small>按观众评分</small></div>
            <ol class="dd-list">
              <li
                v-for="(d, i) in scoreRank"
                :key="'s' + d.id"
                :class="{ top: i < 3 }"
                @click="pickRank(d)"
              >
                <span class="dd-no" :class="'no' + (i + 1)">{{ i + 1 }}</span>
                <span class="dd-emoji">{{ d.emoji }}</span>
                <span class="dd-name">{{ d.title }}</span>
                <span class="dd-val">⭐ {{ d.score }}</span>
              </li>
            </ol>
          </div>

          <!-- 热度榜（按实时热度，前 10） -->
          <div class="dd-rank">
            <div class="dd-title">🔥 热度榜 <small>按实时热度值</small></div>
            <ol class="dd-list">
              <li
                v-for="(d, i) in hotRank"
                :key="'h' + d.id"
                :class="{ top: i < 3 }"
                @click="pickRank(d)"
              >
                <span class="dd-no" :class="'no' + (i + 1)">{{ i + 1 }}</span>
                <span class="dd-emoji">{{ d.emoji }}</span>
                <span class="dd-name">{{ d.title }}</span>
                <span class="dd-val">🔥 {{ d.hot }}</span>
              </li>
            </ol>
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
        <p class="empty" v-if="!filtered.length">没有找到相关电视剧，换个关键词试试～</p>
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

    <!-- 电视剧 播放 / 详情 弹窗 -->
    <div class="mask" v-if="active" @click.self="closeDrama">
      <div class="player-modal" :style="{ '--g': active.gradient }">
        <button class="close" @click="closeDrama">✕</button>

        <div class="pm-head">
          <div class="pm-poster">
            <img v-if="active.cover" class="pm-cover" :src="active.cover" :alt="active.title" />
            <span v-else>{{ active.emoji }}</span>
          </div>
          <div class="pm-title">
            <h2>{{ active.title }}</h2>
            <div class="m-tags">
              <span v-for="t in active.genres" :key="t">{{ t }}</span>
              <span class="st" v-if="active.openingSong">🎵 片头曲：{{ active.openingSong }}</span>
              <span class="st">{{ active.status }}</span>
            </div>
            <div class="m-stat">
              <span v-if="typeof active.score === 'number'">⭐ {{ active.score }}</span>
              <span v-if="typeof active.hot === 'number'">🔥 {{ active.hot }}</span>
              <span>📅 {{ active.year }}</span>
              <span>📺 {{ active.episodes }}</span>
            </div>
          </div>
        </div>

        <!-- 播放器：有片头曲视频时用真实播放器，否则走模拟播放 -->
        <div class="player" :class="{ playing: isPlaying }" :style="{ background: active.gradient }">
          <template v-if="active.videoUrl">
            <video
              v-if="isPlaying"
              :key="currentEp"
              ref="realVideo"
              class="real-video"
              :src="active.videoUrl"
              controls
              autoplay
              @ended="onVideoEnded"
            ></video>
            <button
              v-if="isPlaying"
              class="enlarge-btn"
              @click="enlarge"
              title="放大 / 全屏"
            >⛶ 放大</button>
            <button class="big-play" v-else @click="play">▶</button>
            <div class="play-tip" v-if="!isPlaying">点击 ▶ 播放片头曲《{{ active.openingSong }}》，开始观看《{{ active.title }}》</div>
          </template>
          <template v-else>
            <div class="play-bg">{{ active.emoji }}</div>
            <button class="big-play" v-if="!isPlaying" @click="play">▶</button>
            <div class="play-info" v-if="isPlaying">
              <div class="now">▶ 正在播放 《{{ active.title }}》 第 {{ currentEp }} 集</div>
              <div class="bar"><div class="bar-in" :style="{ width: progress + '%' }"></div></div>
              <div class="time">{{ fmtTime(curSec) }} / {{ fmtTime(totalSec) }}</div>
            </div>
            <div class="play-tip" v-if="!isPlaying">点击 ▶ 播放，开始观看《{{ active.title }}》</div>
          </template>

          <!-- 弹幕飘屏层（pointer-events:none，不挡原生控件） -->
          <div class="dm-layer" v-show="dmOn && active">
            <span
              v-for="d in danmakus"
              :key="d.id"
              class="dm"
              :style="{ top: d.top + '%', color: d.color, animationDuration: d.dur + 's' }"
              @animationend="removeDanmaku(d.id)"
            >{{ d.text }}</span>
          </div>
        </div>

        <!-- 弹幕发送条 -->
        <div class="dm-bar" v-if="active">
          <label class="dm-toggle" :class="{ on: dmOn }">
            <input type="checkbox" v-model="dmOn" /> 弹幕
          </label>
          <input
            class="dm-input"
            v-model="dmText"
            maxlength="40"
            placeholder="发条弹幕飘过屏幕…（回车发送）"
            @keyup.enter="sendDanmaku"
          />
          <button class="dm-send" @click="sendDanmaku">发送</button>
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
            <img
              v-if="actorAvatar(a.name) && !actorFail[a.name]"
              class="a-avatar"
              :src="actorAvatar(a.name)"
              :alt="a.name"
              :title="'查看 ' + a.name + ' 演过的电视剧'"
              @error="actorFail[a.name] = true"
              @click="openActor(a.name)"
            />
            <div
              v-else
              class="a-emoji clickable"
              :title="'查看 ' + a.name + ' 演过的电视剧'"
              @click="openActor(a.name)"
            >{{ (a.name || '?').slice(0, 1) }}</div>
            <div class="a-info">
              <div class="a-name clickable" :title="'查看 ' + a.name + ' 演过的电视剧'" @click="openActor(a.name)">{{ a.name }} <span class="a-role">饰 {{ a.role }}</span></div>
              <div class="a-bio">{{ a.bio }}</div>
            </div>
          </div>
          <p class="empty" v-if="!(active.cast || []).length">暂无演员资料</p>
        </div>
          <p class="m-desc" v-else>{{ active.desc }}</p>
        </div>
      </div>
    </div>

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
import { ref, computed, onMounted, reactive, watch } from 'vue'
import { medias, resolveCover, COVER_BY_TITLE, FUPING_OPENINGS, resolveActorAvatar } from '../mediaData.js'
import { loadKids, loadVariety } from '../mediaApi.js'
import { fetchDanmaku, postDanmaku } from '../danmakuApi.js'
import ActorPage from './ActorPage.vue'

defineProps({ username: String })
defineEmits(['logout', 'open-admin', 'open-media'])

// 与时俱进的电视剧（Mock 数据，作为兜底；后端可用时会被真实数据覆盖）
const dramasMock = [
  { id: 1, title: '三生三世十里桃花', genres: ['古装', '仙侠', '爱情'], year: 2017, score: 8.2, hot: 9800, episodes: '58集', status: '经典', emoji: '🌸', gradient: 'linear-gradient(135deg,#ff9a9e,#fad0c4)', cover: COVER_BY_TITLE['三生三世十里桃花'], desc: '青丘女君白浅与九重天太子夜华历经三世情缘，前世今生纠缠不绝的仙侠爱情故事。' },
  { id: 2, title: '因为遇见你', genres: ['都市', '励志', '情感'], year: 2017, score: 7.4, hot: 8200, episodes: '46集', status: '热播', emoji: '🧵', gradient: 'linear-gradient(135deg,#a1c4fd,#c2e9fb)', cover: COVER_BY_TITLE['因为遇见你'], desc: '弃婴张果果被苏州绣艺世家收养，成长为优秀刺绣天才的励志故事。' },
  { id: 3, title: '嫁金钗', genres: ['古装', '甜宠'], year: 2022, score: 7.0, hot: 7000, episodes: '30集', status: '热播', emoji: '💍', gradient: 'linear-gradient(135deg,#f6d365,#fda085)', cover: COVER_BY_TITLE['嫁金钗'], desc: '古装甜宠题材剧集（简介请按真实情况补充）。' },
  { id: 4, title: '沉香如故', genres: ['古装', '仙侠'], year: 2023, score: 7.0, hot: 6900, episodes: '40集', status: '热播', emoji: '🌿', gradient: 'linear-gradient(135deg,#84fab0,#8fd3f4)', cover: COVER_BY_TITLE['沉香如故'], desc: '古装仙侠题材剧集（简介请按真实情况补充）。' },
  { id: 5, title: '香蜜沉沉烬如霜', genres: ['古装', '仙侠', '爱情'], year: 2018, score: 8.0, hot: 9500, episodes: '63集', status: '经典', emoji: '🔥', gradient: 'linear-gradient(135deg,#ff6a88,#ff99ac)', cover: COVER_BY_TITLE['香蜜沉沉烬如霜'], desc: '花神之女锦觅与天帝之子旭凤跨越生死、历经劫难的仙侠虐恋。' },
  { id: 6, title: '后浪', genres: ['都市', '现实', '励志'], year: 2023, score: 7.8, hot: 9200, episodes: '40集', status: '经典', emoji: '🌊', gradient: 'linear-gradient(135deg,#43cea2,#185a9d)', cover: COVER_BY_TITLE['后浪'], desc: '中医药大学教授任新正辞职创办中医传承班，带领各行业学生传承中医药文化。' }
]

// 浮萍片头曲 7 部剧：后端数据库里没有的条目，用这里兜底补齐
const fupingExtras = [
  { id: 'fp1', title: '长月烬明', genres: ['古装', '仙侠', '爱情'], year: 2023, score: 9.3, hot: 9900, episodes: 40, status: '热播', emoji: '🌑', gradient: 'linear-gradient(135deg,#5b247a,#1bcedf)', desc: '神魔之子澹台烬与衡阳公主黎苏苏跨越五百年宿命纠缠，在爱恨中寻求解脱的仙侠故事。' },
  { id: 'fp2', title: '白月梵星', genres: ['古装', '仙侠', '爱情'], year: 2024, score: 8.5, hot: 9600, episodes: 40, status: '热播', emoji: '🌕', gradient: 'linear-gradient(135deg,#fceabb,#f8b500)', desc: '凡人少女白烁与神族梵樾携手净化妖邪、守护苍生的仙侠冒险。' },
  { id: 'fp3', title: '临江仙', genres: ['古装', '仙侠', '虐恋'], year: 2025, score: 8.6, hot: 9700, episodes: 32, status: '热播', emoji: '🌊', gradient: 'linear-gradient(135deg,#43cea2,#185a9d)', desc: '花如月与白九思从结契到反目，揭秘三界秘辛的仙侠虐恋。' },
  { id: 'fp4', title: '逐玉', genres: ['古装', '悬疑', '爱情'], year: 2025, score: 8.7, hot: 9400, episodes: 40, status: '热播', emoji: '🪶', gradient: 'linear-gradient(135deg,#ee9ca7,#ffdde1)', desc: '将门孤女与寒门谋士联手查案、逐玉寻真的古装悬疑爱情故事。' }
]

// 剧名 → 片头视频地址 的硬编码兜底映射（不依赖后端 / mediaData 的字段匹配）
// 只要剧名在这 7 个里，视频就一定存在，彻底避免"数据来源不同导致视频丢失"
const OPENING_VIDEO = {
  '长月烬明': '/videos/changyue.mp4',
  '白月梵星': '/videos/baiyue.mp4',
  '香蜜沉沉烬如霜': '/videos/xiangmi.mp4',
  '三生三世十里桃花': '/videos/sansheng.mp4',
  '临江仙': '/videos/linjiang.mp4',
  '嫁金钗': '/videos/jiajin.mp4',
  '逐玉': '/videos/zhuyu.mp4'
}

// 按剧名合并浮萍固定数据：演员 / 片头视频 / 集数以 FUPING_OPENINGS 为准
function mergeFuping(item) {
  const fp = FUPING_OPENINGS[item.title]
  const vid = OPENING_VIDEO[item.title]
  if (!fp && !vid) return item
  return {
    ...item,
    cast: (fp && fp.cast) || item.cast || [],
    // 视频地址优先用硬编码映射，保证万无一失
    videoUrl: vid || (fp && fp.videoUrl) || '',
    openingSong: '浮萍',
    // 集数优先用条目自带的（后端返回的"40集"格式），缺再用固定数据
    episodes: item.episodes || (fp && fp.episodes),
    desc: item.desc || (fp && fp.desc)
  }
}

// 初始列表：mock + 浮萍补齐条目，全部过一遍合并（后端可用时会被覆盖后再合并）
const dramas = ref(
  [...dramasMock, ...fupingExtras].map(d => ({
    ...d,
    cover: d.cover || COVER_BY_TITLE[d.title] || '',
    cast: []
  })).map(mergeFuping)
)

const hotSearches = ['长月烬明', '且试天下', '古装', '热播', '星汉灿烂', '卿卿日常']

// 少儿 / 综艺：初始用 mediaData 演示数据兜底，后端可用时会被真实数据覆盖
const kidsMedia = ref(medias.filter(m => m.category === 'kids'))
const varietyMedia = ref(medias.filter(m => m.category === 'variety'))

// 把 mediaData / 后端返回的少儿、综艺条目，规整成首页卡片与弹窗需要的格式
function toHome(m) {
  return {
    id: m.id,
    title: m.title,
    genres: Array.isArray(m.genres) ? m.genres : String(m.genres || '').split(',').filter(Boolean),
    year: m.year,
    score: m.score ?? '—',
    hot: m.hot ?? '—',
    episodes: (m.episodes != null ? m.episodes : '') + (m.epUnit || ''),
    status: m.status || '',
    emoji: m.emoji || '🎬',
    gradient: m.gradient || 'linear-gradient(135deg,#7b8cff,#b14dff)',
    desc: m.desc || m.description || '',
    cast: Array.isArray(m.actors) ? m.actors : (m.cast || []),
    cover: resolveCover(m.cover, m.title)
  }
}

const keyword = ref('')
const showHot = ref(false)
const active = ref(null)

// ===================== 演员头像 / 跳转演员主页 =====================
const actorName = ref(null)
const actorFail = reactive({})
function actorAvatar(name) {
  return resolveActorAvatar(name)
}
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
  // 先规整后端字段，再按剧名合并浮萍固定数据（演员 / 片头视频 / 集数）
  const items = list.map(d => mergeFuping({
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
    cast: parseCast(d.cast),
    cover: resolveCover(d.cover, d.title)
  }))
  // 后端数据库里缺的浮萍剧，用前端兜底条目补齐，保证 7 部齐全
  const have = new Set(items.map(i => i.title))
  fupingExtras.forEach(extra => {
    if (!have.has(extra.title)) {
      items.push(mergeFuping({ ...extra, cover: COVER_BY_TITLE[extra.title] || '' }))
    }
  })
  return items
}

// 页面加载时优先从后端拉取真实数据，失败则保留 Mock 兜底
onMounted(async () => {
  try {
    const res = await fetch('/api/drama')
    const data = await res.json()
    if (data.code === 200 && Array.isArray(data.data) && data.data.length) {
      dramas.value = normalize(data.data)
    }
  } catch (e) {
    // 后端未启动：维持 Mock 数据，首页照常展示
  }

  // 少儿 / 综艺：后端可用时拉取真实数据覆盖，失败则保留 mediaData 演示数据
  try {
    const [k, v] = await Promise.all([loadKids(), loadVariety()])
    if (k.length) kidsMedia.value = k.map(toHome)
    if (v.length) varietyMedia.value = v.map(toHome)
  } catch (e) {
    // 后端未启动：维持 mediaData 演示数据，少儿 / 综艺照常展示
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

// 搜索下拉里点击排行榜条目：直接打开详情并收起下拉
function pickRank(d) {
  open(d)
  showHot.value = false
}

function open(m) {
  // 规整成带 cast 数组的对象，打开播放 / 详情弹窗
  // 兼容两种数据：电视剧（cast / score / hot）与少儿 / 综艺（actors，可能无评分）
  active.value = {
    ...m,
    genres: Array.isArray(m.genres) ? m.genres : (m.genres || '').split(',').filter(Boolean),
    cast: Array.isArray(m.actors) ? m.actors : (typeof m.cast === 'string' ? parseCast(m.cast) : (m.cast || [])),
    episodes: (m.episodes != null ? m.episodes : '') + (m.epUnit || ''),
    score: m.score ?? '—',
    hot: m.hot ?? '—',
    cover: m.cover || ''
  }
  tab.value = 'cast'
  isPlaying.value = false
  currentEp.value = 1
  curSec.value = 0
  progress.value = 0
  stopTimer()
  loadDanmaku()
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
  // 有真实片头视频：直接交给 <video> 播放，不走模拟计时
  if (active.value && active.value.videoUrl) {
    isPlaying.value = true
    stopTimer()
    return
  }
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
// 真实视频播完：自动下一集（重新挂载 <video> 触发自动播放），最后一集则停止
function onVideoEnded() {
  if (currentEp.value < epCount.value) {
    currentEp.value += 1
  } else {
    isPlaying.value = false
  }
}
function chooseEp(n) {
  currentEp.value = n
  curSec.value = 0
  progress.value = 0
  if (active.value && active.value.videoUrl) {
    // :key 随 currentEp 变化会重新挂载 <video>，实现换集重新播放
    isPlaying.value = true
    return
  }
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

// ---- 卡片悬停预览：当前悬停的卡片 id（hover 时动态创建 autoplay 视频）----
const hoveredId = ref(null)

// ---- 弹窗视频放大 / 全屏 ----
const realVideo = ref(null)
function enlarge() {
  const v = realVideo.value
  if (!v) return
  const fn = v.requestFullscreen || v.webkitRequestFullscreen || v.msRequestFullscreen
  if (fn) { try { fn.call(v) } catch (e) {} }
}

// ===================== 弹幕 =====================
const dmOn = ref(true)
const dmText = ref('')
const danmakus = ref([])          // 当前在飞的弹幕
const actorFailSet = reactive(new Set())
let dmSeq = 0
let lane = 0
const DM_COLORS = ['#fff', '#ffd479', '#ff8a8a', '#8ad6ff', '#a6f0a6', '#ffb3f0']

function dmKey() {
  return 'dm:' + (active.value ? active.value.id : 'x') + ':' + currentEp.value
}
// 拉取弹幕：后端优先；后端不可用自动回退本地 localStorage
async function loadDanmaku() {
  danmakus.value = []
  const id = active.value ? String(active.value.id) : 'x'
  const fromBackend = await fetchDanmaku(id, currentEp.value)
  if (fromBackend && fromBackend.length) {
    fromBackend.slice(-40).forEach(item => pushDanmaku(item.text, item.color, true))
    return
  }
  try {
    const arr = JSON.parse(localStorage.getItem(dmKey()) || '[]')
    arr.slice(-40).forEach(item => pushDanmaku(item.text, item.color, true))
  } catch (e) { /* ignore */ }
}
function saveDanmaku(text, color) {
  try {
    const arr = JSON.parse(localStorage.getItem(dmKey()) || '[]')
    arr.push({ text, color })
    localStorage.setItem(dmKey(), JSON.stringify(arr.slice(-200)))
  } catch (e) { /* ignore */ }
}
function pushDanmaku(text, color, replay) {
  if (!text) return
  const id = ++dmSeq
  const top = 4 + (lane % 8) * 7        // 8 条泳道，避免全叠一起
  lane++
  const dur = replay ? 7 + Math.random() * 4 : 8
  danmakus.value.push({ id, text, color, top, dur })
}
function removeDanmaku(id) {
  const i = danmakus.value.findIndex(d => d.id === id)
  if (i >= 0) danmakus.value.splice(i, 1)
}
function sendDanmaku() {
  const text = (dmText.value || '').trim()
  if (!text) return
  const color = DM_COLORS[Math.floor(Math.random() * DM_COLORS.length)]
  pushDanmaku(text, color, false)
  saveDanmaku(text, color) // 本地即时保存（后端未启动时也能保留）
  postDanmaku(String(active.value ? active.value.id : 'x'), currentEp.value, text, color, 0) // 同步到后端（多人共享）
  dmText.value = ''
}

// 切换选集时重载该集弹幕
watch(currentEp, loadDanmaku)

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
}
@media (max-width: 620px) {
  .grid { grid-template-columns: repeat(2, 1fr); }
  .rank-list li { grid-template-columns: 36px 44px 1fr auto; }
  .rank-list .r-genre { display: none; }
  .logo span { display: none; }
}
</style>
