<template>
  <div class="player-mask" @click.self="$emit('close')">
    <div class="player-box">
      <div class="player-head">
        <div class="ptitle">
          <span class="pemoji">{{ media.emoji }}</span>
          <div>
            <div class="pname">{{ media.title }}</div>
            <div class="pmeta">{{ currentEp }} / {{ media.episodes }} 集 · {{ media.epDuration }}</div>
          </div>
        </div>
        <button class="close" @click="$emit('close')">✕</button>
      </div>

      <!-- 真正的播放器：HTML5 <video> -->
      <video
        class="video"
        :src="media.videoUrl"
        controls
        autoplay
        playsinline
      >
        您的浏览器不支持 video 标签。
      </video>

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

      <p class="tip">
        ⚠️ 当前为公开版权演示视频（Big Buck Bunny）。正式上线请替换为你有版权的视频源。
      </p>
    </div>
  </div>
</template>

<script setup>
import { ref, computed } from 'vue'

const props = defineProps({
  media: { type: Object, required: true }
})
defineEmits(['close'])

const currentEp = ref(1)
// 只显示前 12 个选集按钮，避免太长
const epButtons = computed(() => {
  const total = props.media.episodes || 1
  const n = Math.min(total, 12)
  return Array.from({ length: n }, (_, i) => i + 1)
})
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
.video {
  width: 100%;
  display: block;
  background: #000;
  aspect-ratio: 16 / 9;
}
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
.tip {
  padding: 0 18px 16px;
  color: #888;
  font-size: 12px;
  margin: 0;
}
</style>
