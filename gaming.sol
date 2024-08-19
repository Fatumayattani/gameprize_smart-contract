// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract GamingTournament {
    address public owner;
    uint public totalPrizePool;
    mapping(address => uint) public balances;
    mapping(uint => address[]) public tournamentWinners;
    mapping(uint => bool) public prizeDistributed;

    event PrizeAdded(uint amount);
    event WinnersAnnounced(uint tournamentId, address[] winners);
    event PrizeDistributed(uint tournamentId, address winner, uint amount);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can perform this action.");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    // Function to add prize money to the pool
    function addPrize() external payable onlyOwner {
        require(msg.value > 0, "Prize amount must be greater than zero.");
        totalPrizePool += msg.value;
        emit PrizeAdded(msg.value);
    }

    // Function to announce winners and allocate prizes
    function announceWinners(uint tournamentId, address[] calldata winners) external onlyOwner {
        require(!prizeDistributed[tournamentId], "Prizes for this tournament have already been distributed.");
        require(winners.length > 0, "At least one winner must be announced.");

        tournamentWinners[tournamentId] = winners;
        prizeDistributed[tournamentId] = true;
        emit WinnersAnnounced(tournamentId, winners);
    }

    // Function to distribute prizes to winners
    function distributePrizes(uint tournamentId) external onlyOwner {
        require(prizeDistributed[tournamentId], "Winners must be announced before distributing prizes.");

        address[] memory winners = tournamentWinners[tournamentId];
        uint prizePerWinner = totalPrizePool / winners.length;

        for (uint i = 0; i < winners.length; i++) {
            address winner = winners[i];
            balances[winner] += prizePerWinner;
            emit PrizeDistributed(tournamentId, winner, prizePerWinner);
        }

        // Reset the prize pool after distribution
        totalPrizePool = 0;
    }

    // Function for users to withdraw their prize money
    function withdrawPrize() external {
        uint amount = balances[msg.sender];
        require(amount > 0, "No prize money to withdraw.");

        balances[msg.sender] = 0;
        payable(msg.sender).transfer(amount);
    }

    // Function to check the balance of a user
    function checkBalance() external view returns (uint) {
        return balances[msg.sender];
    }
}
