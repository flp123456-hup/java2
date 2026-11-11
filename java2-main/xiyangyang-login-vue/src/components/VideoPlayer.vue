<template>
  <div class="player-mask" @click.self="$emit('close')">
    <div class="player-box">
      <div class="player-head">
        <div class="ptitle">
          <span class="pemoji">{{ media.emoji }}</span>
          <div>
            <div class="pname">{{ media.title }}</div>
            <div class="pmeta">{{ currentEp }} / {{ media.episodes }} 集 · {{ media.epDuration }}<span v-if="media.openingSong"> · 🎵 片头曲：{{ media.openingSong }}</span></div>
          </div>
        </div>
        <button class="close" @click="$emit('close')">✕</button>
      </div>

      <!-- 播放舞台：video + 弹幕层 + 演员头像层 叠在一起 -->
      <div class="stage">
        <video
          ref="videoEl"
          class="video"
          :src="media.videoUrl"
          controls
          autoplay
          playsinline
          @play="onPlay"
        >
          您的浏览器不支持 video 标签。
        </video>

        <!-- 弹幕飘屏层（pointer-events:none，不挡原生控件） -->
        <div class="dm-layer" v-show="dmOn">
          <span
            v-for="d in danmakus"
            :key="d.id"
            class="dm"
            :style="{ top: d.top + '%', color: d.color, animationDuration: d.dur + 's' }"
            @animationend="removeDanmaku(d.id)"
          >{{ d.text }}</span>
        </div>

        <!-- 悬浮演员头像：点一下跳到演员主页，看 TA 演过的电视剧 -->
        <div class="cast-bar" v-if="media.actors && media.actors.length">
          <button
            v-for="a in media.actors"
            :key="a.name"
            class="cast-chip"
            :title="'查看 ' + a.name + ' 演过的电视剧'"
            @click="$emit('open-actor', a.name)"
          >
            <img
              v-if="actorAvatar(a) && !failed.has(a.name)"
              class="cast-img"
              :src="actorAvatar(a)"
              :alt="a.name"
              @error="failed.add(a.name)"
            />
            <span v-else class="cast-img initials">{{ firstChar(a.name) }}</span>
            <span class="cast-name">{{ a.name }}</span>
          </button>
        </div>
      </div>

      <!-- 选集 -->
      <div class="ep-list">
        <button
          v-for="n in epButtons"
          :key="n"
          class="ep"
          :class="{ on: n === currentEp }"
          @click="currentEp = n"
        >{{ n }}</button>
      </div>

      <!-- 弹幕发送条 -->
      <div class="dm-bar">
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

      <p class="tip" v-if="!media.openingSong">
        ⚠️ 当前为公开版权演示视频（Big Buck Bunny）。正式上线请替换为你有版权的视频源。
      </p>
      <p class="tip ok" v-else>
        🎬 正在播放片头曲《{{ media.openingSong }}》
      </p>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, reactive, watch, onMounted } from 'vue'
import { resolveActorAvatar } from '../mediaData.js'
import { fetchDanmaku, postDanmaku } from '../danmakuApi.js'

const props = defineProps({
  media: { type: Object, required: true }
})
defineEmits(['close', 'open-actor'])

const videoEl = ref(null)
const currentEp = ref(1)

// 只显示前 12 个选集按钮，避免太长
const epButtons = computed(() => {
  const total = props.media.episodes || 1
  const n = Math.min(total, 12)
  return Array.from({ length: n }, (_, i) => i + 1)
})

// ===================== 弹幕 =====================
const dmOn = ref(true)
const dmText = ref('')
const danmakus = ref([])          // 当前在飞的弹幕
const failed = reactive(new Set()) // 加载失败的演员头像（改用首字兜底）
let dmSeq = 0
let lane = 0
const DM_COLORS = ['#fff', '#ffd479', '#ff8a8a', '#8ad6ff', '#a6f0a6', '#ffb3f0']

function dmKey() {
  return 'dm:' + props.media.id + ':' + currentEp.value
}
// 拉取弹幕：后端优先；后端不可用自动回退本地 localStorage
async function loadDanmaku() {
  danmakus.value = []
  const fromBackend = await fetchDanmaku(String(props.media.id), currentEp.value)
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
  saveDanmaku(text, color) // 本地即时保存
  postDanmaku(String(props.media.id), currentEp.value, text, color, 0) // 同步到后端（多人共享）
  dmText.value = ''
}

// ===================== 演员头像（点击跳演员主页） =====================
function actorAvatar(a) {
  return resolveActorAvatar(a.name, a.avatar)
}
function firstChar(name) {
  return (name || '?').slice(0, 1)
}
function onPlay() { /* 预留：可在这里做播放统计 */ }

// 切换选集时重载该集的弹幕
watch(currentEp, loadDanmaku)
onMounted(loadDanmaku)
</script>

<style scoped>
.player-mask {
  position: fixed;
  inset: 0;
  background: rgba(0, 0, 0, .7);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 999;
  padding: 20px;
}
.player-box {
  width: min(900px, 96vw);
  background: #14141c;
  border-radius: 16px;
  overflow: hidden;
  box-shadow: 0 20px 60px rgba(0, 0, 0, .5);
}
.player-head {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 14px 18px;
  color: #fff;
}
.ptitle { display: flex; align-items: center; gap: 12px; }
.pemoji { font-size: 30px; }
.pname { font-size: 18px; font-weight: bold; }
.pmeta { font-size: 12px; color: #9aa; margin-top: 2px; }
.close {
  background: rgba(255, 255, 255, .1);
  border: none;
  color: #fff;
  width: 34px; height: 34px;
  border-radius: 50%;
  cursor: pointer;
  font-size: 16px;
}
.close:hover { background: rgba(255, 255, 255, .25); }

/* 播放舞台：video 与各叠加层共用同一块区域 */
.stage {
  position: relative;
  background: #000;
  line-height: 0;
}
.video {
  width: 100%;
  display: block;
  background: #000;
  aspect-ratio: 16 / 9;
}

/* 弹幕层：用容器查询单位 cqw 让弹幕从右飞到左，与文字长度无关 */
.dm-layer {
  position: absolute;
  inset: 0;
  overflow: hidden;
  pointer-events: none;
  container-type: inline-size;
}
.dm {
  position: absolute;
  left: 0;
  white-space: nowrap;
  font-size: 18px;
  font-weight: 700;
  text-shadow: 0 1px 3px rgba(0, 0, 0, .9);
  transform: translateX(100cqw);
  animation-name: dm-move;
  animation-timing-function: linear;
  animation-fill-mode: forwards;
  will-change: transform;
}
@keyframes dm-move {
  to { transform: translateX(-100%); }
}

/* 悬浮演员头像（右上角，点一下跳到出场片段） */
.cast-bar {
  position: absolute;
  top: 10px;
  right: 10px;
  display: flex;
  flex-direction: column;
  gap: 8px;
  z-index: 5;
  max-height: 70%;
  overflow: auto;
  padding: 4px;
}
.cast-chip {
  display: flex;
  align-items: center;
  gap: 6px;
  background: rgba(0, 0, 0, .45);
  border: 1px solid rgba(255, 255, 255, .25);
  border-radius: 999px;
  padding: 3px 10px 3px 3px;
  cursor: pointer;
  color: #fff;
  font-size: 12px;
  backdrop-filter: blur(2px);
}
.cast-chip:hover { background: rgba(255, 90, 95, .85); border-color: #ff5a5f; }
.cast-img {
  width: 30px; height: 30px;
  border-radius: 50%;
  object-fit: cover;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 14px;
  font-weight: 700;
  color: #fff;
  background: linear-gradient(135deg, #ff9a9e, #fad0c4);
  flex: 0 0 auto;
}
.cast-img.initials { line-height: 30px; text-align: center; }
.cast-name { white-space: nowrap; }

/* 选集 */
.ep-list {
  display: flex;
  flex-wrap: wrap;
  gap: 8px;
  padding: 14px 18px;
}
.ep {
  min-width: 40px;
  padding: 6px 10px;
  border: 1px solid #333;
  background: #1f1f2b;
  color: #ccc;
  border-radius: 8px;
  cursor: pointer;
  font-size: 13px;
}
.ep.on { background: #ff5a5f; color: #fff; border-color: #ff5a5f; }

/* 弹幕发送条 */
.dm-bar {
  display: flex;
  align-items: center;
  gap: 10px;
  padding: 10px 18px 4px;
}
.dm-toggle {
  font-size: 13px;
  color: #bbb;
  display: flex;
  align-items: center;
  gap: 5px;
  cursor: pointer;
  user-select: none;
}
.dm-toggle.on { color: #ffd479; }
.dm-input {
  flex: 1;
  background: #1f1f2b;
  border: 1px solid #333;
  color: #fff;
  border-radius: 8px;
  padding: 9px 12px;
  font-size: 14px;
  outline: none;
}
.dm-input:focus { border-color: #ff5a5f; }
.dm-send {
  background: #ff5a5f;
  color: #fff;
  border: none;
  border-radius: 8px;
  padding: 9px 18px;
  cursor: pointer;
  font-size: 14px;
}
.dm-send:hover { background: #ff767a; }

.tip {
  padding: 6px 18px 16px;
  color: #888;
  font-size: 12px;
  margin: 0;
}
.tip.ok { color: #6bd089; }
</style>
