import { ethers } from "hardhat";

async function main() {


  const TokenB = await ethers.deployContract("TokenB");

  await TokenB.waitForDeployment();

  console.log(TokenB.target)
    
}


main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
