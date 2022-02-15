// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract UserAuth {
    struct User{
        bytes32 password;
    }

    mapping(address => User) public users;

    address owner;
    uint registerCost = 10**16;


    modifier onlyOwner(){
        require(msg.sender == owner);
         _;
    }

    constructor() {
        owner = msg.sender;
    }

    function registerUser(string memory password) public returns (bool){
        users[msg.sender] = User(hashFunction(password));
        return true;
    }

    function login(string memory password) view public returns (bool){
        return users[msg.sender].password == hashFunction(password);
    }


    function hashFunction(string memory text) view private returns (bytes32){
        return keccak256(abi.encodePacked(text));
    }
    function compareStringsbyBytes(string memory s1, string memory s2) public pure returns(bool){
        return keccak256(abi.encodePacked(s1)) == keccak256(abi.encodePacked(s2));
    }
}

