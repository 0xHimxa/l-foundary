// SPDX-License-Identifier: MIT

pragma solidity 0.8.30;

import { Script } from  "forge-std/Script.sol";
import { SimpleStroge } from "../src/simple-store.sol";

contract DeploySimpleStore is Script{
   // inside we need our main function called run is , it the coommand th
   //at is going to get called wen we go deploy our contract

 function run() external returns(SimpleStroge){


// any thing in between is what is going to be sennt to the rpc
// so we have to make it only the deployement 


    vm.startBroadcast();
   SimpleStroge simplestroage = new SimpleStroge();


    vm.stopBroadcast();

    return simplestroage;

 }

}
