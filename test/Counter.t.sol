// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Counter} from "../src/Counter.sol";
import {TokenSwap} from "../contracts/TokenSwap.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract CounterTest is Test {
    // Counter public counter;
    TokenSwap tokenSwap;
    IERC20 tokenETH;
    IERC20 tokenLINK;
    IERC20 tokenDAI;

    function setUp() public {
        // counter = new Counter();
        // counter.setNumber(0);

        // 0x694AA1769357215DE4FAC081bf1f309aDC325306
        // 0xc59E3633BAAC79493d908e63626716e204A45EdF
        // 0x14866185B1962B63C3Ea9E03Bc1da838bab34C19
        // 0x7b79995e5f793A07Bc00c21412e50Ecae098E7f9
        // 0x779877A7B0D9E8603169DdbD7836e478b4624789
        // 0x3e622317f8C93f7328350cF0B56d9eD4C620C5d6

        tokenSwap = new TokenSwap(
            0x694AA1769357215DE4FAC081bf1f309aDC325306, 0xc59E3633BAAC79493d908e63626716e204A45EdF, 0x14866185B1962B63C3Ea9E03Bc1da838bab34C19, 0x7b79995e5f793A07Bc00c21412e50Ecae098E7f9, 0x779877A7B0D9E8603169DdbD7836e478b4624789, 0x3e622317f8C93f7328350cF0B56d9eD4C620C5d6
        );

        // address(Victim) = 0xbf4EE65FE67C291DfC34ffe2455ecA9d97DF9148;

        tokenETH = IERC20(0x7b79995e5f793A07Bc00c21412e50Ecae098E7f9);
        tokenLINK = IERC20(0x779877A7B0D9E8603169DdbD7836e478b4624789);
        tokenDAI = IERC20(0x3e622317f8C93f7328350cF0B56d9eD4C620C5d6);
    }

    function testDeploy() public view {
        assertEq(address(tokenSwap) != address(0), true);
        console.log("Contract deployed to: ", address(tokenSwap));
    }

    // function testSwapETHForLINK() public {
    //     uint256 initialBalance = tokenLINK.balanceOf(address(this));

    //     // Approve the TokenSwap contract to spend ETH
    //     tokenETH.approve(address(tokenSwap), 1 ether);

    //     // Call the swap function
    //     tokenSwap.swapETHForLINK(1 ether);

    //     // Check that the LINK balance increased
    //     assertEq(tokenLINK.balanceOf(address(this)), initialBalance + 1   ether);
    // }
}
