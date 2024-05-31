// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

interface ITomoMaster {
    function getCandidateCap(address candidate) external view returns(uint256);
    function getVoterCap(address candidate, address voter) external view returns(uint256);

    function propose(address _candidate) external payable;
    function vote(address _candidate) external payable;
    function getCandidates() external view returns(address[] memory);
    function getCandidateOwner(address _candidate) external view returns(address);
    function getVoters(address _candidate) external view returns(address[] memory);
    function isCandidate(address _candidate) external view returns(bool);
    function getWithdrawBlockNumbers() external view returns(uint256[] memory);
    function getWithdrawCap(uint256 _blockNumber) external view returns(uint256);
    function unvote(address _candidate, uint256 _cap) external;
    function resign(address _candidate) external;
    function withdraw(uint256 _blockNumber, uint _index) external;

    function voterWithdrawDelay() external view returns (uint256);
    function minVoterCap() external view returns (uint256);
}
