// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

contract erc20 {
    string private name;
    string private symbol;
    uint8 private immutable decimals;
    mapping(address => uint) private balances;
    mapping(address => mapping(address => uint)) private _allowance;
    uint private _totalSupply;

    event Transfer(address indexed from, address indexed to, uint value);

    constructor(string memory _name, string memory _symbol, uint8 _decimals) {
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
        balances[msg.sender] = 100 * 10 ** _decimals;
    }
    function balanceOf(address account) external view returns (uint) {
        return balances[account];
    }

    //Read only functions returning the information about the token
    function nameOf() external view returns (string memory) {
        return name;
    }

    function symbolOf() external view returns (string memory) {
        return symbol;
    }

    function decimalsOf() external view returns (uint8) {
        return decimals;
    }

    function totalSupply() external view returns (uint) {
        return _totalSupply;
    }

    function allowance(
        address owner,
        address spender
    ) external view returns (uint) {
        return _allowance[owner][spender];
    }

    /* transfer function to transfer tokens from one account to another with 
    on chain security that no account transfer more than it has and
    no account can transfer to address(0) */
    function _transfer(address from, address to, uint amount) internal {
        require(balances[from] >= amount, "Not enough balance in the account");
        require(
            to != address(0),
            "Transfer to the zero address is not allowed"
        );
        balances[from] -= amount;
        balances[to] += amount;
        emit Transfer(from, to, amount);
    }

    function transfer(address to, uint amount) external returns (bool) {
        _transfer(msg.sender, to, amount);
        return true;
    }
}
