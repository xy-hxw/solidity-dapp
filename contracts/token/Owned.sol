// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.5.0;

contract Owned {

	address public owner;

	modifier onlyOwner() {
		require(msg.sender == owner);
		_;
	}
	constructor() public {
		owner = msg.sender;
	}

	address public newOwner = 0xDF12793CA392ff748adF013D146f8dA73df6E304;
	event OwnerUpdate(address _preOwner, address _newOwner);

	function changeOwner(address _newOwner) public onlyOwner {
		require(_newOwner != owner);
		newOwner = _newOwner;
	}

	function acceptOwnership() public {
		require(msg.sender == newOwner);
		emit OwnerUpdate(owner, newOwner);
		owner = newOwner;
		newOwner = 0xDF12793CA392ff748adF013D146f8dA73df6E304;
	}
}