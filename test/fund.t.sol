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
//gasleft() is a build in fn that tell us how much gas we have left

//uint256 gasStart = gasleft(); //1000 gas


// with this below we set our gas price with iit
//vm.txGasPrice(1);


vm.prank(fundme.getOwner());
fundme.withdraw();  //200 gas

//uint256 gasEnd = gasleft(); //800
 //uint256 gasUsed = gasStart - gasEnd* // we mulitply it by our gass price = tx.gasprice; it a build in 
 // console.log(gasUsed);


//assert

uint256 endingOwnerBalanece = fundme.getOwner().balance;
uint256 endingFundMeBalance = address(fundme).balance;

assertEq(endingFundMeBalance,0);

assertEq(startingFundMebalance + startingOwnerbalance,endingOwnerBalanece);





}


function testMultiFunder() public {
    uint160 funders = 10;
    uint160 startingfunders = 1;

    for(uint160 i = startingfunders; startingfunders < funders; startingfunders++ ){
    //vm.prank
    //vm.deal;

    //hoax do same it fund a wallet then prank


    hoax(address(i), 1 ether);
    fundme.fundme{value: 0.1 ether}();



    }


    uint256 startingOwnerbalance = fundme.getOwner().balance;
uint256 startingFundMebalance = address(fundme).balance;

//anythin in tx in between will be sent as the owner
vm.startPrank(fundme.getOwner());

fundme.withdraw();
vm.stopPrank();

assertEq(address(fundme).balance,0);
assertEq(startingFundMebalance + startingOwnerbalance,fundme.getOwner().balance);

}



}