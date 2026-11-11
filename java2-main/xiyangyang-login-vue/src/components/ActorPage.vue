<template>
  <div class="ap-mask" @click.self="$emit('close')">
    <div class="ap-box">
      <button class="ap-back" @click="$emit('close')">← 返回</button>

      <!-- 演员信息头 -->
      <div class="ap-head">
        <img
          v-if="avatar && !avatarFail"
          class="ap-avatar"
          :src="avatar"
          :alt="actorName"
          @error="avatarFail = true"
        />
        <span v-else class="ap-avatar initials">{{ firstChar }}</span>
        <div class="ap-info">
          <h2>{{ actorName }}</h2>
          <p class="ap-count">参演电视剧 · {{ dramas.length }} 部</p>
          <p class="ap-bio" v-if="bio">{{ bio }}</p>
        </div>
      </div>

      <h3>🎬 演过的电视剧 <small>点剧集卡片可直接看详情</small></h3>

      <!-- 参演剧集网格 -->
      <div class="ap-grid" v-if="dramas.length">
        <article
          v-for="m in dramas"
          :key="m.id"
          class="ap-card"
          @click="$emit('open-media', m)"
        >
          <div class="ap-cover">
            <img v-if="m.cover" :src="m.cover" :alt="m.title" />
            <span v-else class="ph">{{ m.emoji || '🎞' }}</span>
            <span class="ap-cat">{{ m.year }}</span>
          </div>
          <div class="ap-title">{{ m.title }}</div>
          <div class="ap-meta">{{ (m.genres || []).join(' / ') }}</div>
        </article>
      </div>
      <p v-else class="ap-empty">暂无剧目数据</p>
    </div>
  </div>
</template>

<script setup>
import { ref, computed } from 'vue'
import { resolveActorAvatar } from '../mediaData.js'

const props = defineProps({
  actorName: { type: String, required: true },
  medias: { type: Array, default: () => [] } // MediaCenter 传来的「前端 mock + 后端数据库」合并列表
})
defineEmits(['close', 'open-media'])

const avatarFail = ref(false)
const avatar = computed(() => resolveActorAvatar(props.actorName))
const firstChar = computed(() => (props.actorName || '?').slice(0, 1))

// 该演员出演的所有剧（在合并列表里按 actors / cast 匹配，首页与影视中心两种数据结构都能用）
const dramas = computed(() =>
  (props.medias || []).filter(m => {
    const arr = m.actors || m.cast || []
    return arr.some(a => a.name === props.actorName)
  })
)

// 演员简介：从第一部匹配到的剧里取演员资料
const bio = computed(() => {
  for (const m of dramas.value) {
    const arr = m.actors || m.cast || []
    const a = arr.find(x => x.name === props.actorName)
    if (a && a.bio) return (a.role && a.role !== '—' ? '饰 ' + a.role + '　' : '') + a.bio
  }
  return ''
})
</script>

<style scoped>
.ap-mask {
  position: fixed;
  inset: 0;
  background: rgba(0, 0, 0, .75);
  display: flex;
  align-items: flex-start;
  justify-content: center;
  padding: 40px 16px;
  z-index: 1000; /* 盖过播放器(999)，播放中点头像也能跳出来 */
  overflow: auto;
}
.ap-box {
  position: relative;
  width: min(760px, 96vw);
  background: #16182b;
  border-radius: 16px;
  padding: 24px;
  color: #eee;
}
.ap-back {
  background: #2a2d44;
  color: #fff;
  border: none;
  padding: 7px 14px;
  border-radius: 8px;
  cursor: pointer;
  font-size: 13px;
}
.ap-back:hover { background: #3a3e5c; }

.ap-head {
  display: flex;
  gap: 18px;
  align-items: flex-start;
  margin-top: 18px;
}
.ap-avatar {
  width: 110px;
  height: 110px;
  border-radius: 50%;
  object-fit: cover;
  object-position: center top;
  border: 3px solid #ff5a5f;
  flex: 0 0 auto;
}
.ap-avatar.initials {
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 40px;
  font-weight: bold;
  color: #fff;
  background: linear-gradient(135deg, #ff9a9e, #fad0c4);
}
.ap-info h2 { margin: 4px 0 6px; font-size: 24px; }
.ap-count { color: #ffd479; font-size: 14px; margin: 0 0 8px; font-weight: 600; }
.ap-bio { color: #bcd; font-size: 13px; line-height: 1.7; margin: 0; }

.ap-box h3 { margin: 24px 0 12px; }
.ap-box h3 small { color: #8892a8; font-size: 12px; font-weight: normal; margin-left: 8px; }

.ap-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(150px, 1fr));
  gap: 14px;
}
.ap-card {
  background: #1f2136;
  border-radius: 12px;
  overflow: hidden;
  cursor: pointer;
  transition: transform .15s, background .15s;
}
.ap-card:hover { transform: translateY(-4px); background: #262a44; }
.ap-cover {
  position: relative;
  height: 180px;
  display: flex;
  align-items: center;
  justify-content: center;
  background: #10121f;
}
.ap-cover img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  object-position: center top;
}
.ap-cover .ph { font-size: 48px; }
.ap-cat {
  position: absolute;
  top: 8px; right: 8px;
  background: rgba(0, 0, 0, .5);
  padding: 1px 8px;
  border-radius: 8px;
  font-size: 11px;
  color: #fff;
}
.ap-title { font-weight: bold; font-size: 14px; padding: 8px 10px 0; }
.ap-meta { font-size: 12px; color: #9aa; padding: 2px 10px 10px; }

.ap-empty { color: #8892a8; font-size: 14px; padding: 20px 0; }
</style>
