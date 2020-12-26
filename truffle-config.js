const HDWalletProvider = require("@truffle/hdwallet-provider");
const mnemonic = "removed"

module.exports = {
	plugins: [
		'truffle-plugin-verify'
    ],
    
  api_keys:{
    etherscan:'removed'
  },
  /**
   * Networks define how you connect to your ethereum client and let you set the
   * defaults web3 uses to send transactions. If you don't specify one truffle
   * will spin up a development blockchain for you on port 9545 when you
   * run `develop` or `test`. You can ask a truffle command to use a specific
   * network from the command line, e.g
   *
   * $ truffle test --network <network-name>
   */

  networks:{
    development:{
      host:"localhost",
      port:9545
    },

    ropsten: {
      provider: function() {
        return new HDWalletProvider(mnemonic, "https://ropsten.infura.io/v3/removed")
      },
      network_id: 3
    },

    kovan: {
      provider: function() {
        return new HDWalletProvider(mnemonic, "https://kovan.infura.io/v3/removed")
      },
      network_id: 42
    }
  },

  // Configure your compilers
  compilers: {
    solc: {
      version: "^0.6.6"    // Fetch exact version from solc-bin (default: truffle's version)
      // docker: true,        // Use "0.5.1" you've installed locally with docker (default: false)
      // settings: {          // See the solidity docs for advice about optimization and evmVersion
      //  optimizer: {
      //    enabled: false,
      //    runs: 200
      //  },
      //  evmVersion: "byzantium"
      // }
    },
  },
};
