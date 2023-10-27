// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

contract DeadmanSwitch {

    address public owner;
    address public presetAdd;
    uint public lastBlock;

    constructor(address _preset)
    {
        owner = msg.sender;
        presetAdd = _preset;
        lastBlock = block.number;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    function still_alive() internal onlyOwner {
        lastBlock = block.number;
    }

    function trigger_switch() public payable {
        require(block.number - lastBlock > 10, "The Owner is still active!");
        uint balance = owner.balance;
        require(balance > 0, "Zero Funds");
        payable(presetAdd).transfer(balance);  
    }

}
