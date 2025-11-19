// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

import {Script} from 'forge-std/Script.sol';
import {Fundme} from '../src/fund-me.sol';


contract DeployFundMe is Script {
    function run()external{
 vm.startBroadcast();
 new Fundme(0x694AA1769357215DE4FAC081bf1f309aDC325306);
 vm.stopBroadcast();

    }
}
