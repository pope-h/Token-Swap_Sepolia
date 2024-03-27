// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {TokenSwap} from "../contracts/TokenSwap.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "../contracts/interface/ITokenSwap.sol";

contract TokenSwapTest is Test {
    ITokenSwap tokenSwap;
    IERC20 tokenWETH;
    IERC20 tokenLINK;
    IERC20 tokenDAI;

    address ETHHolder = address(0xd7E0944b3166E0b7e4c3616d0c13A2fC5627cFA5);    
    address LINKHolder = address(0x61E5E1ea8fF9Dc840e0A549c752FA7BDe9224e99);
    address DAIHolder = address(0x511243992D17992E34125EF1274C7DCA4a94C030);
    address Impersonated = address(0x71C7656EC7ab88b098defB751B7401B5f6d8976F);

    function setUp() public {
        tokenSwap = ITokenSwap(0xAD96bEDEf5D193164582922db943604298cB65aA);

        tokenWETH = IERC20(0x7b79995e5f793A07Bc00c21412e50Ecae098E7f9);
        tokenLINK = IERC20(0x779877A7B0D9E8603169DdbD7836e478b4624789);
        tokenDAI = IERC20(0x3e622317f8C93f7328350cF0B56d9eD4C620C5d6);

        uint256 amount = 100 * 10**18;

        // Approve the TokenSwap contract to spend LINK
        tokenLINK.approve(address(tokenSwap), amount);

        // Approve the TokenSwap contract to spend DAI
        tokenDAI.approve(address(tokenSwap), amount);

        // Approve the TokenSwap contract to spend ETH

    }

    function testCheckBalances() public {
        switchSigner(LINKHolder);
        uint256 initialBalance = tokenLINK.balanceOf(LINKHolder);
        console.log("Initial LINK balance: ", initialBalance);
        // 987988129 * 10^18

        switchSigner(DAIHolder);
        uint256 initialBalanceDAI = tokenDAI.balanceOf(DAIHolder);
        console.log("Initial DAI balance: ", initialBalanceDAI);
        // 999998 * 10^18

        switchSigner(Impersonated);
        uint256 initialBalanceETH = address(Impersonated).balance;
        console.log("Initial ETH balance: ", initialBalanceETH);
        // 2000074 * 10^18
    }

    function testSwapETHForLINK() public {
        // // Approve the TokenSwap contract to spend ETH
        // tokenWETH.approve(address(tokenSwap), 1 ether);

        // // Call the swap function
        // tokenSwap.swapETHForLINK(1 ether);

        // // Check that the LINK balance increased
        // // assertEq(tokenLINK.balanceOf(address(this)), initialBalance + 1   ether);
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
