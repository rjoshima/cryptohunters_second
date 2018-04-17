<template>
  <div class="hello">
    <h1>{{ msg }}</h1>
      <h2>狩りに必要なアイテムを買おう！</h2>
      <h2>このアイテムはユーザーと売買できるぞ！</h2>
      <h2>剣や盾や回復薬などのアイテムが選べます。</h2>
  </div>
</template>

<script>
export default {
  name: 'HelloWorld',
  data () {
    return {
      msg: 'クリプトハンターズ 狩りしようぜ'
    }
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
h1, h2 {
  font-weight: normal;
}
ul {
  list-style-type: none;
  padding: 0;
}
li {
  display: inline-block;
  margin: 0 10px;
}
a {
  color: #42b983;
}
</style>
