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
    // @dev The duration of the lottery in seconds
    uint256 private immutable i_interval;
    // What data structure should we use to track players?
    address payable[] private s_players;
    uint256 private s_lastTimeStamp;

    /* Events */
    event RaffleEntered(address indexed player);

    constructor(uint256 entranceFee, uint256 interval) {
        i_entranceFee = entranceFee;
        i_interval = interval;
        s_lastTimeStamp = block.timestamp;
    }

    function enterRaffle() external payable {
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
        s_players.push(payable(msg.sender));
        // Update a storage variable when updating a storage event.
        // 1. Makes migration easier
        // 2. Makes front end "indexing" easier
        emit RaffleEntered(msg.sender);
    }

    /* 
        1. Get a random number
        2. Use a random nunmber to pick a player
        3. Be automatically called
    */
    function pickWinner() external {
        if((block.timestamp - s_lastTimeStamp) < i_interval) {
            revert();
        }
    }

    /* Getter Functions */
    function getEntranceFee() external view returns (uint256) {
        return i_entranceFee;
    }
}
