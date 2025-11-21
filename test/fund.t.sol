// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

import {Test,console} from "forge-std/Test.sol";
import {Fundme} from "../src/fund-me.sol";
import {DeployFundMe} from  "../script/deploy-fundme.s.sol";

contract FundmeTests is Test {
    Fundme fundme;
// makeAddr create and unique address for user
address USER = makeAddr('user');
uint256 newBalance = 10 ether;



// inside the setup is where we need to deploy our contract first b4 testing
    function setUp() external{
        // fundme = new Fundme(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        
        // check the scrpt we add the address thier and it returned fundme

        DeployFundMe deployfundme = new DeployFundMe();

        fundme = deployfundme.run();
// this deal allow us to set eth to a similated address
vm.deal(USER, newBalance);
        
    }


    function testMinimumUsd()public{
// asserteq is use for checking if to condition are meant
        assertEq(fundme.MINIMUM_USD(),5e18);
        //console.log(fundme.MINIMUM_USD(), 'check');

    }

   
    function testOnwerIsSender()public{
// asserteq is use for checking if to condition are meant


       // console.log(fundme.i_owner(), 'check',address(this));
        assertEq(fundme.getOwner(),msg.sender);
        //console.log(fundme.MINIMUM_USD5e18);


    }



    function testAggV() external {
    uint256  version = fundme.getVersion();

    assertEq(version, 4);
    console.log(version);

    }



   function testFundFailNoEnoughtETH() public{
    // this expect revert means we expect the next line after it to fail
    // if the line didnot fail we weill have an error
 vm.expectRevert();
 fundme.fundme();




   } 


  function testAmountFunded()public funded{
//this vm.prank tell solidity to use  the address pass to it to send the tx below it



    uint256 amountFunded = fundme.getAmountFunded(USER);
 assertEq(amountFunded,10e18);

    
  }



  function testFunders() public funded{



  address funderAddress = fundme.getfunder(0);
 assertEq(funderAddress,USER);

  
  } 


 function testOnlyOwnerCanWithdraw()public funded{


vm.expectRevert();
vm.prank(USER);
fundme.withdraw();

 


 }


 modifier funded(){
    vm.prank(USER);
 fundme.fundme{value:10e18}();

 _;
 }


function testWtidrawWithASingleFunder() public funded{

//arrange
uint256 startingOwnerbalance = fundme.getOwner().balance;
uint256 startingFundMebalance = address(fundme).balance;

//act

vm.prank(fundme.getOwner());
fundme.withdraw();


//assert

uint256 endingOwnerBalanece = fundme.getOwner().balance;
uint256 endingFundMeBalance = address(fundme).balance;

assertEq(endingFundMeBalance,0);

assertEq(startingFundMebalance + startingOwnerbalance,endingOwnerBalanece);





}



}