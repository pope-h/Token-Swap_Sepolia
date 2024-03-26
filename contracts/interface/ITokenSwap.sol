// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

interface ITokenSwap {
    // Swap function for ETH to LINK using Chainlink Price Feeds
    function swapETHForLINK(uint256 amountETH) external;

    // Swap function for ETH to DAI using Chainlink Price Feeds
    function swapETHForDAI(uint256 amountETH) external;
}