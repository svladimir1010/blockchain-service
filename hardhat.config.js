// hardhat.config.js
require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config(); // Добавляем импорт dotenv

const SEPOLIA_RPC_URL = process.env.SEPOLIA_RPC_URL;
const PRIVATE_KEY = process.env.PRIVATE_KEY;

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.28", // Убедитесь, что это соответствует версии в вашем контракте
  networks: {
    sepolia: {
      url: SEPOLIA_RPC_URL || "",
      accounts: PRIVATE_KEY ? [PRIVATE_KEY] : [],
      chainId: 11155111, // Chain ID для Sepolia
    },
  },
  etherscan: {
    apiKey: process.env.ETHERSCAN_API_KEY,
  }
};

