const {
  chainNameById,
  chainIdByName,
  log,
} = require('../js-helpers/deploy')
const { upgrades } = require('hardhat')
const _ = require('lodash')
let sleep = async (time) => new Promise((resolve) => setTimeout(resolve, time))
module.exports = async (hre) => {
  const { ethers } = hre
  const network = await hre.network

  const signers = await ethers.getSigners()
  const chainId = chainIdByName(network.name)

  log('\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
  log(' StakingRouter deployment')
  log('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n')

  log('  Using Network: ', chainNameById(chainId))
  log('  Using Accounts:')
  log('  - Deployer:          ', signers[0].address)
  log('  - network id:          ', chainId)
  log(' ')

  let routerAddress = require(`../deployments/${chainId}/sVIC.json`).address
  log('Deploying sVIC...')

  const sVIC = await ethers.getContractFactory('sVIC');
  const stakingRouterInstance = await sVIC.deploy()
  const newRouter = await stakingRouterInstance.deployed()
  log('new sVIC address : ', newRouter.address)

  await sleep(5000)

  log('upgrade to new implement...')
  let router = await sVIC.attach(routerAddress)
  await router.upgradeTo(newRouter.address, {gasLimit: '500000'})
  // console.log('set staking router')
  // await router.setStakingRouter('0x888849eA163c3b12145c62202AAf9A8cfBD2688d', {gasLimit: '100000000'})


  log('\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n')
}

module.exports.tags = ['sVIC_upgrade']
