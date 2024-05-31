// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

interface ICandidate {
    // uint256 public capacity;
    // uint256 public maxCap;
    // address public coinbaseAddr;

    struct EpochReward {
        bool IsRewardPaid;
        uint256 rewards;
        uint256 actualRewards; //rewards after paying hardware fee
    }

    function candidateStatus() external view returns (uint256);
    function PROPOSED_STATUS() external view returns (uint256);
    function RESIGNED_STATUS() external view returns (uint256);
    function TotalRewardWithdrawn() external view returns (uint256);

    function stake() payable external;
    function transferStake(address to, uint256 amount) external;
    function unstake(uint256 amount) external;
    function withdrawStake(uint256 blockNumber) external;
    function withdrawStakeByAnyOne(address payable staker, uint256 blockNumber) external;
    function propose() external;
    function withdrawAfterResign(address payable staker, bool checkStakeLock) external;
    function resign() external;
    function communityVote(bool support) external;
    function setSellStake(uint256 amount, uint256 price) external;
    function buyStake(address payable sellStaker) payable external;

    function isWithdrawAfterResignAvailable(address staker, bool checkStateLock) external view returns(bool);
    function isAlreadyWithdrawAfterResign(address staker, bool checkStateLock) external view returns(bool);
    function currentEpoch() external view returns(uint256);

    function getStakerCurrentReward(address staker) external view returns (uint256);
    function withdrawAllRewardsOfStaker(address staker) external;
    function fillRewardsPerEpoch() external;

    function getCurrentStakerCap(address staker) external view returns (uint256);
    function canResign() external view returns(bool);

    function stakerWithdrawDelay() external view returns (uint256);
    function getRewardByEpoch(address staker, uint256 epoch) external view returns (uint256);
    function EpochsReward(uint256 epoch) external view returns (EpochReward memory);
    function getCapacityByEpoch(uint256 epoch) external view returns (uint256);
    function getListStaker() external view returns (address[] memory);
    function isWithdrawn(uint256 blockNumber) external view returns (bool);
    function getWithdrawCap(address staker, uint256 blockNumber) external view returns(uint256);
    function getWithdrawBlockNumbers(address staker) external view returns(uint256[] memory);
    function getStakerTotalReward(address staker) external view returns (uint256);
    function getStakerCapacityByEpoch(uint256 epoch, address staker) external view returns (uint256);
    function getLastWithdrawEpochOfStaker(address staker) external view returns (uint256);
    function computeTotalStakerReward(address staker) external view returns (uint256);
    function computeStakerRewardByEpoch(address staker, uint256 epoch) external view returns (uint256, uint256);
}
