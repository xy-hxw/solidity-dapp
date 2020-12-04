// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.5.0;

library SafeMath {
    
    function mul(uint a, uint b) internal pure returns (uint) {
        uint c = a * b;
        assert(a==0 || c/a==b);
        return c;
    }
    
    function div(uint a, uint b) internal pure returns (uint) {
        assert(b != 0);
        uint c = a / b;
        return c;
    }
    
    function sub(uint a, uint b) internal pure returns (uint256) {
        assert(b <= a);
        return a - b;
    }
    
    function add(uint a, uint b) internal pure returns (uint256) {
        uint c = a + b;
        assert(c>=a && c>=b);
        return c;
    }
}