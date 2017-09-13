pragma solidity ^0.4.16;

contract BEXAccount {
    address public withdrawAddr;
    address public tradeAddr;
    address public owner;
    bool public activated;
    uint public activateTime;
    address public activateAddr;
    uint public activateFund;
    
    function BEXAccount(address _withdrawAddr, address _tradeAddr) {
        require(_withdrawAddr != 0);
        require(_tradeAddr != 0);
        owner = msg.sender;
        withdrawAddr = _withdrawAddr;
        tradeAddr = _tradeAddr;
        activated = false;
    }
    
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }
    
    function() payable {
        activate();
    }
    
    function activate() payable {
        require(activated == false);
        require(msg.value > 0);
        // return the fund
        assert(withdrawAddr.call.value(msg.value)());
        activated = true;
        activateTime = now;
        activateAddr = msg.sender;
        activateFund = msg.value;
    }
    
    function depositToBank() onlyOwner {
        
    }
    
}
