// ============================================================
//  影视数据准备（首页 HomeView 与搜索页 SearchResults 共用）
//  这里只放"纯数据"逻辑，不依赖 Vue 响应式；组件内部用 ref 包裹。
// ============================================================
import { medias, COVER_BY_TITLE, FUPING_OPENINGS, resolveCover } from './mediaData.js'
import { loadKids, loadVariety } from './mediaApi.js'

// 剧名 → 片头视频地址 的硬编码兜底映射（不依赖后端 / mediaData 的字段匹配）
// 只要剧名在这 7 个里，视频就一定存在，彻底避免"数据来源不同导致视频丢失"
export const OPENING_VIDEO = {
  '长月烬明': '/videos/changyue.mp4',
  '白月梵星': '/videos/baiyue.mp4',
  '香蜜沉沉烬如霜': '/videos/xiangmi.mp4',
  '三生三世十里桃花': '/videos/sansheng.mp4',
  '临江仙': '/videos/linjiang.mp4',
  '嫁金钗': '/videos/jiajin.mp4',
  '逐玉': '/videos/zhuyu.mp4'
}

// 与时俱进的电视剧（Mock 数据，作为兜底；后端可用时会被真实数据覆盖）
export const dramasMock = [
  { id: 1, title: '三生三世十里桃花', genres: ['古装', '仙侠', '爱情'], year: 2017, score: 8.2, hot: 9800, episodes: '58集', status: '经典', emoji: '🌸', gradient: 'linear-gradient(135deg,#ff9a9e,#fad0c4)', cover: COVER_BY_TITLE['三生三世十里桃花'], desc: '青丘女君白浅与九重天太子夜华历经三世情缘，前世今生纠缠不绝的仙侠爱情故事。' },
  { id: 2, title: '因为遇见你', genres: ['都市', '励志', '情感'], year: 2017, score: 7.4, hot: 8200, episodes: '46集', status: '热播', emoji: '🧵', gradient: 'linear-gradient(135deg,#a1c4fd,#c2e9fb)', cover: COVER_BY_TITLE['因为遇见你'], desc: '弃婴张果果被苏州绣艺世家收养，成长为优秀刺绣天才的励志故事。' },
  { id: 3, title: '嫁金钗', genres: ['古装', '甜宠'], year: 2022, score: 7.0, hot: 7000, episodes: '30集', status: '热播', emoji: '💍', gradient: 'linear-gradient(135deg,#f6d365,#fda085)', cover: COVER_BY_TITLE['嫁金钗'], desc: '古装甜宠题材剧集（简介请按真实情况补充）。' },
  { id: 4, title: '沉香如故', genres: ['古装', '仙侠'], year: 2023, score: 7.0, hot: 6900, episodes: '40集', status: '热播', emoji: '🌿', gradient: 'linear-gradient(135deg,#84fab0,#8fd3f4)', cover: COVER_BY_TITLE['沉香如故'], desc: '古装仙侠题材剧集（简介请按真实情况补充）。' },
  { id: 5, title: '香蜜沉沉烬如霜', genres: ['古装', '仙侠', '爱情'], year: 2018, score: 8.0, hot: 9500, episodes: '63集', status: '经典', emoji: '🔥', gradient: 'linear-gradient(135deg,#ff6a88,#ff99ac)', cover: COVER_BY_TITLE['香蜜沉沉烬如霜'], desc: '花神之女锦觅与天帝之子旭凤跨越生死、历经劫难的仙侠虐恋。' },
  { id: 6, title: '后浪', genres: ['都市', '现实', '励志'], year: 2023, score: 7.8, hot: 9200, episodes: '40集', status: '经典', emoji: '🌊', gradient: 'linear-gradient(135deg,#43cea2,#185a9d)', cover: COVER_BY_TITLE['后浪'], desc: '中医药大学教授任新正辞职创办中医传承班，带领各行业学生传承中医药文化。' }
]

// 浮萍片头曲 4 部剧：后端数据库里没有的条目，用这里兜底补齐
export const fupingExtras = [
  { id: 'fp1', title: '长月烬明', genres: ['古装', '仙侠', '爱情'], year: 2023, score: 9.3, hot: 9900, episodes: 40, status: '热播', emoji: '🌑', gradient: 'linear-gradient(135deg,#5b247a,#1bcedf)', desc: '神魔之子澹台烬与衡阳公主黎苏苏跨越五百年宿命纠缠，在爱恨中寻求解脱的仙侠故事。' },
  { id: 'fp2', title: '白月梵星', genres: ['古装', '仙侠', '爱情'], year: 2024, score: 8.5, hot: 9600, episodes: 40, status: '热播', emoji: '🌕', gradient: 'linear-gradient(135deg,#fceabb,#f8b500)', desc: '凡人少女白烁与神族梵樾携手净化妖邪、守护苍生的仙侠冒险。' },
  { id: 'fp3', title: '临江仙', genres: ['古装', '仙侠', '虐恋'], year: 2025, score: 8.6, hot: 9700, episodes: 32, status: '热播', emoji: '🌊', gradient: 'linear-gradient(135deg,#43cea2,#185a9d)', desc: '花如月与白九思从结契到反目，揭秘三界秘辛的仙侠虐恋。' },
  { id: 'fp4', title: '逐玉', genres: ['古装', '悬疑', '爱情'], year: 2025, score: 8.7, hot: 9400, episodes: 40, status: '热播', emoji: '🪶', gradient: 'linear-gradient(135deg,#ee9ca7,#ffdde1)', desc: '将门孤女与寒门谋士联手查案、逐玉寻真的古装悬疑爱情故事。' }
]

// 按剧名合并浮萍固定数据：演员 / 片头视频 / 集数以 FUPING_OPENINGS 为准
export function mergeFuping(item) {
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
export function buildInitialDramas() {
  return [...dramasMock, ...fupingExtras].map(d => ({
    ...d,
    cover: d.cover || COVER_BY_TITLE[d.title] || '',
    cast: []
  })).map(mergeFuping)
}

// 把 mediaData / 后端返回的少儿、综艺条目，规整成首页卡片与弹窗需要的格式
export function toHome(m) {
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

// 把 genres 规整成可匹配 / 可显示的字符串（兼容数组、逗号字符串两种格式）
export function genresText(m) {
  return Array.isArray(m.genres) ? m.genres.join(' / ') : String(m.genres || '')
}

// 演员名列表（电视剧条目存 cast，少儿 / 综艺条目存 actors）
export function castNames(m) {
  const arr = Array.isArray(m.actors) ? m.actors : (m.cast || [])
  return arr.map(a => (typeof a === 'string' ? a : a && a.name)).filter(Boolean)
}

// 按剧名在前端 mediaData 里找完整条目（含演员 / 片头视频）
export function findMediaByTitle(title) {
  return medias.find(m => m.title === title) || null
}

// 按观众评分取前 n 名
export function rankByScore(list, n = 10) {
  return [...list].sort((a, b) => (b.score || 0) - (a.score || 0)).slice(0, n)
}
// 按实时热度取前 n 名
export function rankByHot(list, n = 10) {
  return [...list].sort((a, b) => (b.hot || 0) - (a.hot || 0)).slice(0, n)
}

// 把后端返回的电视剧（genres / cast 为字符串）规整成前端需要的格式
export function parseCast(str) {
  if (!str) return []
  try {
    const v = JSON.parse(str)
    return Array.isArray(v) ? v : []
  } catch (e) {
    return []
  }
}

export function normalize(list) {
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
export async function fetchDramas() {
  try {
    const res = await fetch('/api/drama')
    const data = await res.json()
    if (data.code === 200 && Array.isArray(data.data) && data.data.length) {
      return normalize(data.data)
    }
  } catch (e) { /* 后端未启动：维持 Mock 数据 */ }
  return buildInitialDramas()
}
export async function fetchKids() {
  try {
    const k = await loadKids()
    if (k.length) return k.map(toHome)
  } catch (e) { /* 后端未启动：维持 mediaData 演示数据 */ }
  return medias.filter(m => m.category === 'kids')
}
export async function fetchVariety() {
  try {
    const v = await loadVariety()
    if (v.length) return v.map(toHome)
  } catch (e) { /* 后端未启动：维持 mediaData 演示数据 */ }
  return medias.filter(m => m.category === 'variety')
}
