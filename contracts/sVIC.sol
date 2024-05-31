// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts-upgradeable/token/ERC20/utils/SafeERC20Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/IERC20Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";

import "./UpgradeableBase.sol";
contract sVIC is UpgradeableBase, ERC20Upgradeable {
    using SafeERC20Upgradeable for IERC20Upgradeable;

    address public stakingRouter;

    mapping (address => bool) public lockUsers;

    function initialize() external initializer {
        __UpgradeableBase_initialize();
        __ERC20_init("Staked VIC", "sVIC");
    }

    function setStakingRouter(address _stakingRouter) onlyOwner external {
        stakingRouter = _stakingRouter;
    }

    function mintForStake(address recipient, uint256 amount) external {
        require(msg.sender == stakingRouter, "only stakingRouter");
        _mint(recipient, amount);
    }

    function burnForUnstake(address owner, uint256 amount) external {
        require(msg.sender == stakingRouter, "only stakingRouter");
        _burn(owner, amount);
    }

    function updateBlacklist(address[] memory users, bool lock) external onlyOwner {
        for (uint256 i =0; i < users.length; i++) {
            lockUsers[users[i]] = lock;
        }
    }

    function _transfer(address sender, address recipient, uint256 amount) internal virtual override {
        require(!lockUsers[sender], "!The sender is locked");
        super._transfer(sender, recipient, amount);
    }
}
