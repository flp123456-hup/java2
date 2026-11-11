// ============================================================
//  弹幕后端接口封装（Spring Boot：GET/POST /api/danmaku）
//  设计：后端不可用时返回 null，调用方自动回退到本地 localStorage，
//        保证「没启动后端也能发弹幕、不报错」。
// ============================================================

const BASE = '/api/danmaku'

// 拉取某视频某集的弹幕，返回 [{ text, color }]；后端不可用返回 null
export async function fetchDanmaku(videoId, ep) {
  try {
    const res = await fetch(`${BASE}?videoId=${encodeURIComponent(videoId)}&ep=${encodeURIComponent(ep)}`)
    const data = await res.json()
    if (data && data.code === 200 && Array.isArray(data.data)) {
      return data.data.map(d => ({ text: d.content, color: d.color || '#fff' }))
    }
  } catch (e) {
    // 后端未启动 / 网络异常：交给调用方走本地兜底
  }
  return null
}

// 发送一条弹幕（best-effort，失败静默忽略，本地已即时显示）
export async function postDanmaku(videoId, ep, text, color, playTime) {
  try {
    await fetch(BASE, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        videoId,
        episode: ep,
        content: text,
        color,
        playTime: playTime || 0
      })
    })
  } catch (e) {
    // 发送失败不影响前端体验
  }
}
