<template>
  <div class="dashboard">
    <header class="topbar">
      <div class="brand">🐼 熊猫后台管理系统</div>
      <button class="logout" @click="$emit('logout')">退出后台</button>
    </header>

    <main class="content">
      <!-- 顶部标签页：用户管理 / 下载管理 / 观看历史 -->
      <nav class="tabs">
        <button class="tab" :class="{ on: tab === 'users' }" @click="tab = 'users'">🧑‍💼 用户管理</button>
        <button class="tab" :class="{ on: tab === 'downloads' }" @click="tab = 'downloads'">⬇️ 下载管理</button>
        <button class="tab" :class="{ on: tab === 'history' }" @click="tab = 'history'; loadHistory()">🕐 观看历史</button>
      </nav>

      <!-- ============ 用户管理 ============ -->
      <section v-if="tab === 'users'">
        <div class="stat-row">
          <div class="stat"><div class="num">{{ users.length }}</div><div class="label">注册用户</div></div>
          <div class="stat"><div class="num">{{ totalLogins }}</div><div class="label">累计登录次数</div></div>
          <div class="stat"><div class="num">{{ activeUsers }}</div><div class="label">有登录记录的用户</div></div>
        </div>

        <p class="tip" v-if="usersErr">无法连接后端服务（/api/admin/users），请确认后端(8081)已启动并导入数据库。</p>

        <div class="table-box" v-else>
          <table class="user-table">
            <thead>
              <tr>
                <th>头像</th>
                <th>用户名</th>
                <th>注册时间</th>
                <th>登录次数</th>
                <th>最近登录</th>
                <th>操作</th>
              </tr>
            </thead>
            <tbody>
              <tr
                v-for="u in users"
                :key="u.id"
                :class="{ sel: selected && selected.username === u.username }"
                @click="toggleDetail(u)"
              >
                <td>
                  <img
                    class="u-avatar"
                    :src="u.avatar || '/avatars/user-avatar.jpg'"
                    :alt="u.username"
                    @error="onAvatarError"
                  />
                </td>
                <td class="u-name">{{ u.username }}</td>
                <td>{{ u.createTime || '—' }}</td>
                <td><span class="cnt">{{ u.loginCount }}</span> 次</td>
                <td>{{ u.lastLoginTime || '从未登录' }}</td>
                <td><button class="view-btn" @click.stop="toggleDetail(u)">👁 查看登录数据</button></td>
              </tr>
            </tbody>
          </table>
          <p class="empty" v-if="!users.length">暂无注册用户</p>
        </div>

        <!-- 点进某个用户：登录数据明细 -->
        <div class="detail-box" v-if="selected">
          <div class="d-head">
            <img class="u-avatar" :src="selected.avatar || '/avatars/user-avatar.jpg'" :alt="selected.username" @error="onAvatarError" />
            <div>
              <div class="d-name">{{ selected.username }} 的登录数据</div>
              <div class="d-sub">共 {{ selected.loginCount }} 次登录<span v-if="selected.lastLoginTime">，最近一次 {{ selected.lastLoginTime }}</span></div>
            </div>
            <button class="close-d" @click="selected = null">✕</button>
          </div>
          <ol class="login-list" v-if="selected.records && selected.records.length">
            <li v-for="(t, i) in selected.records" :key="i">
              <span class="l-no">#{{ selected.records.length - i }}</span>
              <span class="l-time">{{ t }}</span>
            </li>
          </ol>
          <p class="empty" v-else>该用户还没有登录记录</p>
        </div>
      </section>

      <!-- ============ 下载管理 ============ -->
      <section v-else-if="tab === 'downloads'">
        <div class="stat-row">
          <div class="stat"><div class="num">{{ downloads.length }}</div><div class="label">影视条目</div></div>
          <div class="stat"><div class="num">{{ availableNum }}</div><div class="label">可下载片源</div></div>
        </div>

        <div class="table-box">
          <table class="user-table dl-table">
            <thead>
              <tr>
                <th>封面</th>
                <th>标题</th>
                <th>分类</th>
                <th>集数</th>
                <th>片源</th>
                <th>操作</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="m in downloads" :key="m.id">
                <td>
                  <div class="dl-poster" :style="{ background: m.gradient }">
                    <img v-if="m.cover" :src="m.cover" :alt="m.title" @error="onPosterError" />
                    <span v-else>{{ m.emoji }}</span>
                  </div>
                </td>
                <td class="u-name">{{ m.title }}</td>
                <td>{{ catLabel(m.category) }}</td>
                <td>{{ m.episodes }}{{ m.epUnit || ' 集' }}</td>
                <td>
                  <span class="ok" v-if="m.videoUrl">✅ 有片源</span>
                  <span class="no-src" v-else>⚪ 暂无片源</span>
                </td>
                <td>
                  <a v-if="m.videoUrl" class="dl-btn" :href="m.videoUrl" :download="m.title + '.mp4'">⬇ 下载</a>
                  <span v-else class="dl-disabled">不可下载</span>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
        <p class="tip">说明：点击「⬇ 下载」会直接下载该片源视频文件（当前只有带片头曲的 7 部剧有真实片源）。</p>
      </section>

      <!-- ============ 观看历史 ============ -->
      <section v-else-if="tab === 'history'">
        <div class="hist-head">
          <h3>🕐 观看历史 <small>({{ history.length }} 部)</small></h3>
          <button class="hist-clear" @click="onClearHistory">🗑 清空</button>
        </div>
        <div class="hist-grid" v-if="history.length">
          <div
            class="hist-card"
            v-for="h in history"
            :key="'h-' + h.title"
            :style="{ '--g': h.gradient || 'linear-gradient(135deg,#7b8cff,#b14dff)' }"
          >
            <div class="poster">
              <img v-if="h.cover" class="poster-img" :src="h.cover" :alt="h.title" @error="onPosterError" />
              <span v-else>{{ h.emoji || '🎬' }}</span>
            </div>
            <div class="info">
              <div class="name">{{ h.title }}</div>
              <div class="meta">看到第 {{ h.ep }} 集 · {{ fmtTs(h.ts) }}</div>
            </div>
          </div>
        </div>
        <p class="empty" v-else>暂无观看历史，去首页看部剧吧～</p>
      </section>
    </main>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import { medias, categories } from '../mediaData.js'
import { getHistory, fmtTs, clearHistory } from '../watchHistory.js'

defineEmits(['logout'])

const tab = ref('users')

// ===================== 用户管理 =====================
const users = ref([])
const usersErr = ref(false)
const selected = ref(null) // 当前点进去查看登录数据的用户

async function loadUsers() {
  usersErr.value = false
  try {
    const res = await fetch('/api/admin/users')
    const data = await res.json()
    if (data.code === 200 && Array.isArray(data.data)) {
      users.value = data.data
    } else {
      usersErr.value = true
    }
  } catch (e) {
    usersErr.value = true
  }
}
onMounted(() => { loadUsers(); loadHistory() })

const totalLogins = computed(() => users.value.reduce((s, u) => s + (u.loginCount || 0), 0))
const activeUsers = computed(() => users.value.filter(u => (u.loginCount || 0) > 0).length)

// 点进某个用户 → 展示该用户的登录数据（登录记录明细）
function toggleDetail(u) {
  selected.value = selected.value && selected.value.username === u.username ? null : u
}

// 头像加载失败兜底：换成本地默认头像
function onAvatarError(e) {
  e.target.src = '/avatars/user-avatar.jpg'
}
function onPosterError(e) {
  e.target.style.display = 'none'
}

function catLabel(key) {
  return categories.find(c => c.key === key)?.label || key
}

// ===================== 下载管理 =====================
const downloads = ref(medias)
const availableNum = computed(() => downloads.value.filter(m => m.videoUrl).length)

// ===================== 观看历史 =====================
const history = ref([])
function loadHistory() { history.value = getHistory() }
function onClearHistory() { clearHistory(); history.value = [] }
</script>

<style scoped>
.dashboard {
  min-height: 100vh;
  background: #f4f6f9;
}

.topbar {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 14px 28px;
  background: #fff;
  box-shadow: 0 2px 8px rgba(0, 0, 0, .06);
}

.brand {
  font-size: 17px;
  font-weight: bold;
  color: #333;
}

.logout {
  padding: 8px 18px;
  border: none;
  border-radius: 8px;
  background: #e74c3c;
  color: #fff;
  font-size: 14px;
  cursor: pointer;
}

.logout:hover { background: #c0392b; }

.content {
  max-width: 1000px;
  margin: 26px auto;
  padding: 0 20px 40px;
}

/* 标签页 */
.tabs { display: flex; gap: 10px; margin-bottom: 22px; }
.tab {
  padding: 9px 22px;
  border-radius: 10px;
  border: 1px solid #d5dbe4;
  background: #fff;
  color: #555;
  font-size: 14px;
  cursor: pointer;
  transition: all .15s;
}
.tab:hover { border-color: #7ec850; color: #4ca331; }
.tab.on { background: #5fb83d; border-color: #5fb83d; color: #fff; font-weight: bold; }

/* 统计卡片 */
.stat-row { display: flex; gap: 18px; margin-bottom: 22px; }
.stat {
  flex: 1;
  background: #fff;
  border-radius: 14px;
  padding: 20px 0;
  text-align: center;
  box-shadow: 0 4px 14px rgba(0, 0, 0, .06);
}
.stat .num { font-size: 28px; font-weight: 800; color: #5fb83d; }
.stat .label { margin-top: 6px; color: #777; font-size: 13px; }

.tip { color: #888; font-size: 14px; margin: 10px 0 16px; }
.tip + .tip { margin-top: -8px; }

/* 表格 */
.table-box {
  background: #fff;
  border-radius: 14px;
  padding: 8px 16px 16px;
  box-shadow: 0 4px 14px rgba(0, 0, 0, .06);
  overflow-x: auto;
}
.user-table { width: 100%; border-collapse: collapse; font-size: 14px; }
.user-table th {
  text-align: left;
  color: #888;
  font-weight: 600;
  padding: 12px 10px;
  border-bottom: 1px solid #edf0f4;
  white-space: nowrap;
}
.user-table td { padding: 10px; border-bottom: 1px solid #f3f5f8; vertical-align: middle; }
.user-table tbody tr { cursor: pointer; transition: background .12s; }
.user-table tbody tr:hover { background: #f6faf3; }
.user-table tbody tr.sel { background: #eef7e8; }
.u-avatar {
  width: 44px; height: 44px;
  border-radius: 50%;
  object-fit: cover;
  border: 2px solid #e2f0d8;
  background: #f2f2f2;
}
.u-name { font-weight: 700; color: #333; }
.cnt { font-weight: 800; color: #e67e22; }
.view-btn {
  padding: 6px 12px;
  border: 1px solid #cfe3bf;
  background: #f3faec;
  color: #4ca331;
  border-radius: 8px;
  font-size: 13px;
  cursor: pointer;
  white-space: nowrap;
}
.view-btn:hover { background: #e2f0d8; }

.empty { color: #999; text-align: center; padding: 26px; }

/* 登录数据明细 */
.detail-box {
  margin-top: 20px;
  background: #fff;
  border-radius: 14px;
  padding: 18px 20px;
  box-shadow: 0 4px 14px rgba(0, 0, 0, .06);
}
.d-head { display: flex; align-items: center; gap: 14px; margin-bottom: 14px; }
.d-name { font-size: 16px; font-weight: 800; color: #333; }
.d-sub { font-size: 13px; color: #888; margin-top: 4px; }
.close-d {
  margin-left: auto;
  border: none;
  background: #f0f0f0;
  width: 30px; height: 30px;
  border-radius: 50%;
  cursor: pointer;
  color: #666;
}
.close-d:hover { background: #e74c3c; color: #fff; }
.login-list { list-style: none; margin: 0; padding: 0; max-height: 260px; overflow-y: auto; }
.login-list li {
  display: flex;
  align-items: center;
  gap: 14px;
  padding: 8px 6px;
  border-bottom: 1px dashed #eef0f3;
  font-size: 14px;
  color: #555;
}
.l-no { color: #aaa; font-size: 12px; width: 44px; }
.l-time { font-family: Consolas, monospace; }

/* 下载管理 */
.dl-table tbody tr { cursor: default; }
.dl-table tbody tr:hover { background: #fafcff; }
.dl-poster {
  width: 52px; height: 52px;
  border-radius: 10px;
  display: flex; align-items: center; justify-content: center;
  font-size: 24px;
  overflow: hidden;
}
.dl-poster img { width: 100%; height: 100%; object-fit: cover; display: block; }
.ok { color: #27ae60; font-weight: 600; }
.no-src { color: #aaa; }
.dl-btn {
  display: inline-block;
  padding: 6px 14px;
  border-radius: 8px;
  background: #5fb83d;
  color: #fff;
  text-decoration: none;
  font-size: 13px;
  font-weight: 600;
}
.dl-btn:hover { background: #4ca331; }
.dl-disabled { color: #bbb; font-size: 13px; }

/* 观看历史 */
.hist-head { display: flex; align-items: baseline; justify-content: space-between; margin-bottom: 16px; }
.hist-head h3 { font-size: 18px; color: #333; }
.hist-head h3 small { color: #999; font-size: 13px; font-weight: 400; margin-left: 6px; }
.hist-clear {
  padding: 6px 14px; border: 1px solid #e7b3a8; background: #fdecea; color: #d9534f;
  border-radius: 8px; font-size: 13px; cursor: pointer; transition: background .15s;
}
.hist-clear:hover { background: #f9d6d2; }
.hist-grid { display: grid; grid-template-columns: repeat(6, 1fr); gap: 14px; }
.hist-card {
  background: #fff; border-radius: 14px; overflow: hidden;
  border: 1px solid #edf0f4; box-shadow: 0 4px 14px rgba(0,0,0,.06);
  transition: transform .15s, box-shadow .15s;
}
.hist-card:hover { transform: translateY(-4px); box-shadow: 0 10px 24px rgba(0,0,0,.12); }
.hist-card .poster {
  aspect-ratio: 3 / 4; display: flex; align-items: center; justify-content: center;
  font-size: 40px; background: var(--g); overflow: hidden;
}
.hist-card .poster-img { width: 100%; height: 100%; object-fit: cover; display: block; }
.hist-card .info { padding: 10px 12px; }
.hist-card .name { font-size: 14px; font-weight: 700; color: #333; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
.hist-card .meta { font-size: 12px; color: #999; margin-top: 6px; }
@media (max-width: 980px) { .hist-grid { grid-template-columns: repeat(3, 1fr); } }
@media (max-width: 620px) { .hist-grid { grid-template-columns: repeat(2, 1fr); } }
</style>
