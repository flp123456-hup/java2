// ============================================================
//  影视中心数据（演示用 Mock 数据）
//  说明：
//   1. 剧集封面 cover：图片放 src/assets/covers/，由 Vite 打包；
//      同时在下方 COVER_MAP / COVER_BY_TITLE 里登记，后端只存 "/covers/xxx.jpg" 路径即可。
//   2. videoUrl 用的是公开版权的示例视频（Big Buck Bunny, Creative Commons），
//      仅作"能播放"演示。正式上线请替换为你有版权的视频源。
//   3. 演员资料为公开事实信息；不确定阵容的剧已标注"待补充"，请按真实情况填写。
// ============================================================

// 封面图片以模块方式引入（Vite 会处理路径与打包，开发与生产环境都稳定）
import coverSansheng from './assets/covers/sanshengsanshi.jpg'
import coverXiangmi from './assets/covers/xiangmi.webp'
import coverChenxiang from './assets/covers/chenxiang.jpg'
import coverYujian from './assets/covers/yujian.jpg'
import coverJiajinchai from './assets/covers/jiajinchai.jpg'
import coverHoulang from './assets/covers/houlang.jpg'

// 新增 12 部剧的真实封面（图片放在 src/assets/covers/，由 Vite 打包）
import coverQieshi from './assets/covers/qieshitianxia.jpg'
import coverLinjiang from './assets/covers/linjiangxian.webp'
import coverXuwoyaoyan from './assets/covers/xuwoyaoyan.webp'
import coverHuaqiangu from './assets/covers/huaqiangu.webp'
import coverBaiyue from './assets/covers/baiyuefanxing.jpg'
import coverChanggexing from './assets/covers/changgexing.jpg'
import coverQingqing from './assets/covers/qingqingrichang.jpg'
import coverChenqianqian from './assets/covers/chenqianqian.jpg'
import coverXinghan from './assets/covers/xinghancanlan.jpg'
import coverChangyue from './assets/covers/changyuejinming.jpg'
import coverLaojiumen from './assets/covers/laojiumen.jpg'
import coverZhuyu from './assets/covers/zhuyu.jpg'
import coverZiye from './assets/covers/ziyegui.jpg'

// 少儿动画封面（7 部）
import coverXiong from './assets/covers/xiongchumo.png'
import coverBalala from './assets/covers/balala.jpg'
import coverFeixia from './assets/covers/chaojifeixia.webp'
import coverPeiqi from './assets/covers/xiaozhupeiji.jpg'
import coverXiyangyang from './assets/covers/xiyangyang.jpg'
import coverHaimian from './assets/covers/haimianbaobao.jpg'
import coverZhuzhu from './assets/covers/zhuzhuxia.jpg'

// 综艺封面（6 部）
import coverXiangwang from './assets/covers/xiangwang.webp'
import coverKuaile from './assets/covers/kuaile.jpg'
import coverGeshou from './assets/covers/geshou.jpg'
import coverBenpao from './assets/covers/benpaoba.jpg'
import coverJixian from './assets/covers/jixian.jpg'
import coverXianzaichufa from './assets/covers/xianzaichufa.jpg'

// 后端数据库里的 cover 字段是 "/covers/xxx.jpg" 这样的路径，
// 这里建"后端路径 -> 打包后 URL"的映射，开发 / 生产环境都能正确加载
export const COVER_MAP = {
  '/covers/sanshengsanshi.jpg': coverSansheng,
  '/covers/xiangmi.jpg': coverXiangmi,
  '/covers/xiangmi.webp': coverXiangmi,
  '/covers/chenxiang.jpg': coverChenxiang,
  '/covers/yujian.jpg': coverYujian,
  '/covers/jiajinchai.jpg': coverJiajinchai,
  '/covers/houlang.jpg': coverHoulang,
  // 新增 12 部剧
  '/covers/qieshitianxia.jpg': coverQieshi,
  '/covers/linjiangxian.webp': coverLinjiang,
  '/covers/xuwoyaoyan.webp': coverXuwoyaoyan,
  '/covers/huaqiangu.webp': coverHuaqiangu,
  '/covers/baiyuefanxing.jpg': coverBaiyue,
  '/covers/changgexing.jpg': coverChanggexing,
  '/covers/qingqingrichang.jpg': coverQingqing,
  '/covers/chenqianqian.jpg': coverChenqianqian,
  '/covers/xinghancanlan.jpg': coverXinghan,
  '/covers/changyuejinming.jpg': coverChangyue,
  '/covers/laojiumen.jpg': coverLaojiumen,
  '/covers/zhuyu.jpg': coverZhuyu,
  '/covers/ziyegui.jpg': coverZiye,
  // 少儿动画 7 部
  '/covers/xiongchumo.png': coverXiong,
  '/covers/balala.jpg': coverBalala,
  '/covers/chaojifeixia.webp': coverFeixia,
  '/covers/xiaozhupeiji.jpg': coverPeiqi,
  '/covers/xiyangyang.jpg': coverXiyangyang,
  '/covers/haimianbaobao.jpg': coverHaimian,
  '/covers/zhuzhuxia.jpg': coverZhuzhu,
  // 综艺 6 部
  '/covers/xiangwang.webp': coverXiangwang,
  '/covers/kuaile.jpg': coverKuaile,
  '/covers/geshou.jpg': coverGeshou,
  '/covers/benpaoba.jpg': coverBenpao,
  '/covers/jixian.jpg': coverJixian,
  '/covers/xianzaichufa.jpg': coverXianzaichufa
}

// 剧名 -> 封面：后端某条数据 cover 为空时，按剧名兜底，
// 保证"该有封面的剧一定会显示封面"
export const COVER_BY_TITLE = {
  '三生三世十里桃花': coverSansheng,
  '香蜜沉沉烬如霜': coverXiangmi,
  '沉香如故': coverChenxiang,
  '沉香如屑·沉香重华': coverChenxiang,
  '沉香如屑': coverChenxiang,
  '嫁金钗': coverJiajinchai,
  '后浪': coverHoulang,
  '因为遇见你': coverYujian,
  // 新增 12 部剧
  '且试天下': coverQieshi,
  '临江仙': coverLinjiang,
  '许我耀眼': coverXuwoyaoyan,
  '花千骨': coverHuaqiangu,
  '白月梵星': coverBaiyue,
  '长歌行': coverChanggexing,
  '卿卿日常': coverQingqing,
  '传闻中的陈芊芊': coverChenqianqian,
  '星汉灿烂': coverXinghan,
  '长月烬明': coverChangyue,
  '老九门': coverLaojiumen,
  '逐玉': coverZhuyu,
  '子夜归': coverZiye,
  // 少儿动画 7 部
  '熊出没': coverXiong,
  '巴啦啦小魔仙': coverBalala,
  '超级飞侠': coverFeixia,
  '小猪佩奇': coverPeiqi,
  '喜羊羊与灰太狼': coverXiyangyang,
  '海绵宝宝': coverHaimian,
  '猪猪侠': coverZhuzhu,
  // 综艺 6 部
  '向往的生活': coverXiangwang,
  '快乐大本营': coverKuaile,
  '歌手': coverGeshou,
  '奔跑吧': coverBenpao,
  '极限挑战': coverJixian,
  '现在就出发': coverXianzaichufa
}

// 统一解析封面：优先按后端路径映射，其次按剧名兜底
export function resolveCover(path, title) {
  return COVER_MAP[path] || (path || '') || COVER_BY_TITLE[title] || ''
}

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
    cover: coverSansheng,
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
    cover: coverYujian,
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
    cover: coverJiajinchai,
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
    cover: coverChenxiang,
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
    cover: coverXiangmi,
    desc: '花神之女锦觅与天帝之子旭凤跨越生死、历经劫难的仙侠虐恋。',
    actors: [
      { name: '杨紫', role: '锦觅', bio: '中国女演员。1992 年出生于长沙，童星出道，代表作《香蜜沉沉烬如霜》《亲爱的，热爱的》等。' },
      { name: '邓伦', role: '旭凤', bio: '中国男演员。1992 年出生于河北，代表作《因为遇见你》《香蜜沉沉烬如霜》等。' }
    ],
    videoUrl: DEMO_VIDEO
  },
  {
    id: 'd6',
    category: 'drama',
    title: '后浪',
    year: 2023,
    genres: ['都市', '现实', '励志'],
    episodes: 40,
    epDuration: EP_DURATION,
    emoji: '🌊',
    gradient: 'linear-gradient(135deg,#43cea2,#185a9d)',
    cover: coverHoulang,
    desc: '中医药大学教授任新正辞职创办中医传承班，带领各行业学生传承中医药文化。',
    actors: [
      { name: '吴刚', role: '任新正', bio: '中医药大学教授，辞职创办中医传承班广传中医。' },
      { name: '赵露思', role: '孙头头', bio: '混不吝的传承班开心果，身世成谜的侠气女孩。' },
      { name: '罗一舟', role: '任天真', bio: '任新正之子，成长于中医世家，严谨有血性。' },
      { name: '张萌', role: '杨小红', bio: '精英律师，意外后走进传承班重寻人生。' },
      { name: '江珊', role: '宋灵兰', bio: '名医，任新正事业的最佳同路人。' }
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
    cover: coverXiong,
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
    cover: coverXiyangyang,
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
    cover: coverBalala,
    desc: '平凡女孩美琪、美雪结识魔仙小蓝，开启守护正义的魔法冒险。',
    actors: [
      { name: '小蓝', role: '魔仙', bio: '来自魔仙堡的魔仙，负责引导两位人类女孩学习魔法。' },
      { name: '美琪 / 美雪', role: '主角（人类）', bio: '一对姐妹，意外获得魔法能量，成为实习小魔仙。' }
    ],
    videoUrl: DEMO_VIDEO
  },
  {
    id: 'k4',
    category: 'kids',
    title: '小猪佩奇',
    year: 2004,
    genres: ['动画', '少儿', '启蒙'],
    episodes: 300,
    epDuration: '约 5 分钟',
    emoji: '🐷',
    gradient: 'linear-gradient(135deg,#ffb6c1,#ffdde1)',
    cover: coverPeiqi,
    desc: '粉色小猪佩奇一家温馨有趣的日常，跳泥坑、过生日，陪伴全球小朋友快乐成长。',
    actors: [
      { name: '佩奇', role: '主角（小猪）', bio: '活泼爱跳泥坑的小猪女孩，有个弟弟乔治。' },
      { name: '乔治', role: '弟弟（小猪）', bio: '佩奇的弟弟，最爱抱着恐龙玩具。' }
    ],
    videoUrl: DEMO_VIDEO
  },
  {
    id: 'k5',
    category: 'kids',
    title: '超级飞侠',
    year: 2015,
    genres: ['动画', '少儿', '冒险'],
    episodes: 200,
    epDuration: '约 13 分钟',
    emoji: '✈️',
    gradient: 'linear-gradient(135deg,#4facfe,#00f2fe)',
    cover: coverFeixia,
    desc: '会变形的飞机乐迪环游世界送包裹，和伙伴们帮助各地小朋友解决难题，开阔眼界。',
    actors: [
      { name: '乐迪', role: '主角（飞机）', bio: '最快的飞机快递员，每次都能把包裹准时送达。' },
      { name: '小爱', role: '救援直升机', bio: '热心助人的救援直升机，关键时刻伸援手。' }
    ],
    videoUrl: DEMO_VIDEO
  },
  {
    id: 'k6',
    category: 'kids',
    title: '猪猪侠',
    year: 2005,
    genres: ['动画', '少儿', '冒险'],
    episodes: 500,
    epDuration: '约 15 分钟',
    emoji: '🐭',
    gradient: 'linear-gradient(135deg,#f7971e,#ffd200)',
    cover: coverZhuzhu,
    desc: '小猪猪猪侠化身超级英雄，凭借勇气与智慧守护童话世界的正义，寓教于乐。',
    actors: [
      { name: '猪猪侠', role: '主角（猪）', bio: '贪吃贪玩却充满正义感的小猪，关键时刻总能挺身而出。' },
      { name: '菲菲', role: '伙伴（猪）', bio: '聪明伶俐的小猪女孩，猪猪侠的好搭档。' }
    ],
    videoUrl: DEMO_VIDEO
  },
  {
    id: 'k7',
    category: 'kids',
    title: '海绵宝宝',
    year: 1999,
    genres: ['动画', '少儿', '喜剧'],
    episodes: 260,
    epDuration: '约 11 分钟',
    emoji: '🧽',
    gradient: 'linear-gradient(135deg,#fceabb,#f8b500)',
    cover: coverHaimian,
    desc: '海底比奇堡里，海绵宝宝和派大星一连串无厘头又温暖的爆笑日常，老少皆宜。',
    actors: [
      { name: '海绵宝宝', role: '主角（海绵）', bio: '乐观天真的黄色海绵，最爱抓水母和做蟹黄堡。' },
      { name: '派大星', role: '好友（海星）', bio: '海绵宝宝最好的朋友，呆萌却常常神助攻。' }
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
    cover: coverXianzaichufa,
    desc: '（示例条目）户外真人秀综艺。嘉宾阵容与简介请按真实情况补充。',
    actors: [
      { name: '待补充', role: '—', bio: '请在此填写真实嘉宾的公开资料。' }
    ],
    videoUrl: DEMO_VIDEO
  },
  {
    id: 'v2',
    category: 'variety',
    title: '奔跑吧',
    year: 2014,
    genres: ['综艺', '真人秀', '竞技'],
    episodes: 130,
    epDuration: '约 90 分钟',
    emoji: '🏃',
    gradient: 'linear-gradient(135deg,#f857a6,#ff5858)',
    cover: coverBenpao,
    desc: '国民级户外竞技真人秀，明星分队完成趣味任务，撕名牌名场面频出。',
    actors: [
      { name: '李晨', role: '常驻嘉宾', bio: '“大黑牛”，力量担当，撕名牌高手。' },
      { name: 'Angelababy', role: '常驻嘉宾', bio: '活泼女神，奔跑团早期核心成员。' }
    ],
    videoUrl: DEMO_VIDEO
  },
  {
    id: 'v3',
    category: 'variety',
    title: '极限挑战',
    year: 2015,
    genres: ['综艺', '真人秀', '剧情'],
    episodes: 100,
    epDuration: '约 90 分钟',
    emoji: '🎯',
    gradient: 'linear-gradient(135deg,#0f2027,#2c5364)',
    cover: coverJixian,
    desc: '男人帮在充满反转的剧情任务中斗智斗勇，“这就是命”成经典梗，烧脑又爆笑。',
    actors: [
      { name: '黄磊', role: '常驻嘉宾', bio: '“神算子”老狐狸，智商担当。' },
      { name: '黄渤', role: '常驻嘉宾', bio: '国民影帝，极限男人帮核心。' }
    ],
    videoUrl: DEMO_VIDEO
  },
  {
    id: 'v4',
    category: 'variety',
    title: '快乐大本营',
    year: 1997,
    genres: ['综艺', '访谈', '娱乐'],
    episodes: 1000,
    epDuration: '约 100 分钟',
    emoji: '🎉',
    gradient: 'linear-gradient(135deg,#ff9a9e,#fecfef)',
    cover: coverKuaile,
    desc: '陪伴几代人的国民综艺，游戏、访谈、歌舞，周五晚上的快乐源泉。',
    actors: [
      { name: '何炅', role: '主持人', bio: '“何老师”，快乐家族灵魂主持。' },
      { name: '谢娜', role: '主持人', bio: '搞笑担当，气氛组组长。' }
    ],
    videoUrl: DEMO_VIDEO
  },
  {
    id: 'v5',
    category: 'variety',
    title: '向往的生活',
    year: 2017,
    genres: ['综艺', '慢综艺', '生活'],
    episodes: 80,
    epDuration: '约 90 分钟',
    emoji: '🏡',
    gradient: 'linear-gradient(135deg,#a8e063,#56ab2f)',
    cover: coverXiangwang,
    desc: '蘑菇屋里的慢生活，种菜、做饭、招待客人，用烟火气温暖治愈都市人的疲惫。',
    actors: [
      { name: '黄磊', role: '常驻嘉宾', bio: '蘑菇屋“黄小厨”，美食担当。' },
      { name: '彭昱畅', role: '常驻嘉宾', bio: '活泼懂事的小师弟，干饭主力。' }
    ],
    videoUrl: DEMO_VIDEO
  },
  {
    id: 'v6',
    category: 'variety',
    title: '歌手',
    year: 2013,
    genres: ['综艺', '音乐', '竞演'],
    episodes: 200,
    epDuration: '约 120 分钟',
    emoji: '🎙️',
    gradient: 'linear-gradient(135deg,#6a11cb,#2575fc)',
    cover: coverGeshou,
    desc: '顶尖歌手同台竞演的 Live 音乐综艺，用实力唱腔定义华语乐坛现场水准。',
    actors: [
      { name: '待补充', role: '—', bio: '每季嘉宾阵容不同，请按真实情况补充。' }
    ],
    videoUrl: DEMO_VIDEO
  }
]
