<template>
  <div class="card">
    <div class="sheep">🛠</div>
    <h1>后台管理登录</h1>
    <div class="sub">仅管理员可进入，普通用户请返回首页</div>

    <form @submit.prevent="onSubmit" novalidate>
      <div class="field">
        <label for="admin-username">管理员账号</label>
        <input
          type="text"
          id="admin-username"
          v-model="username"
          placeholder="请输入管理员账号"
          autocomplete="username"
        />
        <div class="err" v-show="usernameErr">请输入管理员账号</div>
      </div>

      <div class="field">
        <label for="admin-password">密码</label>
        <input
          type="password"
          id="admin-password"
          v-model="password"
          placeholder="请输入密码"
          autocomplete="current-password"
        />
        <div class="err" v-show="passwordErr">请输入密码</div>
      </div>

      <button type="submit" class="btn" :disabled="loading">{{ loading ? '登录中...' : '登 录' }}</button>
      <div class="msg" :class="{ fail: !isOk }">{{ msg }}</div>
    </form>

    <div class="foot"><a href="#" @click.prevent="$emit('back')">← 返回首页</a></div>
  </div>
</template>

<script setup>
import { ref } from 'vue'

const emit = defineEmits(['admin-login-success', 'back'])

const username = ref('')
const password = ref('')
const usernameErr = ref(false)
const passwordErr = ref(false)
const msg = ref('')
const isOk = ref(true)
const loading = ref(false)

async function onSubmit() {
  usernameErr.value = !username.value.trim()
  passwordErr.value = !password.value
  isOk.value = true
  msg.value = ''

  if (usernameErr.value || passwordErr.value) return

  loading.value = true
  try {
    // 后台登录暂时复用后端已有的登录接口（通过 vite 代理转发到 8081）
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
      msg.value = '登录成功，正在进入后台...'
      emit('admin-login-success')
    } else {
      isOk.value = false
      msg.value = data.msg || '账号或密码错误'
    }
  } catch (e) {
    isOk.value = false
    msg.value = '无法连接后端服务，请确认后端(8081)已启动'
  } finally {
    loading.value = false
  }
}
</script>

<style scoped>
.card {
  width: 360px;
  margin: 60px auto;
  padding: 32px 28px;
  background: rgba(255, 255, 255, .92);
  border-radius: 18px;
  box-shadow: 0 10px 30px rgba(0, 0, 0, .15);
  text-align: center;
}

.sheep { font-size: 44px; }

h1 {
  margin: 10px 0 4px;
  font-size: 22px;
  color: #333;
}

.sub {
  font-size: 13px;
  color: #888;
  margin-bottom: 20px;
}

.field {
  margin-bottom: 14px;
  text-align: left;
}

label {
  display: block;
  font-size: 13px;
  color: #555;
  margin-bottom: 6px;
}

input {
  width: 100%;
  box-sizing: border-box;
  padding: 10px 12px;
  border: 1px solid #ddd;
  border-radius: 10px;
  font-size: 14px;
  outline: none;
}

input:focus { border-color: #7ec850; }

.err {
  color: #e74c3c;
  font-size: 12px;
  margin-top: 4px;
}

.btn {
  width: 100%;
  padding: 11px 0;
  border: none;
  border-radius: 10px;
  background: #5fb83d;
  color: #fff;
  font-size: 15px;
  cursor: pointer;
}

.btn:hover { background: #4ca331; }
.btn:disabled { opacity: .6; cursor: not-allowed; }

.msg {
  min-height: 18px;
  margin-top: 10px;
  font-size: 13px;
  color: #2e7d32;
}

.msg.fail { color: #e74c3c; }

.foot {
  margin-top: 14px;
  font-size: 13px;
}

.foot a {
  color: #5fb83d;
  text-decoration: none;
}
</style>
