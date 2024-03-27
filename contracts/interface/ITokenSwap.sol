// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

interface ITokenSwap {
    // Swap function for ETH to LINK using Chainlink Price Feeds
    function swapETHForLINK(uint256 amountETH) external;

    // Swap function for ETH to DAI using Chainlink Price Feeds
    function swapETHForDAI(uint256 amountETH) external;

    function swapLINKForDAI(uint256 amountLINK) external;

    function swapDAIForLINK(uint256 amountDAI)external;

    function swapLINKForETH(uint256 amountLINK) external;

    function swapDAIForETH(uint256 amountDAI) external;
}