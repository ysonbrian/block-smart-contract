const Web3 = require('web3');
const rpcURL = 'https://ropsten.infura.io/v3/5952991dbad84582bdead8a1af063db4';

const web3 = new Web3(rpcURL);

const txId =
  '0xcde7dd723f9eca5dd48846254571588cdd1586e021efdbdd1b06e9fe2d76d0c9';

web3.eth.getTransaction(txId).then((obj) => {
  console.log(obj);
});
