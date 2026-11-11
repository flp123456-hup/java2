<template>
  <!-- 电视剧 播放 / 详情 弹窗（首页与搜索页共用） -->
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
              @click="emit('open-actor', a.name)"
            />
            <div
              v-else
              class="a-emoji clickable"
              :title="'查看 ' + a.name + ' 演过的电视剧'"
              @click="emit('open-actor', a.name)"
            >{{ (a.name || '?').slice(0, 1) }}</div>
            <div class="a-info">
              <div class="a-name clickable" :title="'查看 ' + a.name + ' 演过的电视剧'" @click="emit('open-actor', a.name)">{{ a.name }} <span class="a-role">饰 {{ a.role }}</span></div>
              <div class="a-bio">{{ a.bio }}</div>
            </div>
          </div>
          <p class="empty" v-if="!(active.cast || []).length">暂无演员资料</p>
        </div>
        <p class="m-desc" v-else>{{ active.desc }}</p>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, reactive, watch } from 'vue'
import { resolveActorAvatar } from '../mediaData.js'
import { fetchDanmaku, postDanmaku } from '../danmakuApi.js'
import { addHistory } from '../watchHistory.js'

const emit = defineEmits(['open-actor'])

const active = ref(null)

// ===================== 演员头像 / 跳转演员主页 =====================
const actorFail = reactive({})
function actorAvatar(name) {
  return resolveActorAvatar(name)
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
const danmakus = ref([])
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

// 打开某部剧的播放 / 详情弹窗（供父组件调用）
function open(m) {
  active.value = {
    ...m,
    genres: Array.isArray(m.genres) ? m.genres : (m.genres || '').split(',').filter(Boolean),
    cast: Array.isArray(m.actors) ? m.actors : (typeof m.cast === 'string' ? JSON.parse(m.cast || '[]') : (m.cast || [])),
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
  // 记录观看历史（localStorage，最近观看置顶）
  addHistory({
    id: active.value.id,
    title: active.value.title,
    category: m.category,
    cover: active.value.cover,
    emoji: m.emoji,
    ep: 1
  })
}
function closeDrama() {
  stopTimer()
  isPlaying.value = false
  active.value = null
}

defineExpose({ open, close: closeDrama })
</script>

<style scoped>
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
</style>
