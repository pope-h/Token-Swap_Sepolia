// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {TokenSwap} from "../contracts/TokenSwap.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract TokenSwapTest is Test {
    TokenSwap tokenSwap;
    IERC20 tokenETH;
    IERC20 tokenLINK;
    IERC20 tokenDAI;

    address ETHAccount = address(0x477b144FbB1cE15554927587f18a27b241126FBC);    
    address DAIAccount = address(0xe902aC65D282829C7a0c42CAe165D3eE33482b9f);
    address LINKAccount = address(0x6a37809BdFC0aC7b73355E82c1284333159bc5F0);

    function setUp() public {

        tokenSwap = new TokenSwap();

        tokenETH = IERC20(0x7b79995e5f793A07Bc00c21412e50Ecae098E7f9);
        tokenLINK = IERC20(0x779877A7B0D9E8603169DdbD7836e478b4624789);
        tokenDAI = IERC20(0x3e622317f8C93f7328350cF0B56d9eD4C620C5d6);
    }

    function testDeploy() public view {
        assertEq(address(tokenSwap) != address(0), true);
        console.log("Contract deployed to: ", address(tokenSwap));
    }

    function testSwapETHForLINK() public {
        switchSigner(LINKAccount);
        uint256 initialBalance = tokenLINK.balanceOf(address(this));
        console.log("Initial LINK balance: ", initialBalance);

        // Approve the TokenSwap contract to spend ETH
        tokenETH.approve(address(tokenSwap), 1 ether);

        // Call the swap function
        tokenSwap.swapETHForLINK(1 ether);

        // Check that the LINK balance increased
        assertEq(tokenLINK.balanceOf(address(this)), initialBalance + 1   ether);
    }

    function mkaddr(string memory name) public returns (address) {
        address addr = address(
            uint160(uint256(keccak256(abi.encodePacked(name))))
        );
        vm.label(addr, name);
        return addr;
    }

    function switchSigner(address _newSigner) public {
        address foundrySigner = 0x1804c8AB1F12E6bbf3894d4083f33e07309d1f38;
        if (msg.sender == foundrySigner) {
            vm.startPrank(_newSigner);
        } else {
            vm.stopPrank();
            vm.startPrank(_newSigner);
        }
    }
}
