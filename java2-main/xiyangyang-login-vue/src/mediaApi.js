// ============================================================
//  影视中心 - 后端数据接口封装
//  说明：电视剧 / 少儿 / 综艺 统一从 Spring Boot 后端数据库读取，
//        这里负责请求接口并把后端字段转换成前端 medias 结构。
//  接口（经 vite 代理 /api -> localhost:8081）：
//    GET /api/drama    返回全部电视剧
//    GET /api/kids     返回全部少儿动画
//    GET /api/variety  返回全部综艺
//  后端统一返回 { code, msg, data }。
// ============================================================

// 公开版权示例视频（与 mediaData.js 保持一致）
const DEMO_VIDEO =
  'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4'

// 每个分类的"单集时长"展示值
const EP_DURATION = {
  drama: '约 43 分钟',
  kids: '约 13 分钟',
  variety: '约 90 分钟'
}

// 每个分类的 id 前缀（避免不同表 id 撞车）
const ID_PREFIX = { drama: 'd', kids: 'k', variety: 'v' }

// 封面解析统一走 mediaData.js：优先按后端路径映射，其次按剧名兜底，
// 这样后端某条数据 cover 为空时也不会退化成纯色占位图
import { resolveCover } from './mediaData.js'

// 把后端一行记录转换成前端 medias 的一项
function toMedia(row, category) {
  const genres = (row.genres || '').split(',').map(s => s.trim()).filter(Boolean)

  // episodes 在库里是描述性文本（如 "200+集"、"58集"、"已完结"），这里尽量解析出数字 + 单位
  let episodes = row.episodes
  let epUnit = ' 集'
  if (typeof episodes === 'string') {
    let m = episodes.match(/(\d+)\s*\+/)                 // 200+集
    if (m) {
      episodes = parseInt(m[1], 10)
    } else if ((m = episodes.match(/(\d+)\s*集/))) {      // 530集 / 58集
      episodes = parseInt(m[1], 10)
    } else if ((m = episodes.match(/第[^\d]*(\d+)\s*季/))) { // 第1-2季
      episodes = parseInt(m[1], 10)
      epUnit = ' 季'
    } else {
      epUnit = '' // 已完结 / 多季 等，原样显示
    }
  }

  let actors = []
  try {
    actors = row.cast ? JSON.parse(row.cast) : []
  } catch (e) {
    actors = []
  }

  return {
    id: (ID_PREFIX[category] || 'x') + row.id,
    category,
    title: row.title,
    year: row.year,
    genres,
    episodes,
    epUnit,
    epDuration: EP_DURATION[category] || '—',
    emoji: row.emoji,
    gradient: row.gradient,
    cover: resolveCover(row.cover, row.title),
    desc: row.description,
    actors,
    videoUrl: DEMO_VIDEO
  }
}

// 拉取单个列表，返回 data 数组（失败返回空数组）
async function fetchList(path) {
  const res = await fetch(path)
  const data = await res.json()
  if (data && data.code === 200 && Array.isArray(data.data)) {
    return data.data
  }
  return []
}

// 分别拉取三类数据，sort 可为 'hot' | 'score'（默认按后端热度倒序）
export async function loadDrama(sort) {
  const q = sort ? `?sort=${encodeURIComponent(sort)}` : ''
  return fetchList('/api/drama' + q).then(rows => rows.map(r => toMedia(r, 'drama')))
}

// 按关键词向后端搜索电视剧（剧名 / 类型 / 演员 / 标签）。
// 成功返回 media 数组；失败（后端未启动 / 接口异常）返回 null，供前端回退到本地过滤。
export async function searchDramas(keyword) {
  try {
    const res = await fetch('/api/drama/search?keyword=' + encodeURIComponent(keyword || ''))
    const data = await res.json()
    if (data && data.code === 200 && Array.isArray(data.data)) {
      return data.data.map(r => toMedia(r, 'drama'))
    }
    return null
  } catch (e) {
    return null
  }
}
export async function loadKids(sort) {
  const q = sort ? `?sort=${encodeURIComponent(sort)}` : ''
  return fetchList('/api/kids' + q).then(rows => rows.map(r => toMedia(r, 'kids')))
}
export async function loadVariety(sort) {
  const q = sort ? `?sort=${encodeURIComponent(sort)}` : ''
  return fetchList('/api/variety' + q).then(rows => rows.map(r => toMedia(r, 'variety')))
}

// 并发拉取电视剧 + 少儿 + 综艺，转换后合并返回
export async function loadAllMedia(sort) {
  const [drama, kids, variety] = await Promise.all([
    loadDrama(sort),
    loadKids(sort),
    loadVariety(sort)
  ])
  return [...drama, ...kids, ...variety]
}

// 兼容旧调用
export async function loadKidsVariety() {
  return Promise.all([loadKids(), loadVariety()]).then(([k, v]) => [...k, ...v])
}
