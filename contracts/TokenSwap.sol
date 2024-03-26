// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "lib/chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract TokenSwap {
    // Addresses for the Chainlink Price Feeds for ETH, LINK, and DAI
    AggregatorV3Interface internal priceFeedETH;
    AggregatorV3Interface internal priceFeedLINK;
    AggregatorV3Interface internal priceFeedDAI;

    // ERC20 token interfaces for ETH, LINK, and DAI
    IERC20 public tokenETH;
    IERC20 public tokenLINK;
    IERC20 public tokenDAI;

    // Constructor with the Chainlink Price Feed addresses and ERC20 token addresses
    constructor(
        address _priceFeedETH,
        address _priceFeedLINK,
        address _priceFeedDAI,
        address _tokenETH,
        address _tokenLINK,
        address _tokenDAI
    ) {
        priceFeedETH = AggregatorV3Interface(_priceFeedETH);
        priceFeedLINK = AggregatorV3Interface(_priceFeedLINK);
        priceFeedDAI = AggregatorV3Interface(_priceFeedDAI);
        tokenETH = IERC20(_tokenETH);
        tokenLINK = IERC20(_tokenLINK);
        tokenDAI = IERC20(_tokenDAI);
    }

    // Function to get the latest price of a token using Chainlink Price Feed
    function getLatestPrice(AggregatorV3Interface priceFeed) internal view returns (uint256) {
        (, int256 price,,,) = priceFeed.latestRoundData();
        return uint256(price);
    }

    // Swap function for ETH to LINK using Chainlink Price Feeds
    function swapETHForLINK(uint256 amountETH) public {
        uint256 priceETH = getLatestPrice(priceFeedETH);
        uint256 priceLINK = getLatestPrice(priceFeedLINK);

        // Calculate the amount of LINK to send back
        uint256 amountLINK = (amountETH * priceETH) / priceLINK;

        require(tokenETH.transferFrom(msg.sender, address(this), amountETH), "Transfer of ETH failed");
        require(tokenLINK.transfer(msg.sender, amountLINK), "Transfer of LINK failed");
    }

    // Swap function for ETH to DAI using Chainlink Price Feeds
    function swapETHForDAI(uint256 amountETH) public {
        uint256 priceETH = getLatestPrice(priceFeedETH);
        uint256 priceDAI = getLatestPrice(priceFeedDAI);

        // Calculate the amount of DAI to send back
        uint256 amountDAI = (amountETH * priceETH) / priceDAI;

        require(tokenETH.transferFrom(msg.sender, address(this), amountETH), "Transfer of ETH failed");
        require(tokenDAI.transfer(msg.sender, amountDAI), "Transfer of DAI failed");
    }

    // Add similar swap functions for LINK <-> DAI, LINK <-> ETH, and DAI <-> ETH

    // Add other functions and logic as needed

    // 0x694AA1769357215DE4FAC081bf1f309aDC325306
    // 0xc59E3633BAAC79493d908e63626716e204A45EdF
    // 0x14866185B1962B63C3Ea9E03Bc1da838bab34C19
    // 0x7b79995e5f793A07Bc00c21412e50Ecae098E7f9
    // 0x779877A7B0D9E8603169DdbD7836e478b4624789
    // 0x3e622317f8C93f7328350cF0B56d9eD4C620C5d6
}