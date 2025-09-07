// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

contract erc20 {
    string private name;
    string private symbol;
    uint8 private immutable decimals;
    mapping(address => uint) private balances;
    mapping(address => mapping(address => uint)) private _allowances;
    uint private _totalSupply;

    event Transfer(address indexed from, address indexed to, uint value);
    event Approve(address indexed owner, address indexed spender, uint amount);

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
        return _allowances[owner][spender];
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

    function approve(address spender, uint amount) public returns (bool) {
        require(
            spender != address(0),
            "Approve to the zero address is not allowed"
        );
        _allowances[msg.sender][spender] = amount;
        emit Approve(msg.sender, spender, amount);
        return true;
    }

    function transferFrom(
        address from,
        address to,
        uint amount
    ) external returns (bool) {
        require(
            _allowances[from][msg.sender] >= amount,
            "Not Authorized for that much amount"
        );
        _transfer(from, to, amount);
        _allowances[from][msg.sender] -= amount;
        return true;
    }

    function _mint(address to, uint amount) internal {
        require(to != address(0), "minting to address 0 not allowed");
        _totalSupply += amount;
        balances[to] += amount;
        emit Transfer(address(0), to, amount);
    }

    function _burn(address from, uint amount) internal {
        require(
            from != address(0),
            "Burning from the address 0 is not allowed "
        );
        require(
            balances[from] >= amount,
            "Cant burn more than the amount itself"
        );
        balances[from] -= amount;
        _totalSupply -= amount;
        emit Transfer(from, address(0), amount);
    }

    function increaseAllowance(address spender, uint amount) external {
        uint addedAmount = _allowances[msg.sender][spender] + amount;
        approve(spender, addedAmount);
    }
    function decreaseAllowance(address spender, uint amount) external {
        require(
            _allowances[msg.sender][spender] >= amount,
            "Cannot decrease allowance to less than 0"
        );
        uint subtractedAmount = _allowances[msg.sender][spender] - amount;
        approve(spender, subtractedAmount);
    }
}
