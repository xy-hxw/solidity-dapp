pragma solidity ^0.5;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Math.sol";

contract TestMath {

	Math math = Math(DeployedAddresses.Math());

	function testMath () public {
		uint sum = math.addFunc(2, 4);
		uint expect = 6;
		Assert.equal(sum, expect, "Sum is right");
	}

}