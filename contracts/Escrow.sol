pragma solidity ^0.5.2;

import 'openzeppelin-solidity/contracts/ownership/Ownable.sol';
import 'openzeppelin-solidity/contracts/payment/escrow/Escrow.sol';
import 'openzeppelin-solidity/contracts/math/SafeMath.sol';

/**
  * @title Escrow Payment Gateway using Solidity, Truffle, and OpenZeppelin
  * @author David Senack
  */

contract PaymentGateway is Ownable {
  using SafeMath for uint256;
  Escrow escrow;
  address payable wallet;


  // @param _wallet recieves funds from the payment gateway
  constructor(address payable _wallet) public {
    escrow = new Escrow();
    wallet = _wallet;
  }

  // Recieves payments from customers
  function sendPayment() external payable {
    escrow.deposit.value(msg.value)(wallet);
  }

  // With funds to wallet
  function withdraw() external onlyOwner {
    escrow.withdraw(wallet);
  }

  // Check balance available to withdraw and return the balance
  function balance() external view onlyOwner returns (uint256) {
    return escrow.depositsOf(wallet);
  }
}

