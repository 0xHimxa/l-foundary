// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
// this i a fn from chainLink that will be providing us with realtime price of coin
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

library PriceConverter {
    // not library can have storage variables
    // they are for fn

    function getPrice( AggregatorV3Interface _pricefeed) internal view returns (uint256) {
        //the aggreagtor require the contract addres of the coin we want to get is price which we can get from chain
        //it will provide us with the abi as well

        //this part we are distructring the function returned value
        // it returned 5 values so we use , to ingorne some that we dont need
        (, int256 price, , , ) = _pricefeed.latestRoundData();

        return uint256(price * 1e10);
    }

    function getConvertionRate(
        uint256 ethAmount,
        AggregatorV3Interface _pricefeed
    ) internal view returns (uint256) {
        uint256 price = getPrice(_pricefeed);

        uint256 ethamountUsd = (price * ethAmount) / 1e18;

        return ethamountUsd;
    }
}
