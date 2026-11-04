<template>
  <div class="mc">
    <header class="mc-top">
      <div class="mc-logo">📺 熊猫影视 · 电视剧</div>
      <button class="mc-back" @click="$emit('close')">← 返回首页</button>
    </header>

    <!-- 分类标签 -->
    <nav class="tabs">
      <button
        v-for="c in categories"
        :key="c.key"
        class="tab"
        :class="{ on: active === c.key }"
        @click="active = c.key"
      >{{ c.label }}</button>
    </nav>

    <!-- 排序：热度 / 评分 -->
    <div class="sortbar">
      <span class="sort-label">排序</span>
      <select class="sort-sel" v-model="sort" @change="reload">
        <option value="hot">热度优先</option>
        <option value="score">评分优先</option>
      </select>
    </div>

    <!-- 卡片网格 -->
    <main class="grid">
      <article
        v-for="m in list"
        :key="m.id"
        class="card"
        @click="openDetail(m)"
      >
        <div class="cover" :style="{ background: m.gradient }">
          <img v-if="m.cover" class="cover-img" :src="m.cover" :alt="m.title" />
          <template v-else>
            <span class="emoji">{{ m.emoji }}</span>
            <span class="ph">封面占位图</span>
          </template>
          <span class="cat">{{ catLabel(m.category) }}</span>
        </div>
        <div class="info">
          <div class="title">{{ m.title }}</div>
          <div class="meta">{{ m.year }} · {{ m.genres.join('/') }}</div>
          <div class="meta">{{ m.episodes }}{{ m.epUnit || ' 集' }} · {{ m.epDuration }}</div>
        </div>
      </article>
    </main>

    <!-- 详情弹窗 -->
    <div v-if="detail" class="detail-mask" @click.self="detail = null">
      <div class="detail-box">
        <button class="x" @click="detail = null">✕</button>

        <div class="d-cover" :style="{ background: detail.gradient }">
          <img v-if="detail.cover" class="cover-img" :src="detail.cover" :alt="detail.title" />
          <template v-else>
            <span class="emoji">{{ detail.emoji }}</span>
            <span class="ph">封面占位图（非真实剧照）</span>
          </template>
        </div>

        <h2>{{ detail.title }}</h2>
        <div class="d-meta">{{ detail.year }} · {{ detail.genres.join(' / ') }} · {{ detail.episodes }}{{ detail.epUnit || ' 集' }} · {{ detail.epDuration }}</div>
        <p class="d-desc">{{ detail.desc }}</p>

        <h3>演员资料</h3>
        <ul class="actors">
          <li v-for="a in detail.actors" :key="a.name">
            <div class="a-name">{{ a.name }} <span class="a-role">饰 {{ a.role }}</span></div>
            <div class="a-bio">{{ a.bio }}</div>
          </li>
        </ul>

        <button class="play" @click="play(detail)">▶ 播放第 1 集</button>
      </div>
    </div>

    <!-- 播放器 -->
    <VideoPlayer v-if="playing" :media="playing" @close="playing = null" />
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import { categories, medias } from '../mediaData.js'
import { loadAllMedia } from '../mediaApi.js'
import VideoPlayer from './VideoPlayer.vue'

defineEmits(['close'])

const active = ref('drama')
const sort = ref('hot')
const detail = ref(null)
const playing = ref(null)

// 初始为前端 mock 数据（兜底）；电视剧/少儿/综艺优先用后端数据库数据覆盖
const allMedias = ref(medias)

const list = computed(() =>
  active.value === 'all' ? allMedias.value : allMedias.value.filter(m => m.category === active.value)
)

// 从后端拉取并覆盖电视剧/少儿/综艺（支持排序）
async function reload() {
  try {
    const fromBackend = await loadAllMedia(sort.value)
    if (fromBackend.length) {
      allMedias.value = medias
        .filter(m => !['drama', 'kids', 'variety'].includes(m.category))
        .concat(fromBackend)
    }
  } catch (e) {
    console.warn('后端影视数据加载失败，继续使用前端 mock：', e)
  }
}

onMounted(reload)

function catLabel(key) {
  return categories.find(c => c.key === key)?.label || key
}
function openDetail(m) {
  detail.value = m
}
function play(m) {
  detail.value = null
  playing.value = m
}
</script>

<style scoped>
.mc {
  min-height: 100vh;
  background: #0f1020;
  color: #eee;
  padding-bottom: 40px;
}
.mc-top {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 16px 28px;
  background: #16182b;
}
.mc-logo { font-size: 20px; font-weight: bold; }
.mc-back {
  background: #2a2d44;
  color: #fff;
  border: none;
  padding: 8px 16px;
  border-radius: 8px;
  cursor: pointer;
}
.mc-back:hover { background: #3a3e5c; }

.tabs {
  display: flex;
  gap: 10px;
  padding: 18px 28px 4px;
}
.tab {
  padding: 8px 20px;
  border-radius: 20px;
  border: 1px solid #333;
  background: #1a1c2e;
  color: #bbb;
  cursor: pointer;
  font-size: 14px;
}
.tab.on { background: #ff5a5f; color: #fff; border-color: #ff5a5f; }

.sortbar {
  display: flex;
  align-items: center;
  gap: 8px;
  padding: 2px 28px 6px;
  color: #bbb;
  font-size: 13px;
}
.sort-sel {
  background: #1a1c2e;
  color: #eee;
  border: 1px solid #333;
  border-radius: 8px;
  padding: 5px 10px;
  font-size: 13px;
  cursor: pointer;
}

.grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(180px, 1fr));
  gap: 18px;
  padding: 18px 28px;
}
.card {
  background: #16182b;
  border-radius: 12px;
  overflow: hidden;
  cursor: pointer;
  transition: transform .15s;
}
.card:hover { transform: translateY(-4px); }
.cover {
  position: relative;
  height: 220px;
  display: flex;
  align-items: center;
  justify-content: center;
}
.cover .emoji { font-size: 64px; }
.cover-img {
  position: absolute;
  inset: 0;
  width: 100%;
  height: 100%;
  object-fit: cover;
  object-position: center top;
}
.cover .cat {
  position: absolute;
  top: 10px; left: 10px;
  background: rgba(0, 0, 0, .45);
  padding: 2px 10px;
  border-radius: 10px;
  font-size: 12px;
}
.cover .ph {
  position: absolute;
  bottom: 8px;
  font-size: 11px;
  color: rgba(255, 255, 255, .8);
}
.info { padding: 10px 12px; }
.title { font-weight: bold; font-size: 15px; }
.meta { font-size: 12px; color: #9aa; margin-top: 4px; }

.detail-mask {
  position: fixed;
  inset: 0;
  background: rgba(0, 0, 0, .7);
  display: flex;
  align-items: flex-start;
  justify-content: center;
  padding: 40px 16px;
  z-index: 998;
  overflow: auto;
}
.detail-box {
  position: relative;
  width: min(680px, 96vw);
  background: #16182b;
  border-radius: 16px;
  padding: 22px;
}
.x {
  position: absolute;
  top: 12px; right: 12px;
  background: rgba(255, 255, 255, .1);
  border: none; color: #fff;
  width: 32px; height: 32px;
  border-radius: 50%; cursor: pointer;
}
.d-cover {
  height: 200px;
  border-radius: 12px;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  gap: 8px;
}
.d-cover .emoji { font-size: 60px; }
.d-cover .ph { font-size: 12px; color: rgba(255, 255, 255, .85); }
.detail-box h2 { margin: 16px 0 4px; }
.d-meta { color: #9aa; font-size: 13px; }
.d-desc { color: #cfd; line-height: 1.7; font-size: 14px; }
.detail-box h3 { margin: 18px 0 8px; }
.actors { list-style: none; padding: 0; margin: 0; display: flex; flex-direction: column; gap: 12px; }
.a-name { font-weight: bold; }
.a-role { color: #ffb86c; font-weight: normal; font-size: 13px; margin-left: 6px; }
.a-bio { color: #bcd; font-size: 13px; line-height: 1.6; margin-top: 4px; }
.play {
  margin-top: 18px;
  width: 100%;
  padding: 12px;
  border: none;
  border-radius: 10px;
  background: #ff5a5f;
  color: #fff;
  font-size: 15px;
  cursor: pointer;
}
.play:hover { background: #ff767a; }
</style>
