// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {Token} from "../src/Token.sol";

contract TokenTest is Test {
    Token public token;
    address public owner;

    function setUp() public {
        owner = address(this);
        token = new Token();
    }

    function testInitialSupply() public {
        uint256 expectedSupply = 1000000 * 10 ** token.decimals();
        assertEq(token.totalSupply(), expectedSupply);
        assertEq(token.balanceOf(owner), expectedSupply);
    }

    function testTokenMetadata() public {
        assertEq(token.name(), "Token");
        assertEq(token.symbol(), "TKN");
        assertEq(token.decimals(), 18);
    }

    function testTransfer() public {
        address recipient = address(0x123);
        uint256 amount = 1000 * 10 ** token.decimals();

        // Test transfer
        bool success = token.transfer(recipient, amount);
        assertTrue(success);
        assertEq(token.balanceOf(recipient), amount);
        assertEq(token.balanceOf(owner), token.totalSupply() - amount);
    }
} 