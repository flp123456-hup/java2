<template>
  <div class="card">
    <div class="sheep">🐑</div>
    <h1>喜羊羊注册</h1>
    <div class="sub">加入羊村，成为草原的一员！</div>

    <form @submit.prevent="onSubmit" novalidate>
      <div class="field">
        <label for="reg-username">用户名</label>
        <input
          type="text"
          id="reg-username"
          v-model="username"
          placeholder="请输入用户名"
          autocomplete="username"
          @input="usernameErr = false"
        />
        <div class="err" v-show="usernameErr">用户名不能为空</div>
      </div>

      <div class="field">
        <label for="reg-password">密码</label>
        <input
          type="password"
          id="reg-password"
          v-model="password"
          placeholder="请输入密码（1-18 位）"
          autocomplete="new-password"
          maxlength="18"
          @input="onPasswordInput"
        />
        <div class="err" v-show="passwordErr">密码长度须为 1-18 位</div>
      </div>

      <div class="field">
        <label for="reg-password2">确认密码</label>
        <input
          type="password"
          id="reg-password2"
          v-model="password2"
          placeholder="请再次输入密码"
          autocomplete="new-password"
          maxlength="18"
          @input="password2Err = false"
        />
        <div class="err" v-show="password2Err">两次输入的密码不一致</div>
      </div>

      <div class="field">
        <label for="reg-captcha">验证码</label>
        <div class="captcha-row">
          <input
            type="text"
            id="reg-captcha"
            v-model="captchaInput"
            placeholder="请输入验证码"
            maxlength="4"
            autocomplete="off"
            @input="captchaErr = false"
          />
          <canvas
            ref="captchaCanvas"
            class="captcha-canvas"
            width="100"
            height="44"
            title="看不清？点击刷新"
            @click="refreshCaptcha"
          ></canvas>
        </div>
        <div class="err" v-show="captchaErr">验证码错误，请重新输入</div>
        <div class="tip">看不清？点击图片即可刷新</div>
      </div>

      <button type="submit" class="btn">注 册</button>
      <div class="msg" :class="{ fail: !isOk }">{{ msg }}</div>
    </form>

    <div class="foot">已有账户？<a href="#" @click.prevent="$emit('switch-login')">返回登录</a></div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'

const emit = defineEmits(['register-success', 'switch-login'])

const username = ref('')
const password = ref('')
const password2 = ref('')
const captchaInput = ref('')

const usernameErr = ref(false)
const passwordErr = ref(false)
const password2Err = ref(false)
const captchaErr = ref(false)
const msg = ref('')

const captchaCanvas = ref(null)
const isOk = ref(true)
let captchaCode = ''

// 生成随机验证码并绘制到 canvas
function refreshCaptcha() {
  const chars = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789' // 去掉易混淆的 I O 0 1
  captchaCode = ''
  for (let i = 0; i < 4; i++) {
    captchaCode += chars[Math.floor(Math.random() * chars.length)]
  }
  drawCaptcha()
}

function drawCaptcha() {
  const canvas = captchaCanvas.value
  if (!canvas) return
  const ctx = canvas.getContext('2d')
  const w = canvas.width
  const h = canvas.height

  // 背景淡黄色
  ctx.fillStyle = '#fdf6dd'
  ctx.fillRect(0, 0, w, h)

  // 干扰线
  for (let i = 0; i < 4; i++) {
    ctx.strokeStyle = `hsl(${Math.random() * 360}, 60%, 70%)`
    ctx.beginPath()
    ctx.moveTo(Math.random() * w, Math.random() * h)
    ctx.lineTo(Math.random() * w, Math.random() * h)
    ctx.stroke()
  }

  // 逐个字符绘制，带随机颜色/旋转/偏移
  for (let i = 0; i < captchaCode.length; i++) {
    ctx.save()
    ctx.font = 'bold 24px Arial'
    ctx.fillStyle = `hsl(${Math.random() * 360}, 70%, 40%)`
    ctx.translate(14 + i * 22, h / 2 + (Math.random() * 8 - 4))
    ctx.rotate((Math.random() - 0.5) * 0.5)
    ctx.textAlign = 'center'
    ctx.textBaseline = 'middle'
    ctx.fillText(captchaCode[i], 0, 0)
    ctx.restore()
  }

  // 干扰点
  for (let i = 0; i < 20; i++) {
    ctx.fillStyle = `hsla(${Math.random() * 360}, 70%, 50%, .5)`
    ctx.beginPath()
    ctx.arc(Math.random() * w, Math.random() * h, 1.5, 0, Math.PI * 2)
    ctx.fill()
  }
}

function onPasswordInput() {
  // 超长直接截断，确保不超过 18 位
  if (password.value.length > 18) {
    password.value = password.value.slice(0, 18)
  }
  passwordErr.value = false
}

async function onSubmit() {
  usernameErr.value = !username.value.trim()
  passwordErr.value = password.value.length < 1 || password.value.length > 18
  password2Err.value = password2.value !== password.value
  captchaErr.value =
    captchaInput.value.trim().toUpperCase() !== captchaCode

  if (usernameErr.value || passwordErr.value || password2Err.value || captchaErr.value) {
    msg.value = ''
    if (captchaErr.value) refreshCaptcha()
    return
  }

  try {
    // 调用 Spring Boot 后端注册接口（通过 vite 代理转发到 8081）
    const res = await fetch('/api/user/register', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        username: username.value.trim(),
        password: password.value
      })
    })
    const data = await res.json()
    if (data.code === 200) {
      isOk.value = true
      msg.value = '🎉 注册成功！欢迎 ' + username.value.trim() + ' 加入羊村！'
      captchaInput.value = ''
      setTimeout(() => {
        emit('register-success', username.value.trim())
      }, 800)
    } else {
      isOk.value = false
      msg.value = data.msg || '注册失败'
      refreshCaptcha()
    }
  } catch (e) {
    isOk.value = false
    msg.value = '网络错误：无法连接服务器，请确认后端已启动'
    refreshCaptcha()
  }
}

onMounted(refreshCaptcha)
</script>

<style scoped>
.card {
  position: relative;
  z-index: 2;
  width: 360px;
  background: #fff;
  border-radius: 20px;
  box-shadow: 0 18px 45px rgba(0, 0, 0, .18);
  padding: 32px 32px 30px;
  border: 3px solid #ffd24d;
}

.sheep {
  font-size: 56px;
  text-align: center;
  line-height: 1;
  margin-bottom: 4px;
}

.card h1 {
  text-align: center;
  font-size: 26px;
  color: #3aa655;
  margin-bottom: 4px;
  letter-spacing: 1px;
}

.card .sub {
  text-align: center;
  color: #99a;
  font-size: 13px;
  margin-bottom: 22px;
}

.field {
  margin-bottom: 14px;
}

.field label {
  display: block;
  font-size: 13px;
  color: #555;
  margin-bottom: 6px;
}

.field input {
  width: 100%;
  padding: 12px 14px;
  border: 2px solid #e3e3e3;
  border-radius: 10px;
  font-size: 14px;
  outline: none;
  transition: border-color .2s;
  box-sizing: border-box;
}

.field input:focus {
  border-color: #7ec850;
}

.field .err {
  color: #e74c3c;
  font-size: 12px;
  margin-top: 5px;
}

.field .tip {
  color: #bbb;
  font-size: 11px;
  margin-top: 4px;
}

.captcha-row {
  display: flex;
  gap: 10px;
  align-items: center;
}

.captcha-row input {
  flex: 1;
}

.captcha-canvas {
  width: 100px;
  height: 44px;
  border: 2px solid #e3e3e3;
  border-radius: 10px;
  cursor: pointer;
  flex-shrink: 0;
}

.btn {
  width: 100%;
  padding: 13px;
  border: none;
  border-radius: 10px;
  background: linear-gradient(135deg, #ffd24d, #ffb01f);
  color: #6b4b00;
  font-size: 16px;
  font-weight: bold;
  cursor: pointer;
  margin-top: 8px;
  transition: transform .1s, opacity .2s;
}

.btn:hover {
  opacity: .93;
}

.btn:active {
  transform: scale(.98);
}

.msg {
  text-align: center;
  font-size: 13px;
  margin-top: 14px;
  min-height: 18px;
  color: #3aa655;
}

.msg.fail {
  color: #e74c3c;
}

.foot {
  text-align: center;
  margin-top: 16px;
  font-size: 12px;
  color: #aaa;
}

.foot a {
  color: #3aa655;
  text-decoration: none;
}
</style>
