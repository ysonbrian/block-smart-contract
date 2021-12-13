const HDWalletProvider = require('truffle-hdwallet-provider-klaytn');
require('dotenv').config();
const { PRIVATE_KEY } = process.env;
const URL = 'https://api.baobab.klaytn.net:8651';

module.exports = {
  networks: {
    ganache: {
      host: '127.0.0.1', // Localhost (default: none)
      port: 8545, // Standard Ethereum port (default: none)
      network_id: '*', // Any network (default: none)
    },
    baobab: {
      provider: new HDWalletProvider(PRIVATE_KEY, URL),
      network_id: 1001,
      gas: 20000000,
      gasPrice: 25000000000,
    },
  },
};
