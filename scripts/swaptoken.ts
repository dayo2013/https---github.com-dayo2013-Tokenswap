import { ethers } from "hardhat";

async function main() {

//address of my deploy contract TokenA and TokenB
    const swaptoken = await ethers.deployContract("DySwap", ["0xa3232FED53F161c21116224A5ac28fFb5d47554b","0x75458C16F1Df059347fb2F67Ee4c0841e685eE71"]);

    await swaptoken.waitForDeployment();


  console.log(swaptoken.target)
    
}


main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
