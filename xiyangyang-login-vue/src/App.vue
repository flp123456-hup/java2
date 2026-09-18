<template>
  <div class="page">
    <div class="cloud c1"></div>
    <div class="cloud c2"></div>

    <LoginCard />

    <div class="grass"></div>
  </div>
</template>

<script setup>
import LoginCard from './components/LoginCard.vue'
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
