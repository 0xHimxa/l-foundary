// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

import {Test,console} from "forge-std/Test.sol";
import {Fundme} from "../src/fund-me.sol";


contract FundmeTests is Test {
    Fundme fundme;

// inside the setup is where we need to deploy our contract first b4 testing
    function setUp() external{
        fundme = new Fundme();

        
    }


    function testMinimumUsd()public{
// asserteq is use for checking if to condition are meant
        assertEq(fundme.MINIMUM_USD(),5e18);
        //console.log(fundme.MINIMUM_USD(), 'check');

    }

   
    function testOnwerIsSender()public{
// asserteq is use for checking if to condition are meant


       // console.log(fundme.i_owner(), 'check',address(this));
        assertEq(fundme.i_owner(),address(this));
        //console.log(fundme.MINIMUM_USD5e18);


    }



    function testAggV() external {
    uint256  version = fundme.getVersion();

    assertEq(version, 4);
    console.log(version);

    }

}