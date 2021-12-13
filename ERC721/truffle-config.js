module.exports = {
  networks: {
    ganache: {
      host: '127.0.0.1',
      port: 8545,
      network_id: '*',
    },
  },
  // Configure your compilers
  compilers: {
    solc: {
      version: '0.8.7', // Fetch exact version from solc-bin (default: truffle's version)
      // docker: true,        // Use "0.5.1" you've installed locally with docker (default: false)
      settings: {
        evmVersion: 'london',
      },
    },
  },
};
