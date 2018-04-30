<template>
  <div id="app">
    <el-header>クリプトハンターズ</el-header>
    <el-tabs v-model="activeName" @tab-click="handleClick">
      <el-tab-pane label="User" name="first"></el-tab-pane>
      <el-tab-pane label="バトルフィールド" name="second"></el-tab-pane>
      <el-tab-pane label="item marketprace" name="third"></el-tab-pane>
    </el-tabs>
  
    <router-view>
    </router-view>
    <el-footer>cpryright joh 2018</el-footer>
  </div>
</template>

<script>
export default {
  name: 'App'
}
</script>

<style>
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>

<script>
  export default {
    data() {
      return {
        activeName: 'first'
      };
    },
    methods: {
      handleClick(tab, event) {
        console.log(tab);
        console.log(event)
        if (tab.name === "first") {
          this.$router.push('/UserCollection')
        }
        if (tab.name === "second") {
          this.$router.push('/Market')
        }
        if (tab.name === "third") {
          this.$router.push('/item')
        }
      }
    }
  };
</script>