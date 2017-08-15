pragma solidity ^0.4.11;

contract BEXCommon {
    address owner;
    address clearingAddr;
    mapping(string => address) tokenAddrs;
    bool collectEnabled;
    
    function BEXCommon() {
        owner = msg.sender;
    }
    
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }
    
    /**
     * get the clearing contract address
     */
    function getClearingAddr() constant returns (address) {
        return clearingAddr;
    }
    
    /**
     * set the clearing contract address for use
     */
    function setClearingAddr(address _clearingAddr) onlyOwner returns (bool) {
        clearingAddr = _clearingAddr;
        return true;
    }
    
    /**
     * return the token's contract address for given token's symbol
     */
    function getTokenAddr(string token) constant returns (address) {
        address addr = tokenAddrs[token.toUpperCase()];
        if (addr == 0) throw;
        return addr;
    }
    
    /**
     * add new token and it's contract address
     */
    function setTokenAddr(string _token, address _addr) onlyOwner returns (bool) {
        tokenAddrs[_token.toUpperCase()] = _addr;
        return true;
    }
    
    /**
     * test the fund collection is enabled or not
     */
    function isCollectEnabled() constant returns (bool) {
        return collectEnabled;
    }
    
    /**
     * enable or disable the fund collection
     */
    function setCollectEnabled(bool _enabled) onlyOwner returns (bool) {
        collectEnabled = _enabled;
        return true;
    }
}
