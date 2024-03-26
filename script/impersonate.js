const { ethers } = require("foundry");

async function main() {
  // Replace with the address of the deployed TokenSwap contract
  const tokenSwapAddress = "0xYourTokenSwapContractAddress";

  // Replace with the address you want to impersonate
  const accountAddress = "0xAb5801a7D398351b8bE11C439e05C5B3259aeC9B";

  await hre.network.provider.request({
    method: "hardhat_impersonateAccount",
    params: [accountAddress],
  });

  const signer = await ethers.getSigner(accountAddress);

  // Get a contract instance
  const TokenSwap = await ethers.getContractFactory("TokenSwap");
  const tokenSwap = TokenSwap.attach(tokenSwapAddress).connect(signer);

  // Call the swapETHForLINK function
  const amountETH = ethers.utils.parseEther("1"); // Swap 1 ETH
  await tokenSwap.swapETHForLINK(amountETH);

  console.log("Swap completed");
}

main();