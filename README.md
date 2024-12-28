
# Deadman's Switch Smart Contract (README.MD MADE BY CHATGPT)

This repository contains a Solidity smart contract that implements a Deadman's Switch mechanism. It ensures that if the owner of the contract becomes inactive (does not signal their presence within a defined block interval), the contract automatically transfers its balance to a designated beneficiary. This mechanism prevents funds from being lost due to the owner's incapacity.

---

## Features

1. **Owner Activity Tracking**:  
   The owner signals activity by calling the `still_alive` function, which updates the `lastAliveBlock`.

2. **Automatic Fund Transfer**:  
   If the owner fails to signal their activity within a specified block limit, the beneficiary can withdraw the contract's balance.

3. **Security and Transparency**:  
   The contract includes event logging for actions like signaling activity and fund withdrawal, ensuring clear transaction history.

4. **Flexible Inactivity Limit**:  
   The inactivity limit (default: 10 blocks) can be adjusted before deployment to suit different scenarios.

---

## Functions

- **`constructor(address _beneficiary)`**:  
  Initializes the contract with the owner as the deployer and sets the beneficiary address. The contract is also initialized with an Ether balance if provided.

- **`still_alive()`**:  
  Updates the `lastAliveBlock` to the current block number, signaling the owner's activity. Can only be called by the owner.

- **`withdraw()`**:  
  Transfers the entire balance of the contract to the beneficiary if the owner has been inactive for more than the defined block limit.

- **`receive()`**:  
  Allows the contract to accept Ether directly.

---

## Example Usage

- **Scenario**:  
  The owner deploys the contract with 1 Ether and sets a family member as the beneficiary. They call `still_alive` every 10 blocks. If they stop doing so, the family member can claim the funds.

---

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
