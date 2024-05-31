require('dotenv').config()

require('@nomiclabs/hardhat-web3')

const {
  TASK_TEST,
  TASK_COMPILE_GET_COMPILER_INPUT,
} = require('hardhat/builtin-tasks/task-names')

require('@nomiclabs/hardhat-waffle')
require('@nomiclabs/hardhat-etherscan')
require('@nomiclabs/hardhat-ethers')
require('@openzeppelin/hardhat-upgrades')
// require('hardhat-gas-reporter')
require('hardhat-abi-exporter')
require('solidity-coverage')
require('hardhat-deploy-ethers')
require('hardhat-deploy')
require('hardhat-contract-sizer')

// This must occur after hardhat-deploy!
task(TASK_COMPILE_GET_COMPILER_INPUT).setAction(async (_, __, runSuper) => {
  const input = await runSuper()
  input.settings.metadata.useLiteralContent =
    process.env.USE_LITERAL_CONTENT != 'false'
  console.log(`useLiteralContent: ${input.settings.metadata.useLiteralContent}`)
  return input
})

// Task to run deployment fixtures before tests without the need of "--deploy-fixture"
//  - Required to get fixtures deployed before running Coverage Reports
task(TASK_TEST, 'Runs the coverage report', async (args, hre, runSuper) => {
  await hre.run('compile')
  await hre.deployments.fixture()
  return runSuper({ ...args, noCompile: true })
})

module.exports = {
  defaultNetwork: 'hardhat',
  networks: {
    test: {
      url: `http://localhost:8545`,
      // gasPrice: 1e9,
      // gas: 20000000,
      accounts: [process.env.PRIVATE_KEY],
    },
    tomotestnet: {
      url: `https://rpc-testnet.viction.xyz`,
      // gasPrice: 1e9,
      gas: 20000000,
      accounts: [process.env.PRIVATE_KEY],
    },
    vic: {
      url: `https://rpc.viction.xyz`,
      gasPrice: 250000000,
      // gas: 840000000,
      blockGasLimit: 20000000,
      chainId: 88,
      accounts: [process.env.PRIVATE_KEY],
    },
  },
  solidity: {
    version: '0.8.19',
    settings: {
      optimizer: {
        enabled: true,
        runs: 200,
      },
    },
  },
  paths: {
    sources: './contracts',
    tests: './test',
    cache: './cache',
    artifacts: './build/artifacts',
    deploy: './deploy',
    deployments: './deployments',
  },
  mocha: {
    timeout: 20000,
  },
  gasReporter: {
    currency: 'USD',
    gasPrice: 1,
    enabled: process.env.REPORT_GAS ? true : false,
  },
  abiExporter: {
    path: './abi',
    clear: true,
    flat: true,
  },
  etherscan: {
    apiKey: process.env.ETHERSCAN_APIKEY,
  },
}
