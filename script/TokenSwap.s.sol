// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import "../contracts/TokenSwap.sol";

contract TSwap is TokenSwap {
    constructor() {}

    function getLatestPrice(AggregatorV3Interface priceFeed) external view {
        _getLatestPrice(priceFeed);
    }
}

contract TokenSwapScript is Script {
    function setUp() public {}

    function run() public {
        uint private_key = vm.envUint("DEV_PRIVATE_KEY");
        address account = vm.addr(private_key);
        console.log("Account", account);
        
        // vm.broadcast();

        vm.startBroadcast(private_key);

        TokenSwap tokenSwap = new TokenSwap();
        console.log("Contract deployed to: ", address(tokenSwap));

        vm.stopBroadcast();
    }
}
