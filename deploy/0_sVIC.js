const {
  chainNameById,
  chainIdByName,
  saveDeploymentData,
  getContractAbi,
  log
} = require("../js-helpers/deploy");

let sleep = async (time) => new Promise((resolve) => setTimeout(resolve, time))

module.exports = async (hre) => {
  const { ethers, upgrades, getNamedAccounts } = hre;
  const { deployer } = await getNamedAccounts();
  const network = await hre.network;
  const signers = await ethers.getSigners()
  const deployData = {};

  const chainId = chainIdByName(network.name);
  if (chainId === 31337) return

  log('\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~');
  log('LiquidStaking Protocol - Contract Deployment');
  log('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n');

  log('  Using Network: ', chainNameById(chainId));
  log('  Using Accounts:');
  log('  - Deployer:          ', signers[0].address);
  log('  - network id:          ', chainId);
  log(' ');

  log('  Deploying sVIC...');
  // if (chainId == 1 || chainId == 56 || chainId == 43114 || chainId) mainnet = true
  const sVIC = await ethers.getContractFactory('sVIC');
  const stakingRouter = await upgrades.deployProxy(sVIC, [], {gasLimit: '100000000'})
  await sleep(5000)
  // console.log('set staking router')
  // await stakingRouter.setStakingRouter('0xB885388D0a6E6c1733A3f64551477a133646f386', {gasLimit: '100000000'})

  log('  - sVIC:         ', stakingRouter.address);
  deployData['sVIC'] = {
    abi: getContractAbi('sVIC'),
    address: stakingRouter.address,
    deployTransaction: stakingRouter.deployTransaction
  }
  await sleep(20000)

  saveDeploymentData(chainId, deployData);
  log('\n  Contract Deployment Data saved to "deployments" directory.');
  log('\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n');
};

module.exports.tags = ['sVIC']
