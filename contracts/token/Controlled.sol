// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.5.0;

import "./Owned.sol"; 

contract Controlled is Owned {

	constructor() public {
		setExclude(msg.sender, true);
	}

	// 代币是否可以交易
	bool private transferEnabled = true;
	// 账户锁定功能
	bool private lockFlag = true;

	// 账户被锁定的用户
	mapping(address => bool) private locked;
	// 拥有VIP用户
	mapping(address => bool) private exclude;

	// 设置代币是否可交易
	function enableTransfer(bool enable) public onlyOwner returns (bool success) {
		require(transferEnabled != enable);
		transferEnabled = enable;
		return true;
	}

	// 加黑名单用户
	function disableLock (address addr) public onlyOwner returns (bool success) {
		require(msg.sender != addr);
		locked[addr] = true;
		return true;
	}

	// 设置vip用户
	function setExclude (address addr, bool enable) public onlyOwner returns (bool success) {
		exclude[addr] = enable;
		return true;
	}

	// 解锁Addr用户
	function removeLock(address addr) view public onlyOwner returns (bool success){
		locked[addr] == false;
		return true;
	}

	modifier transferAllowed (address addr) {
		if (exclude[addr]) {
			require(transferEnabled, "transfer is not enabeled now!");
			if (lockFlag) {
				require(!locked[addr], "account is locked");
			}
		}
		_;
	}
}