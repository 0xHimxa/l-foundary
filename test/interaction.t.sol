// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

import {Test,console} from "forge-std/Test.sol";
import {Fundme} from "../src/fund-me.sol";
import {DeployFundMe} from  "../script/deploy-fundme.s.sol";
import {FundFundMe,WithdrawFundMe} from '../script/interactions.s.sol';

// contract here test to make sure our interactions are doing as planed
contract FundmeTests is Test {
    Fundme fundme;
// makeAddr create and unique address for user
address USER = makeAddr('user');
uint256 newBalance = 10 ether;




 function setUp() external{
        // fundme = new Fundme(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        
        // check the scrpt we add the address thier and it returned fundme

        DeployFundMe deployfundme = new DeployFundMe();

        fundme = deployfundme.run();
// this deal allow us to set eth to a similated address
vm.deal(USER, newBalance);
        
    }





    function testUserCanFundInteraction() public {

       FundFundMe fundFundme = new FundFundMe();
       fundFundme.fundFundMe(address(fundme));


       WithdrawFundMe withdrawfundme = new WithdrawFundMe();
       withdrawfundme.withdrawFundMe(address(fundme));


       assert(address(fundme).balance == 0);
    }



}