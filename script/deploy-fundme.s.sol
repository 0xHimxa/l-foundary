// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

import {Script,console} from 'forge-std/Script.sol';
import {Fundme} from '../src/fund-me.sol';
import {HelperConfig} from './helper-config.s.sol';

contract DeployFundMe is Script {


    function run()external returns(Fundme){
  HelperConfig helperConfig = new HelperConfig();
  (address priceFeed)= helperConfig.activeNetWork();


 

 vm.startBroadcast();
 Fundme fundme = new Fundme(priceFeed);
 
 vm.stopBroadcast();
return fundme;
    }
}
