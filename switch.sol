// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract DeadmansSwitch {
    address public owner;
    address public beneficiary;
    uint256 public lastAliveBlock;
    uint256 public inactivityLimit = 10; 
    event StillAlive(address indexed owner, uint256 blockNumber);
    event FundsWithdrawn(address indexed beneficiary, uint256 amount);

    constructor(address _beneficiary) payable {
        require(_beneficiary != address(0), "Beneficiary cannot be zero address"); //ChatGPT suggested this... idk why, pls explain if you see this.
        owner = msg.sender;
        beneficiary = _beneficiary;
        lastAliveBlock = block.number;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    function still_alive() public onlyOwner {
        lastAliveBlock = block.number;
        emit StillAlive(msg.sender, block.number);
    }

    function withdraw() public {
        require(block.number > lastAliveBlock + inactivityLimit, "Owner is still alive");
        uint256 contractBalance = address(this).balance;
        require(contractBalance > 0, "No funds to withdraw");

        (bool success, ) = beneficiary.call{value: contractBalance}("");
        require(success, "Transfer failed");

        emit FundsWithdrawn(beneficiary, contractBalance);
    }

    receive() external payable {}
}
