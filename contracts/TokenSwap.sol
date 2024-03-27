// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "lib/chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract TokenSwap {
    // Addresses for the Chainlink Price Feeds for ETH, LINK, and DAI
    AggregatorV3Interface internal priceFeedETH;
    AggregatorV3Interface internal priceFeedLINK;
    AggregatorV3Interface internal priceFeedDAI;

    // ERC20 token interfaces for LINK, and DAI
    IERC20 tokenLINK;
    IERC20 tokenDAI;

    // Constructor with the Chainlink Price Feed addresses and ERC20 token addresses
    constructor() {
        priceFeedETH = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        priceFeedLINK = AggregatorV3Interface(0xc59E3633BAAC79493d908e63626716e204A45EdF);
        priceFeedDAI = AggregatorV3Interface(0x14866185B1962B63C3Ea9E03Bc1da838bab34C19);
        tokenLINK = IERC20(0x779877A7B0D9E8603169DdbD7836e478b4624789);
        tokenDAI = IERC20(0x3e622317f8C93f7328350cF0B56d9eD4C620C5d6);
    }

    // Function to get the latest price of a token using Chainlink Price Feed
    function _getLatestPrice(AggregatorV3Interface priceFeed) internal view returns (uint256) {
        (, int256 price,,,) = priceFeed.latestRoundData();
        return uint256(price);
    }

    // Swap function for ETH to LINK using Chainlink Price Feeds
    function swapETHForLINK(uint256 amountETH) public payable {
        uint256 priceETH = _getLatestPrice(priceFeedETH);
        uint256 priceLINK = _getLatestPrice(priceFeedLINK);

        // Calculate the amount of LINK to send back
        uint256 amountLINK = (amountETH * priceETH) / priceLINK;

        require(tokenLINK.transfer(msg.sender, amountLINK), "Transfer of LINK failed");
    }

    // Swap function for ETH to DAI using Chainlink Price Feeds
    function swapETHForDAI(uint256 amountETH) public payable {
        uint256 priceETH = _getLatestPrice(priceFeedETH);
        uint256 priceDAI = _getLatestPrice(priceFeedDAI);

        // Calculate the amount of DAI to send back
        uint256 amountDAI = (amountETH * priceETH) / priceDAI;

        require(tokenDAI.transfer(msg.sender, amountDAI), "Transfer of DAI failed");
    }

    function swapLINKForDAI(uint256 amountLINK) public {
        uint256 priceLINK = _getLatestPrice(priceFeedLINK);
        uint256 priceDAI = _getLatestPrice(priceFeedDAI);

        uint256 amountDAI = (amountLINK * priceLINK) / priceDAI;

        require(tokenLINK.transferFrom(msg.sender, address(this), amountLINK), "Transfer of LINK failed");
        require(tokenDAI.transfer(msg.sender, amountDAI), "Transfer of DAI failed");
    }

    function swapDAIForLINK(uint256 amountDAI) public {
        uint256 priceDAI = _getLatestPrice(priceFeedDAI);
        uint256 priceLINK = _getLatestPrice(priceFeedLINK);

        uint256 amountLINK = (amountDAI * priceDAI) / priceLINK;

        require(tokenDAI.transferFrom(msg.sender, address(this), amountDAI), "Transfer of DAI failed");
        require(tokenLINK.transfer(msg.sender, amountLINK), "Transfer of LINK failed");
    }

    function swapLINKForETH(uint256 amountLINK) public {
        uint256 priceLINK = _getLatestPrice(priceFeedLINK);
        uint256 priceETH = _getLatestPrice(priceFeedETH);

        uint256 amountETH = (amountLINK * priceLINK) / priceETH;

        require(tokenLINK.transferFrom(msg.sender, address(this), amountLINK), "Transfer of LINK failed");
        payable(msg.sender).transfer(amountETH);
    }

    function swapDAIForETH(uint256 amountDAI) public {
        uint256 priceDAI = _getLatestPrice(priceFeedDAI);
        uint256 priceETH = _getLatestPrice(priceFeedETH);

        uint256 amountETH = (amountDAI * priceDAI) / priceETH;

        require(tokenDAI.transferFrom(msg.sender, address(this), amountDAI), "Transfer of DAI failed");
        payable(msg.sender).transfer(amountETH);
    }
}