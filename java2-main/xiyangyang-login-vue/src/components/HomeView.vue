<template>
  <div class="card">
    <div class="sheep">🐑</div>
    <h1>登录成功！</h1>
    <p class="welcome">欢迎 <b>{{ username }}</b> 来到羊村 🌿</p>
    <p class="tip">这里是登录后的前端首页，登录跳转已生效。</p>
    <button class="btn" @click="$emit('logout')">退 出 登 录</button>
  </div>
</template>

<script setup>
defineProps({ username: String })
defineEmits(['logout'])
</script>

<style scoped>
.card {
  position: relative;
  z-index: 2;
  width: 380px;
  background: #fff;
  border-radius: 20px;
  box-shadow: 0 18px 45px rgba(0, 0, 0, .18);
  padding: 36px 32px 30px;
  border: 3px solid #ffd24d;
  text-align: center;
}

.sheep {
  font-size: 60px;
  line-height: 1;
  margin-bottom: 6px;
}

.card h1 {
  font-size: 26px;
  color: #3aa655;
  margin-bottom: 10px;
  letter-spacing: 1px;
}

.welcome {
  font-size: 16px;
  color: #444;
  margin: 6px 0;
}

.welcome b {
  color: #ff8c1a;
}

.tip {
  font-size: 13px;
  color: #99a;
  margin: 6px 0 22px;
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
  transition: transform .1s, opacity .2s;
}

.btn:hover {
  opacity: .93;
}

.btn:active {
  transform: scale(.98);
}
</style>
