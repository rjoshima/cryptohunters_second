<template>
  <div class="UserStatus">
    <h2>adress: {{ adress }}</h2>
    <div>バトルフィールド</div>
    <ul> 
    </ul>
    <div id="txStatus"></div>
    <div id="Hunter"></div>
    <div>{{ hunter.name }}</div>
    <div v-for="fighter in fighters">
        <el-row>
      <el-col :span="8">
        <el-card :body-style="{ padding: '0px' }">
          <img src="../assets/fighter_defo.png" class="image">
          <div style="padding: 14px;">
          <span>名前</span>
            <span>{{fighter.name}}</span>
            <div class="bottom clearfix">
              <el-button type="text" class="button" @click="fight(fighterId, targetId)">戦う</el-button>
            </div>
          </div>
        </el-card>
      </el-col>
    </el-row>
        
    </div>
  </div>
</template>

<script>
  import Web3 from 'web3'
  import contract from 'truffle-contract'
  import artifacts from '../../build/contracts/CreateFighter.json'
  const HunterToken = contract(artifacts)

  import artifacts2 from '../../build/contracts/FighterAttack.json'
  const attackToken = contract(artifacts2)
  // const name = "dd"
  export default {
    name: 'UserCollection',
    data () {
      return {
        fighters: [],
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
        this.updateFighters();
       })
    },
    methods: {
      fight(fighterID, targetID) {
        console.log("うううううううううううう")
        console.log("rr")
        console.log(name)
        console.log(this.account)
        return attackToken.deployed().then((instance) => instance.fight(fighterID, targetID, { from: this.account })).then((r) => {
          
          console.log("成功")
          this.updateFighters();
        }).catch(function(err) {
        console.log(err.message);
      });
      },
      updateFighters() {
      HunterToken.deployed().then((instance) => instance.getAllFightersOfOwner(this.account, { from: this.account })).then((r) => {
        console.log("成功２２")
        console.log(r)
        console.log(r.length)
        for (var i = 0; i < r.length; i++) {
          console.log("ううう")
          this.getFighter(r[i]);
        }
      })
    },
    getFighter(tokenId) {
      HunterToken.deployed().then((instance) => instance.getFighter(tokenId, { from: this.account })).then((r) => {
        var fighter = {
          "name": null,
        }
        fighter["name"] = r;
        console.log(fighter)
        this.fighters.push(fighter)
        // console.log(r)
      })
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