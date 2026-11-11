<template>
  <!-- 首页：全屏星空，不再套用登录页的草地/云朵容器 -->
  <HomeView v-if="mode === 'home'" :username="currentUser" @logout="onLogout" @open-admin="onOpenAdmin" @open-media="onOpenMedia" @search="onSearch" />

  <!-- 搜索页：热度榜 / 排行榜 + 搜索结果 -->
  <SearchResults v-else-if="mode === 'search'" :keyword="searchKw" @back="onSearchBack" />

  <!-- 后台管理系统：登录页（仅登录，无注册） -->
  <AdminLogin v-else-if="mode === 'admin-login'" @admin-login-success="onAdminLoginSuccess" @back="onBackFromAdmin" />

  <!-- 后台管理系统：仪表盘 -->
  <AdminDashboard v-else-if="mode === 'admin'" @logout="onAdminLogout" />

  <!-- 电视剧（原影视中心） -->
  <MediaCenter v-else-if="mode === 'media'" @close="onMediaClose" @open-short-video="onOpenShortVideo" />

  <!-- 短视频：竖屏滑动信息流 -->
  <ShortVideo v-else-if="mode === 'short-video'" @close="onShortVideoClose" />

  <!-- 登录 / 注册：熊猫背景场景 -->
  <div class="page" v-else>
    <LoginCard v-if="mode === 'login'" @switch-register="mode = 'register'" @login-success="onLoginSuccess" @enter-demo="onEnterDemo" />
    <RegisterCard v-else-if="mode === 'register'" @switch-login="mode = 'login'" @register-success="onRegisterSuccess" />
  </div>
</template>

<script setup>
import { ref } from 'vue'
import LoginCard from './components/LoginCard.vue'
import RegisterCard from './components/RegisterCard.vue'
import HomeView from './components/HomeView.vue'
import AdminLogin from './components/AdminLogin.vue'
import AdminDashboard from './components/AdminDashboard.vue'
import SearchResults from './components/SearchResults.vue'
import MediaCenter from './components/MediaCenter.vue'
import ShortVideo from './components/ShortVideo.vue'

// 'login' / 'register' / 'home' / 'admin-login' / 'admin' / 'search'
const mode = ref('login')
const currentUser = ref('')
const searchKw = ref('')

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

// ===== 搜索页 =====
function onSearch(kw) {
  searchKw.value = kw || ''
  mode.value = 'search' // 从首页进入搜索页（含热度榜 / 排行榜 / 搜索结果）
}
function onSearchBack() {
  mode.value = 'home' // 从搜索页返回首页
}

// ===== 后台管理系统 =====
function onOpenAdmin() {
  mode.value = 'admin-login' // 从首页进入后台登录页
}

function onOpenMedia() {
  mode.value = 'media'      // 进入电视剧
}

function onMediaClose() {
  mode.value = 'home'       // 电视剧返回首页
}

function onOpenShortVideo() {
  mode.value = 'short-video'  // 电视剧页进入短视频
}

function onShortVideoClose() {
  mode.value = 'media'        // 短视频返回电视剧页
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
  /* 熊猫背景图：铺满全屏，居中显示 */
  background: url('./assets/panda.jpg') no-repeat center center;
  background-size: cover;
  position: relative;
  overflow: hidden;
}
</style>
