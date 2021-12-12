var express = require('express');
var router = express.Router();
const lightwallet = require('eth-lightwallet');
const fs = require('fs');

router.post('/newMnemonic', async (req, res) => {
  let mnemonic;
  try {
    mnemonic = lightwallet.keystore.generateRandomSeed();
    res.json({ mnemonic });
  } catch (err) {
    console.log(err);
  }
});

router.post('/newWallet', async (req, res) => {
  let password = req.body.password;
  let mnemonic = req.body.mnemonic;

  try {
    lightwallet.keystore.createVault(
      {
        password: password,
        seedPhrase: mnemonic,
        hdPathString: "m/0'/0'/0'",
      },
      function (err, ks) {
        ks.keyFromPassword(password, function (err, pwDerivedKey) {
          ks.generateNewAddress(pwDerivedKey, 1);

          let address = ks.getAddresses().toString();
          let keystore = ks.serialize();

          fs.writeFile('wallet.json', keystore, function (err, data) {
            if (err) {
              res.json({ code: 999, message: 'Failed!' });
            } else {
              res.json({ code: 1, message: 'Success' });
            }
          });
        });
      }
    );
  } catch (exception) {
    console.log('NewWallet ==>>>> ' + exception);
  }
});

// router.post('/newWallet', async (req, res) => {
//   let password = req.body.password;
//   let mnemonic = req.body.mnemonic;

//   try {
//     lightwallet.keystore.createVault(
//       {
//         password: password,
//         seedPhrase: mnemonic,
//         hdPathString: "m/0'/0'/0'",
//       },
//       function (err, ks) {
//         ks.keyFromPassword(password, function (err, pwDerivedKey) {
//           ks.generateNewAddress(pwDerivedKey, 1);

//           let address = ks.getAddresses().toString();
//           let keystore = ks.serialize();

//           res.json({ keystore: keystore, address: address });
//         });
//       }
//     );
//   } catch (exception) {
//     console.log('NewWallet ==>>>> ' + exception);
//   }
// });

module.exports = router;
