pragma solidity ^0.5.0;

// 声明合约
contract Math {

    // 结构体类型
	struct Vouter {
		uint weight;
		bool voted;
	}

	function addFunc (uint a, uint b) pure public returns (uint) {
		return a+b;
	}
}