//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract WordguessQuiz {
    // This is the hashed of word 'hello' using SHA256
    bytes32 private hashedSecret = 0x2cf24dba5fb0a30e26e83b2ac5b9e29e1b161e5c1fa7425e73043362938b9824;
    
    // This map is used to track if user answered correctly
    mapping (address => bool) public answeredCorrectly;
    
    function Answer(string memory word) public {
        bytes32 hashedWord = sha256(word);
        if (hashedWord == hashedSecret) {
            answeredCorrectly[msg.sender] = true;
            // TODO: Send reward to this user
        }
    }
}