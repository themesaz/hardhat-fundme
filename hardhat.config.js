require("dotenv").config();

require("@nomiclabs/hardhat-etherscan");
require("@nomiclabs/hardhat-waffle");
require("hardhat-gas-reporter");
require("solidity-coverage");
require("hardhat-deploy");


/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  //solidity: "0.8.7",
  solidity:{
    compilers:[
      {version:"0.8.7"},
      {version:"0.6.6"},
    ],
  },
  defaultNetwork:"hardhat",
  networks: {
    rinkeby:{
      url:process.env.RINKEBY_RPC_URL,
      accounts:[process.env.RINKEBY_PRIVATE_KEY],
      chainId:4,
      blockConfirmations:1,
    },
  },
  
  gasReporter: {
    enabled: false,
    currency: "USD",
  },
  etherscan: {
    apiKey: {
      rinkeby: process.env.ETHERSCAN_APIKEY,
    },
  },
  namedAccounts:{
    deployer:{
      default:0,
    },
    user:{
      default:1,
    },
  }
};
