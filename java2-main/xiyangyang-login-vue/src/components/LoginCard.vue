<template>
  <div class="card">
    <div class="sheep">🐑</div>
    <h1>喜羊羊登录</h1>
    <div class="sub">青青草原欢迎你，请登录吧！</div>

    <form @submit.prevent="onSubmit" novalidate>
      <div class="field">
        <label for="username">用户名</label>
        <input
          type="text"
          id="username"
          v-model="username"
          placeholder="请输入用户名"
          autocomplete="username"
        />
        <div class="err" v-show="usernameErr">请输入用户名</div>
      </div>

      <div class="field">
        <label for="password">密码</label>
        <input
          type="password"
          id="password"
          v-model="password"
          placeholder="请输入密码"
          autocomplete="current-password"
        />
        <div class="err" v-show="passwordErr">密码至少 6 位</div>
      </div>

      <button type="submit" class="btn">登 录</button>
      <div class="msg" :class="{ fail: !isOk }">{{ msg }}</div>
      <button type="button" class="demo-btn" v-if="showDemo" @click="enterDemo">
        🚀 先体验首页（无需登录）
      </button>
    </form>

    <div class="foot">还没有账户？<a href="#" @click.prevent="$emit('switch-register')">去羊村注册</a></div>
  </div>
</template>

<script setup>
import { ref } from 'vue'

const emit = defineEmits(['switch-register', 'login-success', 'enter-demo'])

const username = ref('')
const password = ref('')
const usernameErr = ref(false)
const passwordErr = ref(false)
const msg = ref('')
const isOk = ref(true)
const loading = ref(false)
const showDemo = ref(false)

async function onSubmit() {
  usernameErr.value = !username.value.trim()
  passwordErr.value = password.value.length < 1 || password.value.length > 18
  showDemo.value = false

  if (usernameErr.value || passwordErr.value) {
    msg.value = ''
    return
  }

  loading.value = true
  try {
    // 调用 Spring Boot 后端登录接口（通过 vite 代理转发到 8081）
    const res = await fetch('/api/user/login', {
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
      msg.value = '🎉 登录成功，欢迎 ' + username.value.trim() + ' 来到羊村！'
      emit('login-success', username.value.trim()) // 通知父组件跳转首页
    } else {
      isOk.value = false
      msg.value = data.msg || '登录失败'
    }
  } catch (e) {
    isOk.value = false
    showDemo.value = true
    msg.value = '⚠️ 连不上后端（localhost:8081）。可先体验首页，或确认 Spring Boot 已启动。'
  } finally {
    loading.value = false
  }
}

function enterDemo() {
  emit('enter-demo') // 后端未启动时的体验入口
}
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
  margin-bottom: 16px;
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
}

.field input:focus {
  border-color: #7ec850;
}

.field .err {
  color: #e74c3c;
  font-size: 12px;
  margin-top: 5px;
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

.demo-btn {
  width: 100%;
  margin-top: 10px;
  padding: 11px;
  border: 2px dashed #7ec850;
  border-radius: 10px;
  background: #f3fbf0;
  color: #3aa655;
  font-size: 14px;
  font-weight: bold;
  cursor: pointer;
  transition: background .2s;
}

.demo-btn:hover {
  background: #e8f7e2;
}
</style>
