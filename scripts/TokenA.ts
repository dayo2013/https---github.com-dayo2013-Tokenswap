import { ethers } from "hardhat";

async function main() {


    const TokenA = await ethers.deployContract("TokenA");

    await TokenA.waitForDeployment();


  console.log(TokenA.target)
    
}


main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
