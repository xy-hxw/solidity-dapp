pragma solidity ^0.5;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Adoption.sol";

contract TestAdoption {

	Adoption adoption = Adoption(DeployedAddresses.Adoption());

	function testUserCanAdoptPet () public {
		uint id = adoption.adopt(8);
		uint expect = 8;
		Assert.equal(id, expect, "Adoption of pet id 8 is right");
	}

	function testGetAdopterAddressByPetId () public {
		address expect = address(this);
		address adopter = adoption.adopters(8);
		Assert.equal(expect, adopter, "Owner of pet id 8 should be recorded");
	}

	function testGetAdopterAddressByPetIdInArray () public {
		address expect = address(this);
		address[16] memory adopters = adoption.getAdopters();
		Assert.equal(expect, adopters[8], "Owner of pet id 8 should be in array");
	}
}