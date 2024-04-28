// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;


contract CaughtWithSlither {
    mapping (address => uint256) public balances;

    function deposit() external payable { 
        balances[msg.sender] += msg.value;
    }

    function withdraw() external {
        uint256 balance = balances[msg.sender];
        require(balance > 0, "Insufficient balance");

        (bool success, ) = msg.sender.call{value: balance}("");
        require(success, "Failed to send Ether");

        balances[msg.sender] = 0;
    }

    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }
}


// example solution (slither should not give a warning):
/**
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

contract CaughtWithSlither is ReentrancyGuard {
    mapping (address => uint256) public balances;

    function deposit() external payable { 
        balances[msg.sender] += msg.value;
    }

    function withdraw() external nonReentrant {
        uint256 balance = balances[msg.sender];
        require(balance > 0, "Insufficient balance");

        balances[msg.sender] = 0;

        (bool success, ) = msg.sender.call{value: balance}("");
        require(success, "Failed to send Ether");

        
    }

    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }
}
 */
