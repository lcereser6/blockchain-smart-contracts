import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";

const config: HardhatUserConfig = {
  solidity: "0.8.19",
};

module.exports = {

  defaultNetwork: "sepolia",
  networks: {
    sepolia: {
      url: "https://sepolia.infura.io/v3/45caed101fc844fd9339247c4358fc4c",
      accounts: ["e0f2611bb5ef78f3a5abf1185541cc17e96455ccc7efc57a66a0718e940bec78"],
    },
    hardhat2: {
      url: "http://127.0.0.1:8545/",
      accpunts: ["0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80"],
    }
  },
  solidity: {
    version: "0.8.23",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200
      }
    }
  },
  paths: {
    sources: "./contracts",
    tests: "./test",
    cache: "./cache",
    artifacts: "./artifacts"
  },

  etherscan: {
    apiKey: "RQ2CIT1QDYVCRA7SVU1UDJKDK64JZ8FDBU",
  },
}


export default config;
