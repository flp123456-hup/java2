<template>
  <div class="sv">
    <!-- 顶部栏：返回 + 标题 -->
    <header class="sv-top">
      <button class="back" @click="$emit('close')">← 返回电视剧</button>
      <div class="sv-title">🎬 短视频</div>
      <div class="spacer"></div>
    </header>

    <!-- 竖屏滑动信息流：scroll-snap 让每一条自动吸附整屏 -->
    <div class="feed" ref="feed">
      <section
        class="slide"
        v-for="(v, i) in videos"
        :key="i"
      >
        <video
          class="clip"
          ref="videoEls"
          :src="v.src"
          playsinline
          webkit-playsinline
          preload="metadata"
          loop
          muted
          :poster="''"
          @click="togglePlay(i)"
        ></video>

        <!-- 点击播放/暂停时显示的大播放图标 -->
        <div class="play-cover" v-show="pausedIndex === i" @click="togglePlay(i)">
          <span class="big-play">▶</span>
        </div>

        <!-- 右侧操作栏（装饰 + 点赞可点） -->
        <div class="rail">
          <button class="act" :class="{ liked: v.liked }" @click="like(i)">
            <span class="ico">{{ v.liked ? '❤️' : '🤍' }}</span>
            <span class="num">{{ v.likes }}</span>
          </button>
          <button class="act" @click="scrollDown(i)">
            <span class="ico">💬</span>
            <span class="num">{{ v.comments }}</span>
          </button>
          <button class="act" @click="share(i)">
            <span class="ico">↗</span>
            <span class="num">分享</span>
          </button>
        </div>

        <!-- 底部信息：标题 / 作者 / 简介 -->
        <div class="info">
          <div class="author">@{{ v.author }}</div>
          <div class="name">{{ v.title }}</div>
          <div class="desc">{{ v.desc }}</div>
          <div class="hint" v-if="i === 0">↑ 上滑看下一条</div>
        </div>
      </section>
    </div>

    <!-- 静音开关 -->
    <button class="mute" @click="toggleMute">
      {{ muted ? '🔇 已静音' : '🔊 有声' }}
    </button>
  </div>
</template>

<script setup>
import { ref, onMounted, onBeforeUnmount, nextTick } from 'vue'

defineEmits(['close'])

// 5 个短视频（位于 public/videos，构建后以 /videos/xxx.mp4 访问）
const videos = ref([
  { src: '/videos/short1.mp4', title: '高燃名场面 · 第 1 弹', author: '熊猫影视剪辑', desc: '追剧停不下来，名场面一次看个够～', likes: '1.2w', comments: 328, liked: false },
  { src: '/videos/short2.mp4', title: '催泪瞬间 · 第 2 弹', author: '熊猫影视剪辑', desc: '纸巾备好，这波太上头了！', likes: '8765', comments: 211, liked: false },
  { src: '/videos/short3.mp4', title: '甜虐交织 · 第 3 弹', author: '熊猫影视剪辑', desc: '糖里藏刀，磕到了又破防了。', likes: '2.3w', comments: 540, liked: false },
  { src: '/videos/short4.mp4', title: '反转不断 · 第 4 弹', author: '熊猫影视剪辑', desc: '猜得到开头猜不到结尾。', likes: '6543', comments: 187, liked: false },
  { src: '/videos/short5.mp4', title: '大结局前瞻 · 第 5 弹', author: '熊猫影视剪辑', desc: '结局究竟如何？先睹为快！', likes: '1.5w', comments: 402, liked: false }
])

const feed = ref(null)
const videoEls = ref([])
const pausedIndex = ref(-1) // 当前被手动暂停的那一条；-1 表示全部跟随滚动自动播放
const muted = ref(true)

let observer = null

onMounted(async () => {
  await nextTick()
  // 进入页面先播第一条
  const first = videoEls.value[0]
  if (first) {
    first.muted = muted.value
    first.play().catch(() => {})
  }
  // IntersectionObserver：哪条进入视口中部就播放，离开就暂停并重置
  observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
      const el = entry.target
      if (entry.isIntersecting && entry.intersectionRatio >= 0.6) {
        // 只有当前没被手动暂停时才自动播放
        if (pausedIndex.value !== videoEls.value.indexOf(el)) {
          el.muted = muted.value
          el.play().catch(() => {})
        }
      } else {
        el.pause()
        try { el.currentTime = 0 } catch (e) { /* ignore */ }
      }
    })
  }, { threshold: [0, 0.6, 1] })

  videoEls.value.forEach(el => el && observer.observe(el))
})

onBeforeUnmount(() => {
  if (observer) observer.disconnect()
})

// 点击视频：切换播放 / 暂停
function togglePlay(i) {
  const el = videoEls.value[i]
  if (!el) return
  if (el.paused) {
    el.muted = muted.value
    el.play().catch(() => {})
    pausedIndex.value = -1
  } else {
    el.pause()
    pausedIndex.value = i
  }
}

function like(i) {
  const v = videos.value[i]
  v.liked = !v.liked
  // 数字仅作展示，简单 +1 / -1
  v._base = v._base || parseLikes(v.likes)
  v._base += v.liked ? 1 : -1
  v.likes = formatLikes(v._base)
}
function parseLikes(s) {
  if (typeof s === 'number') return s
  if (s.includes('w')) return Math.round(parseFloat(s) * 10000)
  return parseInt(s, 10) || 0
}
function formatLikes(n) {
  if (n >= 10000) return (n / 10000).toFixed(1).replace(/\.0$/, '') + 'w'
  return String(n)
}

function share(i) {
  const v = videos.value[i]
  if (navigator.share) {
    navigator.share({ title: v.title, text: v.desc, url: location.href }).catch(() => {})
  } else {
    alert('链接已复制，快去分享吧～')
  }
}

// 点评论按钮：滚动到下一条（评论区为演示占位）
function scrollDown(i) {
  const next = videoEls.value[i + 1]
  if (next) next.scrollIntoView({ behavior: 'smooth' })
}

function toggleMute() {
  muted.value = !muted.value
  videoEls.value.forEach(el => { if (el) el.muted = muted.value })
}
</script>

<style scoped>
.sv {
  position: fixed;
  inset: 0;
  background: #000;
  color: #fff;
  overflow: hidden;
  z-index: 1000;
}

/* 顶部栏 */
.sv-top {
  position: absolute;
  top: 0; left: 0; right: 0;
  z-index: 5;
  display: flex;
  align-items: center;
  gap: 12px;
  padding: 14px 16px;
  background: linear-gradient(180deg, rgba(0,0,0,.55), rgba(0,0,0,0));
}
.back {
  background: rgba(255,255,255,.15);
  border: none;
  color: #fff;
  padding: 7px 14px;
  border-radius: 999px;
  font-size: 14px;
  cursor: pointer;
}
.back:hover { background: rgba(255,255,255,.3); }
.sv-title {
  font-size: 17px;
  font-weight: 800;
  background: linear-gradient(90deg, #7b8cff, #ff6ec4);
  -webkit-background-clip: text;
  background-clip: text;
  color: transparent;
}
.spacer { flex: 1; }

/* 滑动信息流 */
.feed {
  height: 100%;
  overflow-y: scroll;
  scroll-snap-type: y mandatory;
  -webkit-overflow-scrolling: touch;
  scrollbar-width: none;
}
.feed::-webkit-scrollbar { display: none; }

.slide {
  position: relative;
  height: 100%;
  scroll-snap-align: start;
  scroll-snap-stop: always;
  display: flex;
  align-items: center;
  justify-content: center;
  background: #000;
}
.clip {
  width: 100%;
  height: 100%;
  object-fit: contain;
  background: #000;
}

/* 暂停时的大播放按钮 */
.play-cover {
  position: absolute;
  inset: 0;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
}
.big-play {
  width: 84px; height: 84px;
  border-radius: 50%;
  background: rgba(0,0,0,.4);
  border: 2px solid rgba(255,255,255,.8);
  display: flex; align-items: center; justify-content: center;
  font-size: 34px; color: #fff;
  backdrop-filter: blur(4px);
}

/* 右侧操作栏 */
.rail {
  position: absolute;
  right: 12px;
  bottom: 120px;
  z-index: 4;
  display: flex;
  flex-direction: column;
  gap: 18px;
}
.act {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 4px;
  background: transparent;
  border: none;
  color: #fff;
  cursor: pointer;
}
.act .ico { font-size: 30px; filter: drop-shadow(0 1px 3px rgba(0,0,0,.6)); }
.act .num { font-size: 12px; text-shadow: 0 1px 3px rgba(0,0,0,.7); }
.act.liked .ico { animation: pop .3s ease; }
@keyframes pop { 0% { transform: scale(1); } 50% { transform: scale(1.35); } 100% { transform: scale(1); } }

/* 底部信息 */
.info {
  position: absolute;
  left: 16px; right: 88px;
  bottom: 28px;
  z-index: 4;
  text-shadow: 0 1px 4px rgba(0,0,0,.8);
}
.info .author { font-size: 15px; font-weight: 800; margin-bottom: 6px; }
.info .name { font-size: 17px; font-weight: 700; margin-bottom: 6px; }
.info .desc { font-size: 14px; line-height: 1.5; opacity: .92; }
.info .hint {
  margin-top: 14px;
  font-size: 12px;
  color: #ffd479;
  animation: floatUp 1.6s ease-in-out infinite;
}
@keyframes floatUp {
  0%, 100% { transform: translateY(0); opacity: .8; }
  50% { transform: translateY(-5px); opacity: 1; }
}

/* 静音开关 */
.mute {
  position: absolute;
  right: 14px; top: 60px;
  z-index: 6;
  background: rgba(0,0,0,.45);
  border: 1px solid rgba(255,255,255,.35);
  color: #fff;
  border-radius: 999px;
  padding: 7px 14px;
  font-size: 13px;
  cursor: pointer;
  backdrop-filter: blur(4px);
}
.mute:hover { background: rgba(0,0,0,.65); }
</style>
