import Vue from 'vue'
import Router from 'vue-router'
import HelloWorld from '@/components/HelloWorld'
import Market from '@/components/Market'
import UserCollection from '@/components/UserCollection'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'HelloWorld',
      component: HelloWorld
    },
    {
      path: '/Market',
      name: 'Market',
      component: Market
    },
    {
      path: '/UserCollection',
      name: 'UserCollection',
      component: UserCollection
    }
  ]
})
