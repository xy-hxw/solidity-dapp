// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.5.0;

import "./StandardToken.sol";
import "./Controlled.sol"; 

contract HdToken is StandardToken, Controlled {

	mapping(address => uint) public balances;
	mapping(address => mapping (address => uint)) internal allowed;

	constructor () public {
		name = "HdToken";
		symbol = "Hd";
		decimals = 0;
		totalSupply = 10000;
		balances[msg.sender] = totalSupply;
	}

	function balanceOf(address _owner) public view returns (uint256 balance) {
		return balances[_owner];
	}

	// function transfer(address _to, uint256 _value) public transferAllowed(msg.sender) returns (bool success) {
	// 	require(_to != address(0));
	// 	require(_value <= balances[msg.sender]);
	// 	balances[msg.sender] = balances[msg.sender].sub(_value);
	// 	balances[_to] = balances[_to].add(_value);
	// 	emit Transfer(msg.sender, _to, _value);
	// 	return true;
	// }

	function transfer(address _to, uint256 _value) public returns (bool success) {
		balances[msg.sender] = balances[msg.sender].sub(_value);
		balances[_to] = balances[_to].add(_value);
		return true;
	}

	function transferFrom(address from, address to, uint value) public transferAllowed(from) returns (bool success) {
		require(to != address(0));
		require(value <= balances[from]);
		require(value <= allowed[from][msg.sender]);

		balances[from] = balances[from].sub(value);
		balances[to] = balances[to].add(value);
		allowed[from][msg.sender] = allowed[from][msg.sender].sub(value);
		emit Transfer(from, to, value);
		return true;
	}

	function approve (address sender, uint value) public returns (bool success) {
		allowed[msg.sender][sender] = value;
		emit Approval(msg.sender, sender, value);
		return true;
	}

	function allowance(address _owner,  address _spender) public view returns (uint remaining) {
		return allowed[_owner][_spender];
	}

}