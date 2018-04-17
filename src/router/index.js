import Vue from 'vue'
import Router from 'vue-router'
import Item from '@/components/Item'
import Market from '@/components/Market'
import UserCollection from '@/components/UserCollection'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/Item',
      name: 'Item',
      component: Item
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
