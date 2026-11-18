<template>
  <div class="brain">
    <!-- 星空背景 -->
    <div class="sky">
      <span v-for="s in stars" :key="s.id" class="star" :style="s.style"></span>
      <div class="nebula"></div>
    </div>

    <!-- 顶部栏：返回 + 标题 + 计分 -->
    <header class="b-top">
      <button class="back" @click="$emit('close')">← 返回首页</button>
      <div class="b-title">
        <img :src="brainIcon" class="b-title-ico" alt="" /> 脑力运动 <small>闯关刷题</small>
      </div>
      <div class="b-score">✅ {{ correct }} / {{ answered }}</div>
    </header>

    <!-- 主体 -->
    <main class="b-main">
      <!-- ===== 选卷界面 ===== -->
      <section v-if="stage === 'select'" class="select-panel">
        <h2>选择一套试卷，开始闯关</h2>
        <p class="sub">一道一道来，答对自动下一题，答错显示答案后再进入下一题。</p>
        <div class="paper-cards">
          <button
            v-for="p in papers"
            :key="p.year"
            class="paper-card"
            @click="startPaper(p)"
          >
            <div class="pc-year">{{ p.badge || '📖' }} {{ p.year }}</div>
            <div class="pc-title">{{ p.title }}</div>
            <div class="pc-desc">{{ p.desc }}</div>
            <div class="pc-go">开始挑战 →</div>
          </button>
        </div>
        <div class="tip-box">
          💡 单选 / 判断点选即自动判分；多选题勾选后点「提交答案」（全对才得分）；主观题作答后点「我答对了」或「看答案」自评。答对自动下一题，答错显示答案后再下一题。
        </div>
      </section>

      <!-- ===== 答题界面 ===== -->
      <section v-else-if="stage === 'quiz'" class="quiz-panel">
        <!-- 进度条 -->
        <div class="progress-wrap">
          <div class="progress-info">
            <span>第 {{ index + 1 }} / {{ total }} 题</span>
            <span class="paper-tag">{{ currentPaper.year }} 卷</span>
          </div>
          <div class="progress-bar">
            <div class="progress-fill" :style="{ width: ((index) / total * 100) + '%' }"></div>
          </div>
        </div>

        <!-- 题目卡片 -->
        <div class="q-card">
          <div class="q-head">
            <span class="q-type" :class="'t-' + currentQ.type">{{ typeLabel(currentQ.type) }}</span>
            <span v-if="currentQ.subject" class="q-subject">{{ currentQ.subject }}</span>
            <span class="q-no">#{{ index + 1 }}</span>
          </div>

          <!-- 阅读理解短文 -->
          <div v-if="currentQ.passage" class="passage">
            <div class="passage-label">📖 阅读短文</div>
            <div class="passage-text">{{ currentQ.passage }}</div>
          </div>

          <div class="q-text" v-html="render(currentQ.q)"></div>

          <!-- 选择题选项 -->
          <div v-if="currentQ.type === 'choice'" class="options">
            <button
              v-for="(opt, oi) in currentQ.options"
              :key="oi"
              class="opt"
              :class="optClass(oi)"
              :disabled="locked"
              @click="pickChoice(oi)"
            >
              <span class="opt-key">{{ 'ABCD'[oi] }}</span>
              <span class="opt-text" v-html="render(opt)"></span>
              <span class="opt-mark" v-if="locked && oi === currentQ.answer">✓</span>
              <span class="opt-mark wrong" v-else-if="locked && oi === picked">✗</span>
            </button>
          </div>

          <!-- 多选题选项（勾选后提交，全对才得分） -->
          <div v-else-if="currentQ.type === 'multi'" class="options">
            <button
              v-for="(opt, oi) in currentQ.options"
              :key="oi"
              class="opt"
              :class="multiOptClass(oi)"
              :disabled="locked"
              @click="toggleMulti(oi)"
            >
              <span class="opt-key square">{{ multiPicked.includes(oi) ? '✓' : 'ABCD'[oi] }}</span>
              <span class="opt-text" v-html="render(opt)"></span>
              <span class="opt-mark" v-if="locked && currentQ.answer.includes(oi)">✓</span>
            </button>
            <button class="submit-multi" :disabled="locked || multiPicked.length === 0" @click="submitMulti">
              提交答案（已选 {{ multiPicked.length }} 项）
            </button>
          </div>

          <!-- 判断题选项 -->
          <div v-else-if="currentQ.type === 'judge'" class="options judge-options">
            <button
              v-for="(jb, ji) in judgeBtns"
              :key="ji"
              class="opt judge-opt"
              :class="judgeClass(jb.value)"
              :disabled="locked"
              @click="pickJudge(jb.value)"
            >
              <span class="opt-key">{{ jb.icon }}</span>
              <span class="opt-text">{{ jb.label }}</span>
              <span class="opt-mark" v-if="locked && jb.value === currentQ.answer">✓</span>
              <span class="opt-mark wrong" v-else-if="locked && jb.value === picked">✗</span>
            </button>
          </div>

          <!-- 计算/证明题自评 -->
          <div v-else class="solve-area">
            <div class="solve-hint">先在纸上写出你的解答，然后自评：</div>
            <div class="solve-btns">
              <button class="solve-btn ok" @click="selfGrade(true)">✅ 我答对了</button>
              <button class="solve-btn see" @click="selfGrade(false)">📖 看答案</button>
            </div>
          </div>

          <!-- 答题反馈已改为全屏弹层（答对「太棒了」/ 答错「加油」） -->
        </div>
      </section>

      <!-- ===== 完成界面 ===== -->
      <section v-else class="done-panel">
        <div class="done-emoji">🎊</div>
        <h2>挑战完成！</h2>
        <div class="done-score">
          <div class="ds-num">{{ correct }}<small> / {{ total }}</small></div>
          <div class="ds-label">答对题数</div>
        </div>
        <div class="done-actions">
          <button class="da again" @click="restart">🔁 再做一次</button>
          <button class="da change" @click="backToSelect">📚 换一套试卷</button>
        </div>
      </section>
    </main>

    <!-- 答对弹层：蹦出「太棒了」图片，随后自动进入下一题 -->
    <transition name="great">
      <div v-if="showGreat" class="great-mask">
        <div class="great-wrap">
          <img :src="greatIcon" class="great-img" alt="太棒了" />
          <div class="great-tip">答对啦 · 下一题…</div>
        </div>
      </div>
    </transition>

    <!-- 答错弹层：蹦出「加油」动图 + 正确答案，随后自动进入下一题（点击可立即跳过） -->
    <transition name="great">
      <div v-if="showWrong" class="great-mask wrong-mask" @click="skipWrong">
        <div class="wrong-wrap" @click.stop>
          <img :src="cheerIcon" class="cheer-img" alt="加油" />
          <div class="wrong-title">😅 答错了，正确答案：</div>
          <div class="wrong-answer" v-html="render(showWrong.answerText)"></div>
          <div class="great-tip">下一题马上来…（点空白处可立即跳过）</div>
        </div>
      </div>
    </transition>
  </div>
</template>

<script setup>
import { ref, computed, onMounted, onUnmounted } from 'vue'
import katex from 'katex'
import 'katex/dist/katex.min.css'
import { papers as mathPapers } from '../brainQuestions.js'
import { publicPapers } from '../brainQuestionsPublic.js'
import brainIcon from '../assets/brain-icon.jpg'
import greatIcon from '../assets/great.png'
import cheerIcon from '../assets/cheer.gif'

// 高数卷 + 公共课卷合并，共 4 套
const papers = [...mathPapers, ...publicPapers]

const emit = defineEmits(['close'])

// ---------- 星空背景 ----------
const stars = ref([])
onMounted(() => {
  const arr = []
  for (let i = 0; i < 90; i++) {
    const size = Math.random() * 2 + 1
    arr.push({
      id: i,
      style: {
        left: Math.random() * 100 + '%',
        top: Math.random() * 100 + '%',
        width: size + 'px',
        height: size + 'px',
        animationDelay: (Math.random() * 4) + 's',
        animationDuration: (2 + Math.random() * 3) + 's'
      }
    })
  }
  stars.value = arr
})

// ---------- 公式渲染：把 $...$ 片段交给 KaTeX ----------
function render(text) {
  if (!text) return ''
  return String(text).replace(/\$([^$]+)\$/g, (m, tex) => {
    try {
      return katex.renderToString(tex, { throwOnError: false, displayMode: false })
    } catch (e) {
      return m
    }
  })
}

// ---------- 状态 ----------
const stage = ref('select') // select / quiz / done
const currentPaper = ref(null)
const questions = ref([])
const index = ref(0)
const correct = ref(0)
const answered = ref(0)
const locked = ref(false)
const picked = ref(-1)          // 选择：选项下标；判断：true/false
const multiPicked = ref([])     // 多选：已选选项下标数组
const showGreat = ref(false)    // 答对：弹出「太棒了」图片
const showWrong = ref(null)     // 答错：{ answerText }，弹「加油」动图 + 答案
let advanceTimer = null         // 自动进入下一题的定时器

function clearAdvanceTimer() {
  if (advanceTimer) {
    clearTimeout(advanceTimer)
    advanceTimer = null
  }
}

onUnmounted(clearAdvanceTimer)
const judgeBtns = [
  { value: true, icon: '√', label: '正确' },
  { value: false, icon: '×', label: '错误' }
]

const total = computed(() => questions.value.length)
const currentQ = computed(() => questions.value[index.value])

function typeLabel(t) {
  return { choice: '单选题', multi: '多选题', judge: '判断题', solve: '主观题' }[t] || '题目'
}

// 多选答案索引数组 -> "A、B、C" 文本
function answerLetters(indices) {
  return indices.map(i => 'ABCD'[i]).join('、')
}

// ---------- 流程 ----------
function startPaper(p) {
  currentPaper.value = p
  questions.value = p.questions
  index.value = 0
  correct.value = 0
  answered.value = 0
  resetQuestion()
  stage.value = 'quiz'
}

function resetQuestion() {
  locked.value = false
  picked.value = currentQ.value && currentQ.value.type === 'judge' ? null : -1
  multiPicked.value = []
  showGreat.value = false
  showWrong.value = null
}

function optClass(oi) {
  if (!locked.value) return ''
  if (oi === currentQ.value.answer) return 'right'
  if (oi === picked.value) return 'wrong'
  return 'dim'
}

// 多选选项样式：选中高亮；锁定后正确项标绿、误选项标红
function multiOptClass(oi) {
  const selected = multiPicked.value.includes(oi)
  if (!locked.value) return selected ? 'selected' : ''
  const isAnswer = currentQ.value.answer.includes(oi)
  if (isAnswer) return 'right'
  if (selected) return 'wrong'
  return 'dim'
}

function toggleMulti(oi) {
  if (locked.value) return
  const arr = multiPicked.value
  multiPicked.value = arr.includes(oi) ? arr.filter(x => x !== oi) : [...arr, oi]
}

function submitMulti() {
  if (locked.value || multiPicked.value.length === 0) return
  const sel = [...multiPicked.value].sort((a, b) => a - b)
  const ans = [...currentQ.value.answer].sort((a, b) => a - b)
  const ok = sel.length === ans.length && sel.every((v, i) => v === ans[i])
  const answerText = answerLetters(currentQ.value.answer)
  showResult(ok, answerText)
}

function judgeClass(val) {
  if (!locked.value) return ''
  if (val === currentQ.value.answer) return 'right'
  if (val === picked.value) return 'wrong'
  return 'dim'
}

function nextQuestion() {
  index.value++
  if (index.value >= total.value) {
    stage.value = 'done'
  } else {
    resetQuestion()
  }
}

function showResult(ok, answerText) {
  locked.value = true
  answered.value++
  if (ok) correct.value++

  clearAdvanceTimer()

  if (ok) {
    // 答对：蹦出「太棒了」图片，短暂停顿后进入下一题
    showWrong.value = null
    showGreat.value = true
    advanceTimer = setTimeout(() => {
      showGreat.value = false
      advanceTimer = null
      nextQuestion()
    }, 1500)
  } else {
    // 答错：蹦出「加油」动图并给出正确答案，稍后自动进入下一题
    showGreat.value = false
    showWrong.value = { answerText }
    // 答案越长停留越久，3~6 秒
    const len = String(answerText || '').length
    const wait = Math.min(6000, Math.max(3000, 1800 + len * 18))
    advanceTimer = setTimeout(() => {
      showWrong.value = null
      advanceTimer = null
      nextQuestion()
    }, wait)
  }
}

// 答错弹层点击可立即进入下一题
function skipWrong() {
  if (!showWrong.value) return
  clearAdvanceTimer()
  showWrong.value = null
  nextQuestion()
}

function pickChoice(oi) {
  if (locked.value) return
  picked.value = oi
  const ok = oi === currentQ.value.answer
  const ansIdx = currentQ.value.answer
  const answerText = `ABCD`[ansIdx] + '．' + currentQ.value.options[ansIdx]
  showResult(ok, answerText)
}

function pickJudge(val) {
  if (locked.value) return
  picked.value = val
  const ok = val === currentQ.value.answer
  const answerText = currentQ.value.answer ? '√ 正确' : '× 错误'
  showResult(ok, answerText)
}

function selfGrade(ok) {
  if (locked.value) return
  showResult(ok, currentQ.value.answer)
}

function restart() {
  startPaper(currentPaper.value)
}

function backToSelect() {
  stage.value = 'select'
}
</script>

<style scoped>
.brain {
  position: relative;
  min-height: 100vh;
  overflow: hidden;
  color: #fff;
  background: radial-gradient(ellipse at 20% 10%, #1b1b4d 0%, #0d0d24 45%, #06060f 100%);
}

/* 星空 */
.sky { position: absolute; inset: 0; pointer-events: none; }
.star {
  position: absolute;
  background: #fff;
  border-radius: 50%;
  opacity: .8;
  animation: twinkle ease-in-out infinite;
}
@keyframes twinkle { 0%,100% { opacity: .25; } 50% { opacity: 1; } }
.nebula {
  position: absolute;
  width: 60vw; height: 60vw;
  right: -15vw; top: -20vw;
  background: radial-gradient(circle, rgba(123,140,255,.18), transparent 60%);
}

/* 顶部栏 */
.b-top {
  position: relative;
  z-index: 2;
  display: flex;
  align-items: center;
  gap: 16px;
  padding: 14px 28px;
  background: rgba(10,10,30,.55);
  border-bottom: 1px solid rgba(255,255,255,.1);
  backdrop-filter: blur(8px);
}
.back {
  background: rgba(255,255,255,.1);
  border: 1px solid rgba(255,255,255,.25);
  color: #fff;
  padding: 8px 16px;
  border-radius: 999px;
  cursor: pointer;
  font-size: 14px;
}
.back:hover { background: rgba(123,140,255,.35); }
.b-title { font-size: 20px; font-weight: 700; display: flex; align-items: center; gap: 8px; }
.b-title-ico { width: 28px; height: 28px; border-radius: 50%; object-fit: cover; border: 1px solid rgba(255,255,255,.7); }
.b-title small { font-size: 12px; font-weight: 400; opacity: .6; margin-left: 2px; }
.b-score { margin-left: auto; font-size: 15px; color: #7dffb0; font-weight: 600; }

/* 主体 */
.b-main {
  position: relative;
  z-index: 2;
  max-width: 860px;
  margin: 0 auto;
  padding: 32px 20px 60px;
}

/* 选卷 */
.select-panel { text-align: center; padding-top: 30px; }
.select-panel h2 { font-size: 28px; margin-bottom: 8px; }
.sub { opacity: .7; font-size: 14px; margin-bottom: 32px; }
.paper-cards {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 20px;
}
.paper-card {
  text-align: left;
  background: linear-gradient(145deg, rgba(123,140,255,.18), rgba(255,110,196,.12));
  border: 1px solid rgba(255,255,255,.2);
  border-radius: 18px;
  padding: 24px;
  color: #fff;
  cursor: pointer;
  transition: transform .18s, box-shadow .18s, border-color .18s;
}
.paper-card:hover {
  transform: translateY(-6px);
  border-color: rgba(255,255,255,.5);
  box-shadow: 0 16px 40px rgba(0,0,0,.4);
}
.pc-year { font-size: 34px; font-weight: 800; background: linear-gradient(90deg,#8aa0ff,#ff8ac4); -webkit-background-clip: text; background-clip: text; -webkit-text-fill-color: transparent; }
.pc-title { font-size: 15px; margin: 8px 0 4px; font-weight: 600; }
.pc-desc { font-size: 12px; opacity: .6; }
.pc-go { margin-top: 16px; font-size: 14px; color: #ffd36e; font-weight: 600; }
.tip-box {
  margin-top: 28px;
  display: inline-block;
  background: rgba(255,255,255,.08);
  border: 1px solid rgba(255,255,255,.15);
  border-radius: 12px;
  padding: 12px 20px;
  font-size: 13px;
  opacity: .85;
}

/* 进度 */
.progress-wrap { margin-bottom: 18px; }
.progress-info { display: flex; justify-content: space-between; font-size: 13px; opacity: .85; margin-bottom: 8px; }
.paper-tag { background: rgba(123,140,255,.3); padding: 2px 10px; border-radius: 999px; }
.progress-bar { height: 8px; background: rgba(255,255,255,.12); border-radius: 999px; overflow: hidden; }
.progress-fill { height: 100%; background: linear-gradient(90deg,#7b8cff,#ff6ec4); border-radius: 999px; transition: width .35s ease; }

/* 题目卡片 */
.q-card {
  background: rgba(255,255,255,.07);
  border: 1px solid rgba(255,255,255,.16);
  border-radius: 20px;
  padding: 28px 30px;
  backdrop-filter: blur(10px);
  box-shadow: 0 20px 50px rgba(0,0,0,.35);
}
.q-head { display: flex; align-items: center; gap: 12px; margin-bottom: 18px; }
.q-type { font-size: 12px; padding: 4px 12px; border-radius: 999px; font-weight: 600; }
.t-choice { background: rgba(123,140,255,.3); }
.t-multi { background: rgba(255,140,200,.32); }
.t-judge { background: rgba(255,196,110,.3); }
.t-solve { background: rgba(120,230,180,.28); }
.q-subject { font-size: 12px; padding: 3px 10px; border-radius: 999px; background: rgba(255,255,255,.12); border: 1px solid rgba(255,255,255,.2); }
.q-no { opacity: .5; font-size: 13px; margin-left: auto; }
.q-text { font-size: 20px; line-height: 1.9; margin-bottom: 26px; }
.q-text :deep(br) { display: block; content: ''; margin-top: 4px; }

/* 阅读短文 */
.passage {
  background: rgba(255,255,255,.05);
  border-left: 3px solid rgba(123,140,255,.6);
  border-radius: 0 10px 10px 0;
  padding: 14px 18px;
  margin-bottom: 20px;
}
.passage-label { font-size: 12px; color: #9fb0ff; margin-bottom: 8px; font-weight: 600; }
.passage-text { font-size: 15px; line-height: 1.75; opacity: .9; font-style: italic; }

/* 选项 */
.options { display: flex; flex-direction: column; gap: 12px; }
.opt {
  display: flex;
  align-items: center;
  gap: 14px;
  width: 100%;
  text-align: left;
  background: rgba(255,255,255,.06);
  border: 1px solid rgba(255,255,255,.18);
  border-radius: 12px;
  padding: 14px 16px;
  color: #fff;
  font-size: 17px;
  cursor: pointer;
  transition: background .15s, border-color .15s, transform .1s;
}
.opt:hover:not(:disabled) { background: rgba(123,140,255,.22); border-color: rgba(123,140,255,.6); }
.opt:active:not(:disabled) { transform: scale(.99); }
.opt:disabled { cursor: default; }
.opt-key {
  flex: 0 0 32px; height: 32px;
  display: flex; align-items: center; justify-content: center;
  border-radius: 50%;
  background: rgba(255,255,255,.12);
  font-weight: 700;
  font-size: 15px;
}
.opt-key.square { border-radius: 8px; }
.opt-text { flex: 1; }
.opt-mark { color: #7dffb0; font-size: 20px; font-weight: 800; }
.opt-mark.wrong { color: #ff7a90; }
.opt.selected { background: rgba(255,140,200,.2); border-color: rgba(255,140,200,.7); }
.opt.selected .opt-key { background: rgba(255,140,200,.6); }
.opt.right { background: rgba(60,200,130,.22); border-color: rgba(90,255,170,.7); }
.opt.wrong { background: rgba(255,90,120,.2); border-color: rgba(255,110,140,.7); }
.opt.dim { opacity: .4; }
.submit-multi {
  margin-top: 6px;
  padding: 13px;
  border-radius: 12px;
  border: none;
  background: linear-gradient(90deg, #7b8cff, #ff6ec4);
  color: #fff;
  font-size: 16px;
  font-weight: 700;
  cursor: pointer;
  transition: filter .15s;
}
.submit-multi:hover:not(:disabled) { filter: brightness(1.15); }
.submit-multi:disabled { opacity: .4; cursor: default; }
.judge-options { flex-direction: row; }
.judge-opt { flex: 1; justify-content: center; }
.judge-opt .opt-key { font-size: 22px; }

/* 自评 */
.solve-area { text-align: center; }
.solve-hint { font-size: 14px; opacity: .7; margin-bottom: 18px; }
.solve-btns { display: flex; gap: 14px; justify-content: center; }
.solve-btn {
  padding: 12px 26px; border-radius: 999px; cursor: pointer;
  font-size: 15px; font-weight: 600; color: #fff;
  border: 1px solid rgba(255,255,255,.25);
}
.solve-btn.ok { background: rgba(60,200,130,.25); }
.solve-btn.ok:hover { background: rgba(60,200,130,.45); }
.solve-btn.see { background: rgba(255,196,110,.2); }
.solve-btn.see:hover { background: rgba(255,196,110,.4); }

/* 反馈 */
.feedback {
  margin-top: 22px;
  border-radius: 14px;
  padding: 16px 18px;
  font-size: 15px;
}
.fb-ok { background: rgba(60,200,130,.18); border: 1px solid rgba(90,255,170,.5); }
.fb-no { background: rgba(255,90,120,.14); border: 1px solid rgba(255,110,140,.5); }
.fb-line { font-weight: 700; font-size: 17px; }
.fb-answer { margin-top: 8px; font-size: 16px; }
.fb-next { margin-top: 8px; font-size: 12px; opacity: .6; }
.fade-enter-active, .fade-leave-active { transition: opacity .3s; }
.fade-enter-from, .fade-leave-to { opacity: 0; }

/* 完成 */
.done-panel { text-align: center; padding-top: 40px; }
.done-emoji { font-size: 72px; }
.done-panel h2 { font-size: 30px; margin: 12px 0 24px; }
.done-score { display: inline-block; margin-bottom: 30px; }
.ds-num { font-size: 64px; font-weight: 800; background: linear-gradient(90deg,#8aa0ff,#ff8ac4); -webkit-background-clip: text; background-clip: text; -webkit-text-fill-color: transparent; }
.ds-num small { font-size: 26px; -webkit-text-fill-color: #fff; opacity: .5; }
.ds-label { font-size: 13px; opacity: .6; }
.done-actions { display: flex; gap: 16px; justify-content: center; }
.da { padding: 12px 28px; border-radius: 999px; font-size: 15px; font-weight: 600; cursor: pointer; color: #fff; border: 1px solid rgba(255,255,255,.25); }
.da.again { background: rgba(123,140,255,.35); }
.da.change { background: rgba(255,255,255,.1); }
.da:hover { filter: brightness(1.2); }

/* 答对「太棒了」弹层 */
.great-mask {
  position: fixed;
  inset: 0;
  z-index: 80;
  display: flex;
  align-items: center;
  justify-content: center;
  background: radial-gradient(circle at 50% 50%, rgba(30,30,70,.55), rgba(4,4,12,.78));
  backdrop-filter: blur(3px);
  pointer-events: none;
}
.great-wrap { display: flex; flex-direction: column; align-items: center; gap: 14px; }
.great-img {
  width: min(78vw, 440px);
  height: auto;
  filter: drop-shadow(0 18px 40px rgba(0,0,0,.6)) drop-shadow(0 0 24px rgba(255,220,120,.35));
  animation: greatPop .55s cubic-bezier(.18,1.5,.42,1) both, greatBounce .9s ease-in-out .55s infinite;
}
@keyframes greatPop {
  0% { transform: scale(.35) rotate(-10deg); opacity: 0; }
  70% { transform: scale(1.06) rotate(2deg); opacity: 1; }
  100% { transform: scale(1) rotate(0); opacity: 1; }
}
@keyframes greatBounce {
  0%, 100% { transform: translateY(0); }
  50% { transform: translateY(-9px); }
}
.great-tip {
  font-size: 15px;
  font-weight: 600;
  letter-spacing: 1px;
  color: #fff;
  opacity: .85;
  animation: greatFadeIn .4s ease .35s both;
}
@keyframes greatFadeIn { from { opacity: 0; transform: translateY(6px); } to { opacity: .85; transform: translateY(0); } }
.great-enter-active, .great-leave-active { transition: opacity .22s ease; }
.great-enter-from, .great-leave-to { opacity: 0; }

/* 答错「加油」弹层 */
.wrong-mask { pointer-events: auto; cursor: pointer; }
.wrong-wrap {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 12px;
  width: min(88vw, 640px);
}
.cheer-img {
  width: min(44vw, 210px);
  height: auto;
  filter: drop-shadow(0 16px 34px rgba(0,0,0,.55));
  animation: greatPop .5s cubic-bezier(.18,1.5,.42,1) both, greatBounce 1s ease-in-out .5s infinite;
}
.wrong-title {
  font-size: 16px;
  font-weight: 600;
  color: #ffd0d8;
  animation: greatFadeIn .35s ease .25s both;
}
.wrong-answer {
  width: 100%;
  max-height: 30vh;
  overflow-y: auto;
  padding: 14px 18px;
  border-radius: 16px;
  background: rgba(255,255,255,.1);
  border: 1px solid rgba(255,255,255,.18);
  font-size: 15px;
  line-height: 1.8;
  text-align: left;
  white-space: pre-wrap;
  word-break: break-word;
  animation: greatFadeIn .35s ease .3s both;
}
.wrong-answer :deep(.katex) { color: #fff; }

/* KaTeX 文字颜色适配深色背景 */
.q-card :deep(.katex),
.feedback :deep(.katex) { color: #fff; }

@media (max-width: 640px) {
  .paper-cards { grid-template-columns: 1fr; }
  .q-text { font-size: 17px; }
  .b-title small { display: none; }
}
</style>
