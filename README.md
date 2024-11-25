# GamingTournament Smart Contract

## Overview

The **GamingTournament** smart contract is designed to manage the prize pool and distribute rewards for gaming tournaments on the Ethereum blockchain. It allows the contract owner to add prizes to the pool, announce winners, and distribute the prizes securely and transparently. This contract ensures fairness by automatically calculating and distributing the prize amounts among the winners.

## Features

- **Prize Pool Management**: The owner can add prize money to the pool for each tournament.
- **Winner Announcement**: The owner can announce the winners of the tournament, ensuring the correct participants receive rewards.
- **Prize Distribution**: The contract automatically distributes the prize money equally among the winners.
- **Prize Withdrawal**: Winners can withdraw their prize money after distribution.
- **Balance Checking**: Participants can check their prize balances.
- **Security**: Only the contract owner can add prize money, announce winners, and distribute prizes.
  
## How It Works

The `GamingTournament` contract functions as follows:

1. **Prize Pool Addition**: The contract owner can add Ether to the total prize pool, which is used to reward winners after the tournament.
2. **Winner Announcement**: The owner announces the winners of the tournament by providing their addresses. These winners will receive the prize money.
3. **Prize Distribution**: Once the winners are announced, the contract will automatically divide the total prize pool equally among all winners and add the respective amounts to their balances.
4. **Prize Withdrawal**: Winners can withdraw their prize money at any time after it has been distributed.
5. **Balance Checking**: Any user can check their prize balance at any time to see how much they are eligible to withdraw.

## Contract Structure

### State Variables

- `owner`: The address of the contract owner. Only the owner has permission to add prize money, announce winners, and distribute prizes.
- `totalPrizePool`: The total amount of Ether available for distribution as prizes.
- `balances`: A mapping that tracks the prize balance of each winner.
- `tournamentWinners`: A mapping from tournament ID to a list of winner addresses.
- `prizeDistributed`: A mapping that tracks whether the prizes have already been distributed for a given tournament ID.

### Events

- `PrizeAdded(uint amount)`: Emitted when a new prize amount is added to the prize pool.
- `WinnersAnnounced(uint tournamentId, address[] winners)`: Emitted when the winners for a tournament are announced.
- `PrizeDistributed(uint tournamentId, address winner, uint amount)`: Emitted when a winner’s prize is distributed.

### Functions

#### `addPrize()`

This function allows the contract owner to add Ether to the prize pool. The amount must be greater than zero.

**Parameters**: None

**Modifiers**: `onlyOwner`

**Events**: Emits `PrizeAdded(uint amount)` when a prize is added.

#### `announceWinners(uint tournamentId, address[] calldata winners)`

The contract owner announces the winners for a given tournament ID by providing a list of winner addresses.

**Parameters**:
- `tournamentId`: The ID of the tournament.
- `winners`: An array of addresses representing the winners of the tournament.

**Modifiers**: `onlyOwner`

**Events**: Emits `WinnersAnnounced(uint tournamentId, address[] winners)` when winners are announced.

#### `distributePrizes(uint tournamentId)`

The contract owner distributes the prize money equally among the winners of the tournament. Each winner receives an equal share of the total prize pool.

**Parameters**:
- `tournamentId`: The ID of the tournament for which prizes are to be distributed.

**Modifiers**: `onlyOwner`

**Events**: Emits `PrizeDistributed(uint tournamentId, address winner, uint amount)` for each winner when their prize is distributed.

#### `withdrawPrize()`

Allows users to withdraw their prize money after it has been distributed. The user’s prize balance is reset to zero after the withdrawal.

**Parameters**: None

**Modifiers**: None

#### `checkBalance()`

Allows users to check their current prize balance.

**Parameters**: None

**Returns**: The balance of the caller (prize money available for withdrawal).

## Why Use This Contract?

The **GamingTournament** smart contract is a robust solution for decentralized gaming tournaments. It ensures the following:

- **Transparency**: Players and participants can trust that the prize pool will be divided fairly.
- **Security**: Only the contract owner has control over prize addition, winner announcements, and prize distribution.
- **Efficiency**: The contract automatically calculates the prize distribution, minimizing human error and delays.

## License

This contract is licensed under the MIT License.

## Disclaimer

This contract is designed for educational and demonstration purposes. It is recommended to thoroughly test and audit the contract before deploying it in a production environment.
