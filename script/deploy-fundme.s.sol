// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

import {Script} from 'forge-std/Script.sol';
import {Fundme} from '../src/fund-me.sol';


contract DeployFundMe is Script {
    function run()external{
 vm.startBroadcast();
 new Fundme();
 vm.stopBroadcast();

    }
}
