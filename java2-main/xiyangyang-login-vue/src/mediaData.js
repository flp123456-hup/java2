// ============================================================
//  影视中心数据（演示用 Mock 数据）
//  说明：
//   1. 剧集封面 cover 目前是占位图（渐变 + emoji），不是真实剧照。
//      拿到授权封面后，把图片放进 src/assets/covers/ 并填 cover 路径即可。
//   2. videoUrl 用的是公开版权的示例视频（Big Buck Bunny, Creative Commons），
//      仅作"能播放"演示。正式上线请替换为你有版权的视频源。
//   3. 演员资料为公开事实信息；不确定阵容的剧已标注"待补充"，请按真实情况填写。
// ============================================================

// 公开版权示例视频（Big Buck Bunny，Google 公共示例桶，CC 授权）
const DEMO_VIDEO =
  'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4'

// 每集时长统一标注（演示值）
const EP_DURATION = '约 43 分钟'

export const categories = [
  { key: 'all', label: '全部' },
  { key: 'drama', label: '电视剧' },
  { key: 'kids', label: '少儿' },
  { key: 'variety', label: '综艺' }
]

export const medias = [
  // ===================== 电视剧 =====================
  {
    id: 'd1',
    category: 'drama',
    title: '三生三世十里桃花',
    year: 2017,
    genres: ['古装', '仙侠', '爱情'],
    episodes: 58,
    epDuration: EP_DURATION,
    emoji: '🌸',
    gradient: 'linear-gradient(135deg,#ff9a9e,#fad0c4)',
    desc: '青丘女君白浅与九重天太子夜华历经三世情缘，前世今生纠缠不绝的仙侠爱情故事。',
    // 真实演员公开资料（节选）
    actors: [
      { name: '杨幂', role: '白浅 / 司音 / 素素', bio: '中国女演员、歌手、制片人。1986 年出生于北京，因《宫锁心玉》走红，代表作《三生三世十里桃花》《亲爱的翻译官》等。' },
      { name: '赵又廷', role: '夜华 / 墨渊', bio: '中国台湾男演员。1984 年出生，代表作《搜索》《三生三世十里桃花》等，与杨幂因本剧结为夫妻。' }
    ],
    videoUrl: DEMO_VIDEO
  },
  {
    id: 'd2',
    category: 'drama',
    title: '因为遇见你',
    year: 2017,
    genres: ['都市', '励志', '情感'],
    episodes: 46,
    epDuration: EP_DURATION,
    emoji: '🧵',
    gradient: 'linear-gradient(135deg,#a1c4fd,#c2e9fb)',
    desc: '弃婴张果果被苏州绣艺世家收养，成长为优秀刺绣天才的励志故事。',
    actors: [
      { name: '孙怡', role: '张果果 / 张雨欣', bio: '中国女演员。1993 年出生于吉林，代表作《因为遇见你》《步步惊心丽》等。' },
      { name: '邓伦', role: '李云恺', bio: '中国男演员。1992 年出生于河北，代表作《因为遇见你》《香蜜沉沉烬如霜》等。' }
    ],
    videoUrl: DEMO_VIDEO
  },
  {
    id: 'd3',
    category: 'drama',
    title: '嫁金钗',
    year: 2022,
    genres: ['古装', '甜宠'],
    episodes: 24,
    epDuration: EP_DURATION,
    emoji: '💍',
    gradient: 'linear-gradient(135deg,#f6d365,#fda085)',
    desc: '（示例条目）古装甜宠题材剧集。演员阵容与简介请按真实情况补充。',
    actors: [
      { name: '待补充', role: '—', bio: '请在此填写真实演员的公开资料。' }
    ],
    videoUrl: DEMO_VIDEO
  },
  {
    id: 'd4',
    category: 'drama',
    title: '沉香如故',
    year: 2023,
    genres: ['古装', '仙侠'],
    episodes: 40,
    epDuration: EP_DURATION,
    emoji: '🌿',
    gradient: 'linear-gradient(135deg,#84fab0,#8fd3f4)',
    desc: '（示例条目）古装仙侠题材剧集。演员阵容与简介请按真实情况补充。',
    actors: [
      { name: '待补充', role: '—', bio: '请在此填写真实演员的公开资料。' }
    ],
    videoUrl: DEMO_VIDEO
  },
  {
    id: 'd5',
    category: 'drama',
    title: '香蜜沉沉烬如霜',
    year: 2018,
    genres: ['古装', '仙侠', '爱情'],
    episodes: 63,
    epDuration: EP_DURATION,
    emoji: '🔥',
    gradient: 'linear-gradient(135deg,#ff6a88,#ff99ac)',
    desc: '花神之女锦觅与天帝之子旭凤跨越生死、历经劫难的仙侠虐恋。',
    actors: [
      { name: '杨紫', role: '锦觅', bio: '中国女演员。1992 年出生于长沙，童星出道，代表作《香蜜沉沉烬如霜》《亲爱的，热爱的》等。' },
      { name: '邓伦', role: '旭凤', bio: '中国男演员。1992 年出生于河北，代表作《因为遇见你》《香蜜沉沉烬如霜》等。' }
    ],
    videoUrl: DEMO_VIDEO
  },

  // ===================== 少儿 =====================
  {
    id: 'k1',
    category: 'kids',
    title: '熊出没',
    year: 2012,
    genres: ['动画', '少儿', '喜剧'],
    episodes: 104,
    epDuration: '约 13 分钟',
    emoji: '🐻',
    gradient: 'linear-gradient(135deg,#43e97b,#38f9d7)',
    desc: '森林里熊大、熊二与光头强之间妙趣横生的护林故事，寓教于乐。',
    actors: [
      { name: '熊大', role: '主角（熊）', bio: '聪明勇敢的狗熊哥哥，带领弟弟熊二保护森林。' },
      { name: '熊二', role: '主角（熊）', bio: '憨厚贪吃的狗熊弟弟，常与熊大一起对付光头强。' },
      { name: '光头强', role: '伐木工', bio: '想砍树赚钱的伐木工，常与两头熊斗智斗勇。' }
    ],
    videoUrl: DEMO_VIDEO
  },
  {
    id: 'k2',
    category: 'kids',
    title: '喜羊羊与灰太狼',
    year: 2005,
    genres: ['动画', '少儿', '喜剧'],
    episodes: 530,
    epDuration: '约 13 分钟',
    emoji: '🐑',
    gradient: 'linear-gradient(135deg,#fddb92,#d1fdff)',
    desc: '青青草原上，喜羊羊等小羊与灰太狼之间永不停歇的欢乐较量。',
    actors: [
      { name: '喜羊羊', role: '主角（羊）', bio: '聪明机智的羊村小英雄，总能想出办法化解危机。' },
      { name: '灰太狼', role: '反派（狼）', bio: '执着抓羊的狼，口头禅"我一定会回来的！"，其实很爱家人。' }
    ],
    videoUrl: DEMO_VIDEO
  },
  {
    id: 'k3',
    category: 'kids',
    title: '巴啦啦小魔仙',
    year: 2008,
    genres: ['动画', '少儿', '奇幻'],
    episodes: 52,
    epDuration: '约 22 分钟',
    emoji: '✨',
    gradient: 'linear-gradient(135deg,#c471f5,#fa71cd)',
    desc: '平凡女孩美琪、美雪结识魔仙小蓝，开启守护正义的魔法冒险。',
    actors: [
      { name: '小蓝', role: '魔仙', bio: '来自魔仙堡的魔仙，负责引导两位人类女孩学习魔法。' },
      { name: '美琪 / 美雪', role: '主角（人类）', bio: '一对姐妹，意外获得魔法能量，成为实习小魔仙。' }
    ],
    videoUrl: DEMO_VIDEO
  },

  // ===================== 综艺 =====================
  {
    id: 'v1',
    category: 'variety',
    title: '现在就出发',
    year: 2023,
    genres: ['综艺', '真人秀', '户外'],
    episodes: 12,
    epDuration: '约 90 分钟',
    emoji: '🎤',
    gradient: 'linear-gradient(135deg,#fa709a,#fee140)',
    desc: '（示例条目）户外真人秀综艺。嘉宾阵容与简介请按真实情况补充。',
    actors: [
      { name: '待补充', role: '—', bio: '请在此填写真实嘉宾的公开资料。' }
    ],
    videoUrl: DEMO_VIDEO
  }
]
