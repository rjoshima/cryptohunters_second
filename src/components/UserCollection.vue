<template>
  <div class="UserStatus">
    <h2>adress: {{ adress }}</h2>
    <div>ハンターを作る</div>
    <div>名前は？</div>
    <el-main>
      <el-input v-model="hunter.name" placeholder="ハンター名を入力" clearable>
        <el-button slot="append" @click="createHunter(hunter.name)">作成</el-button>
      </el-input>
    </el-main>
    <ul> 
    </ul>
    <div id="txStatus"></div>
    <div id="Hunter"></div>
    <div>{{ hunter.name }}</div>
  </div>
</template>

<script>
  import Web3 from 'web3'
  import contract from 'truffle-contract'
  import artifacts from '../../build/contracts/CreateFighter.json'

  const HunterToken = contract(artifacts)
  // const name = "dd"
  export default {
    name: 'UserCollection',
    data () {
      return {
        hunter: {name: ""},
        adress: "waiting"
      }
    },
    created() {
      if (typeof web3 !== 'undefined') {
        console.warn("Using web3 detected from external source. ")
        // Use Mist/MetaMask's provider
        web3 = new Web3(web3.currentProvider)
      } else {
        console.warn("No web3 detected. ")
        // fallback - use your fallback strategy (local node / hosted node + in-dapp id mgmt / fail)
        web3 = new Web3(new Web3.providers.HttpProvider("http://127.0.0.1:9545"))
      }
      HunterToken.setProvider(web3.currentProvider)
      web3.eth.getAccounts((err, accs) => {
        if (web3.currentProvider.publicConfigStore._state.networkVersion !== '3') {
          this.is_network = false
        } else {
          this.is_network = true
        }
        if (err != null) {
          console.log(err)
          this.message = "There was an error fetching your accounts. Do you have Metamask, Mist installed or an Ethereum node running? If not, you might want to look into that"
          return
        }
        if (accs.length == 0) {
          this.message = "Couldn't get any accounts! Make sure your Ethereum client is configured correctly."
          return
        }
        this.account = accs[0];
        console.warn("aaaddee ")
        console.warn(this.account)
        this.adress = String(this.account)
       })
    },
    methods: {
      createHunter(name) {
        console.log("うううううううううううう")
        console.log("rr")
        console.log(name)
        console.log(this.account)
        return HunterToken.deployed().then((instance) => instance.createRandomFighter(name, { from: this.account })).then((r) => {
          console.log("rr")
          console.log("成功")
          // Transaction was accepted into the blockchain, let's redraw the UI
          // this.getFightersByOwner(this.account)
          var id = 1
          this.getFighter(id)
        }).catch(function(err) {
        console.log(err.message);
      });
      },
      displayHunter(id) {
        getHunterDetails(id).then(function(hunter) {
          $("#Hunter").empty();
            $("#Hunter").append(`<div class="hunter">
              <ul>
                <li>Name: ${hunter.name}</li>
              </ul>
            </div>`);
        })     
      },
      getFightersByOwner(owner) {
        return HunterToken.deployed().then((instance) => instance.getFightersByOwner(owner)).then((r) => {
          console.log(r)
          console.log(r[0].id)
          HunterToken.deployed().then((instance) => instance.fighters(r[0].id)).then((e) => {
          
          console.log("get iddddd")

          });
      })},
       getFighter(id) {
         console.log("get iddddd1111")
        HunterToken.deployed().then((instance) => instance.getFighter(id)).then((e) => {
          
          console.log("get iddddd")
          console.log(e)

          });
      },

      getHunterDetails(id) {
        return HunterToken.methods.hunter(id).call()
      },

        
      hunterToOwner(id) {
        return HunterToken.methods.hunterToOwner(id).call()
      },

    }
  }
</script>

<style scoped>
  .el-main {
    width: 350px;
    margin: 0px auto;
  }
</style>