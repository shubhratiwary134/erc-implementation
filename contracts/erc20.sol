// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

contract erc20 {
    string public name;
    string public symbol;
    uint8 public immutable decimals;
    mapping(address => uint) public balanceOf;
    mapping(address => mapping(address => uint)) public allowance;
    uint private totalSupply;
    constructor() {}
}
