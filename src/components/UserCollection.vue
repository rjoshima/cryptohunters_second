<template>
  <div class="UserStatus">
    <div>ハンターを作る</div>
    <div>名前は？</div>
    <textarea>{{ hunter.name }}</textarea>
    <button @click="dcreateHunter()">make hunter button</button>
    <ul> 
    </ul>
    <div id="txStatus"></div>
  </div>
</template>

<script>
  import Web3 from 'web3'
  import contract from 'truffle-contract'
  import artifacts from '../../build/contracts/CreateHunter.json'

  const HunterToken = contract(artifacts)
  export default {
    name: 'UserCollection',
    data () {
      return {
        hunter: {name: "f"},
      }
    },
    created() {
      if (typeof web3 !== 'undefined') {
        console.warn("Using web3 detected from external source. If you find that your accounts don't appear or you have 0 Fluyd, ensure you've configured that source properly. If using MetaMask, see the following link. Feel free to delete this warning. :) http://truffleframework.com/tutorials/truffle-and-metamask")
        // Use Mist/MetaMask's provider
        web3 = new Web3(web3.currentProvider)
      } else {
        console.warn("No web3 detected. Falling back to http://127.0.0.1:8545. You should remove this fallback when you deploy live, as it's inherently insecure. Consider switching to Metamask for development. More info here: http://truffleframework.com/tutorials/truffle-and-metamask")
        // fallback - use your fallback strategy (local node / hosted node + in-dapp id mgmt / fail)
        web3 = new Web3(new Web3.providers.HttpProvider("http://127.0.0.1:8545"))
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
        HunterToken.deployed()
          .then((instance) => instance.address)
          .then((address) => {
            this.contractAddress = address
            this.getUserHunter();
          })
      })
    },
    methods: {
      createHunter(name) {
        return CryptoZombies.methods.createRandomZombie(name)
        .send({ from: userAccount })
        .on("receipt", function(receipt) {
          $("#txStatus").text("Successfully created " + name + "!");
          // Transaction was accepted into the blockchain, let's redraw the UI
          getZombiesByOwner(userAccount).then(displayZombies);
        })
        .on("error", function(error) {
          // Do something to alert the user their transaction has failed
          $("#txStatus").text(error);
        });

      getUserHunter(tokenId) {
        HunterToken.deployed().then((instance) => instance.getOwnHunter(tokenId, { from: this.account })).then((r) => {
          let hunter = {
            "name": null,
            "level": null,
            "attack": null
          } 
          console.log(r)
          hunter["name"] = r[0].toString();
          hunter.level = r[1].toString();
          hunter.attack = r[3].toString();
        })
      }
    }
  }
</script>

<style>

</style>