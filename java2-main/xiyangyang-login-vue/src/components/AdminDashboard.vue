<template>
  <div class="dashboard">
    <header class="topbar">
      <div class="brand">🐑 喜羊羊后台管理系统</div>
      <button class="logout" @click="$emit('logout')">退出后台</button>
    </header>

    <main class="content">
      <h2>欢迎进入后台管理</h2>
      <p class="tip">这里是仪表盘占位页，后续可以在这里添加用户管理、数据统计等功能。</p>

      <div class="stats">
        <div class="stat">
          <div class="num">🧑‍💼</div>
          <div class="label">用户管理</div>
        </div>
        <div class="stat">
          <div class="num">📊</div>
          <div class="label">数据统计</div>
        </div>
        <div class="stat">
          <div class="num">⚙️</div>
          <div class="label">系统设置</div>
        </div>
      </div>
    </main>
  </div>
</template>

<script setup>
defineEmits(['logout'])
</script>

<style scoped>
.dashboard {
  min-height: 100vh;
  background: #f4f6f9;
}

.topbar {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 14px 28px;
  background: #fff;
  box-shadow: 0 2px 8px rgba(0, 0, 0, .06);
}

.brand {
  font-size: 17px;
  font-weight: bold;
  color: #333;
}

.logout {
  padding: 8px 18px;
  border: none;
  border-radius: 8px;
  background: #e74c3c;
  color: #fff;
  font-size: 14px;
  cursor: pointer;
}

.logout:hover { background: #c0392b; }

.content {
  max-width: 900px;
  margin: 40px auto;
  padding: 0 20px;
}

h2 { color: #333; }

.tip {
  color: #888;
  font-size: 14px;
}

.stats {
  display: flex;
  gap: 20px;
  margin-top: 30px;
}

.stat {
  flex: 1;
  background: #fff;
  border-radius: 14px;
  padding: 28px 0;
  text-align: center;
  box-shadow: 0 4px 14px rgba(0, 0, 0, .06);
}

.stat .num { font-size: 36px; }

.stat .label {
  margin-top: 10px;
  color: #555;
  font-size: 14px;
}
</style>
