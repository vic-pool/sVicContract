// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

interface IStakingRouter {
    struct WithdrawalState {
        bool isWithdrawn;
        uint256 withdrawalIndex;
        uint256 blockNumber;
        uint256 withdrawalAmount;
        address validator;
        address recipient;
    }

    enum ValidatorType {
        STANDARD,
        STAKING_POOL
    }

    event StakedValidator(address validator, ValidatorType validatorType, uint256 amount, bool isAccrue);
    event StakedAndMintSVic(address user, uint256 vicAmount, uint256 mintSVic);
    event Migrate2Router(address user, uint256 vicAmount, uint256 sAmount);

    event UnstakedValidator(address validator, ValidatorType validatorType, uint256 amount, bool isAccrue);
    event UnstakedAndBurnSVic(address user, uint256 burntSVic, uint256 unstakedVic, uint256 withdrawalBlockNumber);

    event Withdrawal(address user, uint256 amount);
    event AccrueReward(uint256 prevEpochFilled, uint256 lastEpochFilled, uint256 lastFilledReward);

//    function getEpochReward(uint256 epoch) external view returns (uint256);
    function getSVicAmount(uint256 vicAmount) external view returns (uint256);
    function getVicAmount(uint256 sVicAmount) external view returns (uint256);
}
