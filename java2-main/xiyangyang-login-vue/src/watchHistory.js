// ============================================================
//  观看历史（localStorage 持久化）
//  首页 HomeView 与影视中心 MediaCenter 共用：
//  - 打开/播放某部剧时调用 addHistory 记录
//  - 首页「观看历史」区块用 getHistory 读取、openHistory 回看
// ============================================================

const KEY = 'panda:watch-history'
const MAX = 30 // 最多保留 30 条

/** 读取全部观看历史（按最近观看排序），异常时返回空数组 */
export function getHistory() {
  try {
    const arr = JSON.parse(localStorage.getItem(KEY) || '[]')
    return Array.isArray(arr) ? arr : []
  } catch (e) {
    return []
  }
}

/**
 * 记录一次观看（同一部剧去重，置顶到最前）
 * item: { id, title, category, cover, emoji, ep }
 */
export function addHistory(item) {
  if (!item || !item.title) return
  try {
    const list = getHistory().filter(h => h.title !== item.title)
    list.unshift({ ...item, ep: item.ep || 1, ts: Date.now() })
    localStorage.setItem(KEY, JSON.stringify(list.slice(0, MAX)))
  } catch (e) { /* 存储满了等异常直接忽略 */ }
}

/** 清空观看历史 */
export function clearHistory() {
  try {
    localStorage.removeItem(KEY)
  } catch (e) { /* ignore */ }
}

/** 时间戳 → "x 分钟前 / x 小时前 / 昨天 / MM-DD" 友好显示 */
export function fmtTs(ts) {
  if (!ts) return ''
  const diff = Date.now() - ts
  const m = Math.floor(diff / 60000)
  if (m < 1) return '刚刚'
  if (m < 60) return m + ' 分钟前'
  const h = Math.floor(m / 60)
  if (h < 24) return h + ' 小时前'
  const d = new Date(ts)
  const pad = n => String(n).padStart(2, '0')
  return `${pad(d.getMonth() + 1)}-${pad(d.getDate())}`
}
