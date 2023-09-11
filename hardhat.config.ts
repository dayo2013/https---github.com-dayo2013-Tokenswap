
import { HardhatUserConfig } from 'hardhat/config'
import '@nomicfoundation/hardhat-toolbox'
import 'dotenv/config'
require('dotenv').config()

const config: HardhatUserConfig = {
  solidity: '0.8.19',
  networks: {
    sepolia: {
      url: process.env.SEPOLIARPC,
      //@ts-ignore
      accounts: [process.env.PRIVATEKEY],
    },

  },
  etherscan: {
    apiKey: process.env.ETHERSCAN_API_KEY,
  },
}
  //   base: {
  //     url: process.env.BASERPC,
  //     //@ts-ignore
  //     accounts: [process.env.PRIVATEKEY],
  //   },
  // },

export default config;