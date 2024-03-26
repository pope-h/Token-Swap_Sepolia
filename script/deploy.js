const foundry = require("foundry");
const path = require("path");

async function deploy() {
  // Compile the contract
  const compiled = await foundry.compile({
    files: [path.resolve(__dirname, "../contracts/TokenSwap.sol")],
  });

  // Deploy the contract
  const deployed = await foundry.deploy({
    contract: compiled.contracts["TokenSwap"],
    network: "sepolia",
  });

  // Print the address
  console.log(`Contract deployed at address: ${deployed.address}`);
}

deploy().catch(console.error);
