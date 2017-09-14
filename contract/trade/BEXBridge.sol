pragma solidity ^0.4.16;

contract BEXBridge {
    address owner;
    mapping(string => address) tokens;
    address bankAddr;
    
    function BEXBridge() {
        owner = msg.sender;
    }
    
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }
    
    function getBankAddr() constant returns (address) {
        return bankAddr;
    }
    
    function setBankAddr(address _addr) onlyOwner returns (bool) {
        bankAddr = _addr;
    }
    
    function addToken(string _name, address _addr) onlyOwner returns (bool) {
        tokens[_name] = _addr;
    }
    
    function delToken(string _name) onlyOwner returns (bool) {
        delete tokens[_name];
    }
    
    function getToken(string _name) constant returns (address) {
        return tokens[_name];
    }
    
    function notifyAccountActivated() {
        NotifyAccountActivated(msg.sender);
    }
    
    event NotifyAccountActivated(address indexed addr);
}
