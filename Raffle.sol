// Layout of Contract:
// license
// version
// imports
// errors
// interfaces, libraries, contracts
// Type declarations
// State variables
// Events
// Modifiers
// Functions

// Layout of Functions:
// constructor
// receive function (if exists)
// fallback function (if exists)
// external
// public
// internal
// private
// internal & private view & pure functions
// external & public view & pure functions

//SODX-License-Identifier: MIT-License
pragma solidity 0.8.19;

/*
 * @title A sample Raffle contract
 * @author Jobb Rodriguez
 * @notice Implementing a sample raffle
 * @dev Implements Chainlink VRFv2.5
 */



contract Raffle {
    /* Errors */
    error Raffle__SendMoreToEnterRaffle();

    uint256 private immutable i_entranceFee;

    constructor(uint256 entranceFee) {
        i_entranceFee = entranceFee;
    }

    function enterRaffle() public payable {
        /* Old versions; conditional version is also an old version
        require(msg.value >= i_entranceFee, "Not enough ETH sent!");
        */
        /* Latest version but cannot use due to solidity version
        However, the conditional version saves more gas
        require(msg.value >= i_entranceFee, Raffle__SendMoreToEnterRaffle());
        */
        if (msg.value < i_entranceFee) {
            Raffle__SendMoreToEnterRaffle();
        } 
    }

    function pickWinner() public{

    }

    /* Getter Functions */
    function getEntranceFee() external view returns (uint256) {
        return i_entranceFee;
    }
}
