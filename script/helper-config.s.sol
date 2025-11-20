
// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;


import {Script,console} from 'forge-std/Script.sol';
import {MockV3Aggregator} from '../test/mock/mockv3agg.sol';

contract HelperConfig is Script{

 uint8 public constant DECIMALS = 8;
 int256 public constant INITIAL_ANSWER = 2000e8;
   

NetworkConfig public activeNetWork;


constructor(){
// the condition is been check wen we try to deploy our contract if we provide rpc-url it get it chain id to check
//if we dont provide it will default to anvil
if(block.chainid == 11155111){
    activeNetWork = getSepoEthConfig();}

else{
    activeNetWork = getorCreateAnvilEthConfig();

}

}


struct NetworkConfig{
    address priceFeed;
}


function getSepoEthConfig() public pure returns(NetworkConfig memory){
   
NetworkConfig memory sepoConfig  = NetworkConfig({
    priceFeed: 0x694AA1769357215DE4FAC081bf1f309aDC325306});

return sepoConfig;

}


// the reason why it fails if we dont provide real rps is because  the addres those not exit in anvail
// in this function below we deploy own to the mock anvil contract now it will work

function getorCreateAnvilEthConfig() public returns(NetworkConfig memory){
 //this line check if we have already deploy the mockv3agg contract and asgin the value to activeNetWork
 // address(0) it defauild notting wallet
if(activeNetWork.priceFeed != address(0)) {
    return activeNetWork;
}




// we have to deploy our mockv3agg contract local = // i get it from cuase resources it was already written for us

//deploy the mocks
// return it address

vm.startBroadcast();
//check the mock file for better understanting of what happening over here
//the mock accept to arg take a decimal and a initial answer
MockV3Aggregator mockpricefeed = new MockV3Aggregator(DECIMALS,INITIAL_ANSWER);
vm.stopBroadcast();

NetworkConfig memory anvilConfig = NetworkConfig({
    priceFeed: address(mockpricefeed)
});

return anvilConfig;

}



}
   


