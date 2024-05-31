// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;
import "@openzeppelin/contracts-upgradeable/token/ERC20/IERC20Upgradeable.sol";
interface ISVic is IERC20Upgradeable {
    function mintForStake(address recipient, uint256 amount) external;
    function burnForUnstake(address owner, uint256 amount) external;
}
