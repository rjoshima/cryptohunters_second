<template>
  <div class="UserStatus">
    <div>ハンターを作る</div>
    <div>名前は？</div>
    <textarea>{{ hunter.name }}</textarea>
    <button @click="createHunter()">make hunter button</button>
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
       })
    },
    methods: {
      createHunter(name) {
        return HunterToken.methods.createRandomHunter(name)
        .send({ from: this.account })
        .on("receipt", function(receipt) {
          $("#txStatus").text("Successfully created " + name + "!");
          // Transaction was accepted into the blockchain, let's redraw the UI
          getHunterByOwner(this.account).then(displayHunter);
        })
        .on("error", function(error) {
          // Do something to alert the user their transaction has failed
          $("#txStatus").text(error);
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

      getHunterDetails(id) {
        return HunterToken.methods.hunter(id).call()
      },

        
      hunterToOwner(id) {
        return HunterToken.methods.hunterToOwner(id).call()
      },

      getHunterByOwner(owner) {
        return HunterToken.methods.getHunterByOwner(owner).call()
      }
    }
  }
</script>

<style>

</style>