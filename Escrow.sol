pragma solidity ^0.5.0;

contract Escrow {
    // person who officiates the transaction on the blockchain (only person allowed to deposit/withdraw from transaction).
    // person with permission who can deploy the smartcontract
    address agent;
    mapping(address => uint256) public deposits;
    // agent can deposits funds into Escrow smartcontract and make sure they pay the correct person
    modifier onlyAgent() {
        require(msg.sender == agent);
        _;
        // require will pass the modifier if it is true
    }

    constructor () public {
        agent = msg.sender;
        // sender is the address to deploy the contract
    }

    function deposit(address payee) public onlyAgent payable {
        uint256 amount = msg.value;
        deposits[payee] = deposits[payee] + amount;
        // use safeMath for legitimacy but using addition here
    }

    function withdraw(address payable payee) public onlyAgent {
        uint256 payment = deposits[payee];
        deposits[payee] = 0;
        payee.transfer(payment);
    }
}

