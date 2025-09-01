// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

contract erc20 {
    string private name;
    string private symbol;
    uint8 private immutable decimals;
    mapping(address => uint) private balances;
    mapping(address => mapping(address => uint)) private allowance;
    uint private totalSupply;
    constructor(string memory _name, string memory _symbol, uint8 _decimals) {
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
    }
    function balanceOf(address account) external view returns (uint) {
        return balances[account];
    }
}
