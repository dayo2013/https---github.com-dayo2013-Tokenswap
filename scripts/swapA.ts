import { ethers } from "hardhat";

async function main() {

  const TokenA = "0xa3232FED53F161c21116224A5ac28fFb5d47554b";
  const TokenB = "0x75458C16F1Df059347fb2F67Ee4c0841e685eE71";
  const swapToken = await ethers.getContractAt("ISWAP", '0x5FDb0D373488D0871a27C87fFb5Dc9163219D2F3')
  const tokenAContract = await ethers.getContractAt('IERC20', TokenA)
//address of the holder(random address)
  const TokenAHolder = "0x5B38Da6a701c568545dCfcB03FcB875f56beddC4"
  const to = "0x5B38Da6a701c568545dCfcB03FcB875f56beddC4"
  
  const AmountinMax = ethers.parseEther('5')

  const TokenAHolderSign = await ethers.getImpersonatedSigner(TokenAHolder);

  console.log("balance before", ethers.formatEther(await tokenAContract.balanceOf(to)))

  await swapToken.connect(TokenAHolderSign).swapTokenBForTokenA(AmountinMax);

  console.log("balance after", ethers.formatEther(await tokenAContract.balanceOf(to)))

}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});