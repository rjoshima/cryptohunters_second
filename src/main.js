// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import App from './App'
import router from './router'
import Web3 from 'web3'
import ElementUI from 'element-ui'
import 'element-ui/lib/theme-chalk/index.css'
import locale from 'element-ui/lib/locale/lang/ja'
import BootstrapVue from 'bootstrap-vue'
import 'bootstrap/dist/css/bootstrap.css'
import 'bootstrap-vue/dist/bootstrap-vue.css'
import Vuetify from 'vuetify'

Vue.use(Vuetify)
Vue.use(BootstrapVue)
Vue.use(ElementUI, { locale })

Vue.config.productionTip = false

// window.addEventListener('load', function () {
//   // Checking if Web3 has been injected by the browser (Mist/MetaMask)
//   if (typeof web3 !== 'undefined') {
//     alert( "円は¥n" + web3.currentProvider );
//     // Use Mist/MetaMask's provider
//     web3js = new Web3(web3.currentProvider);
//   } else {
//     console.log('No web3? You should consider trying MetaMask!')
//     alert( "円周率は¥n" + 3.14159 );
//     // web3js = new Web3(new Web3.providers.HttpProvider("http://localhost:8545");
//     // Handle the case where the user doesn't have Metamask installed
//     // Probably show them a message prompting them to install Metamask
//   }
//   // Now you can start your app & access web3 freely:
//   // startApp()
// }

// function startApp () {
//   const cryptoZombiesAddress = "YOUR_CONTRACT_ADDRESS";
//   const cryptoZombies = new web3js.eth.Contract(cryptoZombiesABI, cryptoZombiesAddress);
//   const accountInterval = setInterval(function() {
//     // Check if account has changed
//     if (web3.eth.accounts[0] !== userAccount) {
//       let userAccount = web3.eth.accounts[0];
//       // Call a function to update the UI with the new account

//     }
//   }, 100);
// ここから始めよ
// )
// window.addEventListener('load', function () {
//   // Checking if Web3 has been injected by the browser (Mist/MetaMask)
//   if (typeof web3 !== 'undefined') {
//     // Use Mist/MetaMask's provider
//     const web3js = new Web3(web3.currentProvider)
//   } else {
//     console.log('No web3? You should consider trying MetaMask!')
//     web3js = new Web3(new Web3.providers.HttpProvider("http://localhost:8545")
//     // Handle the case where the user doesn't have Metamask installed
//     // Probably show them a message prompting them to install Metamask
//   },
//   // Now you can start your app & access web3 freely:
//   setInterval(function () {
//     // Check if account has changed
//     if (web3.eth.accounts[0] !== userAccount) {
//       userAccount = web3.eth.accounts[0];
//       // Call a function to update the UI with the new account
//       getZombiesByOwner(userAccount).then(displayZombies)
//     }
//   }, 100)
// })

/* eslint-disable no-new */
new Vue({
  el: '#app',
  router,
  components: { App },
  template: '<App/>'
})
