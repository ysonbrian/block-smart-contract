// getBalance.js

const Web3 = require('web3');
const rpcURL = 'https://ropsten.infura.io/v3/5952991dbad84582bdead8a1af063db4'; // 원격 이더리움 노드에 접속할 수 있는 주소

const web3 = new Web3(rpcURL); // web3 객체 생성

const account = '0x0882a60e80E4163c8b45c592483819B38a9E5AFb';

web3.eth
  .getBalance(account)
  .then((bal) => {
    console.log(`지갑 ${account}의 잔액은... ${bal}입니다.`);
    return web3.utils.fromWei(bal, 'ether');
  })
  .then((eth) => {
    console.log(`이더 단위로는 ${eth} ETH 입니다.`);
  });
