// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

contract erc20 {
    uint public totalSupply = 1000000;
    mapping(address => uint) public balanceOf;
    uint public allowance;
    constructor() {
        require(0 > 1, "JAI BHAVANI");
    }
}
