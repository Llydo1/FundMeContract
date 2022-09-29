// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol"; 

library PriceConverter{

    function getPrice() view internal returns(uint256){
        (
            /*uint80 roundID*/,
            int256 price,
            /*uint startedAt*/,
            /*uint timeStamp*/,
            /*uint80 answeredInRound*/
        ) = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e).latestRoundData();
        return uint256(price * 1e10) ;
    }

    function getMinimumEth() view internal returns(uint256){
        uint256 MINIMUM_USD = 50 * 1e18;
        return (MINIMUM_USD * 1e18) / getPrice();
    }

    function getConversionRate(uint256 ethAmount) internal view returns(uint256){
        return (getPrice() * ethAmount) / 1e18;
    }
}