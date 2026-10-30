<template>
  <!-- 首页：全屏星空，不再套用登录页的草地/云朵容器 -->
  <HomeView v-if="mode === 'home'" :username="currentUser" @logout="onLogout" @open-admin="onOpenAdmin" />

  <!-- 后台管理系统：登录页（仅登录，无注册） -->
  <AdminLogin v-else-if="mode === 'admin-login'" @admin-login-success="onAdminLoginSuccess" @back="onBackFromAdmin" />

  <!-- 后台管理系统：仪表盘 -->
  <AdminDashboard v-else-if="mode === 'admin'" @logout="onAdminLogout" />

  <!-- 影视中心 -->
  <MediaCenter v-else-if="mode === 'media'" @close="onMediaClose" />

  <!-- 登录 / 注册：青青草原场景 -->
  <div class="page" v-else>
    <div class="cloud c1"></div>
    <div class="cloud c2"></div>

    <LoginCard v-if="mode === 'login'" @switch-register="mode = 'register'" @login-success="onLoginSuccess" @enter-demo="onEnterDemo" />
    <RegisterCard v-else-if="mode === 'register'" @switch-login="mode = 'login'" @register-success="onRegisterSuccess" />

    <div class="grass"></div>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import LoginCard from './components/LoginCard.vue'
import RegisterCard from './components/RegisterCard.vue'
import HomeView from './components/HomeView.vue'
import AdminLogin from './components/AdminLogin.vue'
import AdminDashboard from './components/AdminDashboard.vue'
import MediaCenter from './components/MediaCenter.vue'

// 'login' / 'register' / 'home' / 'admin-login' / 'admin'
const mode = ref('login')
const currentUser = ref('')

function onLoginSuccess(name) {
  currentUser.value = name // 记录登录用户名
  mode.value = 'home'       // 登录成功后跳转到首页
}

function onEnterDemo() {
  // 后端未启动时的体验入口：直接进入首页（游客身份）
  currentUser.value = '游客'
  mode.value = 'home'
}

function onRegisterSuccess() {
  mode.value = 'login' // 注册成功后跳回登录页
}

function onLogout() {
  currentUser.value = ''
  mode.value = 'login' // 退出登录回到登录页
}

// ===== 后台管理系统 =====
function onOpenAdmin() {
  mode.value = 'admin-login' // 从首页进入后台登录页
}

function onOpenMedia() {
  mode.value = 'media'      // 进入影视中心
}

function onMediaClose() {
  mode.value = 'home'       // 影视中心返回首页
}

function onAdminLoginSuccess() {
  mode.value = 'admin'        // 后台登录成功进入仪表盘
}

function onBackFromAdmin() {
  mode.value = 'home'         // 后台登录页返回首页
}

function onAdminLogout() {
  mode.value = 'home'         // 后台退出，回到首页
}
</script>

<style scoped>
.page {
  min-height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
  background: linear-gradient(180deg, #8fd3f4 0%, #b6e3a7 60%, #7ec850 100%);
  position: relative;
  overflow: hidden;
}

/* 草地装饰 */
.grass {
  position: absolute;
  bottom: 0;
  left: 0;
  right: 0;
  height: 90px;
  background: #5fb83d;
  border-top: 6px solid #4ca331;
  border-radius: 50% 50% 0 0 / 30px 30px 0 0;
}

.cloud {
  position: absolute;
  background: #fff;
  border-radius: 50%;
  opacity: .9;
}

.cloud.c1 {
  width: 120px;
  height: 120px;
  top: 50px;
  left: 12%;
  box-shadow: 40px 10px 0 -10px #fff, 80px 0 0 -20px #fff;
}

.cloud.c2 {
  width: 90px;
  height: 90px;
  top: 90px;
  right: 15%;
  box-shadow: 35px 8px 0 -8px #fff, 70px 0 0 -16px #fff;
}
</style>
