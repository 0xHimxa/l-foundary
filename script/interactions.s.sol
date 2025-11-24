
// we want to be able to recive money and be able to withdraw
// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;
import {Script,console} from 'forge-std/Script.sol';
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";
import {Fundme} from '../src/fund-me.sol';





// now we can simpel use this script to interact with our contract

contract FundFundMe is Script{
uint256 constant SENDVALUE= 0.1 ether;
function fundFundMe(address recentlyDeployed) public{

       vm.startBroadcast();

       //the line type cast the CA to fundme and then fund it
       Fundme(payable(recentlyDeployed)).fundme{value: SENDVALUE}();
       vm.stopBroadcast(); 
       console.log("funded fundme with", SENDVALUE);
    }

    // this function runs first
  function run() public{

    //this line will go get our recently deployed from broadcast folder run lates get the chainid that match the name
    
    address mostRencentlyDeployed = DevOpsTools.get_most_recent_deployment("fundme", block.chainid);

  fundFundMe(mostRencentlyDeployed);
  }

}



contract WithdrawFundMe is Script{

    uint256 constant SENDVALUE= 0.1 ether;
function withdrawFundMe(address recentlyDeployed) public{

       vm.startBroadcast();
       Fundme(payable(recentlyDeployed)).withdraw();
       vm.stopBroadcast(); 
       console.log("funded fundme with", SENDVALUE);
    }
  function run() public{
    address mostRencentlyDeployed = DevOpsTools.get_most_recent_deployment("fundme", block.chainid);

  withdrawFundMe(mostRencentlyDeployed);
  }

}