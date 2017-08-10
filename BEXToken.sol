pragma solidity ^0.4.11;

// The ERC20 Token Standard Interface
contract ERC20 {
    function totalSupply() constant returns (uint totalSupply);
    function balanceOf(address _owner) constant returns (uint balance);
    function transfer(address _to, uint _value) returns (bool success);
    function transferFrom(address _from, address _to, uint _value) returns (bool success);
    function approve(address _spender, uint _value) returns (bool success);
    function allowance(address _owner, address _spender) constant returns (uint remaining);
    event Transfer(address indexed _from, address indexed _to, uint _value);
    event Approval(address indexed _owner, address indexed _spender, uint _value);
}

// The BEX Token Standard Interface
contract BEXInterface {

    // burn some BEX token from sender's account to a specific address which nobody can spent
    // this function only called by contract's owner
    function burn(uint _value) returns (bool success);
    
    // the event of 'burn' function has called successfully
    event Burn(address indexed _from, address indexed _to, uint _value);
}

// BEX modifier
contract MyOwner {
    address owner;
    
    function MyOwner() {
        owner = msg.sender;
    }
    
    modifier OnlyBEXOwner() {
        require(msg.sender == owner);
        _;
    }
}

// BEX Token implemention
contract BEXToken is ERC20, BEXInterface, MyOwner {
    string public constant name = "BEX";
    string public constant symbol = "BEX";
    uint8 public constant decimals = 18;
    uint256 _totalSupply = 200000000000000000000000000;
    mapping(address => uint256) balances;
    mapping(address => mapping (address => uint256)) allowed;
    address burnToAddr = 0x0000000000000000000000000000000000000000;
    
    function BEXToken() {
        balances[owner] = _totalSupply;
    }
    
    function totalSupply() constant returns (uint totalSupply) {
        totalSupply = _totalSupply;
    }
    
    function balanceOf(address _owner) constant returns (uint balance) {
        return balances[_owner];
    }
    
    function transfer(address _to, uint _value) returns (bool success) {
        if (balances[msg.sender] >= _value && _value > 0 && balances[_to] + _value > balances[_to]) {
            balances[msg.sender] -= _value;
            balances[_to] += _value;
            Transfer(msg.sender, _to, _value);
            return true;
        } else {
            return false;
        }
    }
    
    function transferFrom(address _from, address _to, uint _value) returns (bool success) {
        if (balances[_from] >= _value && _value > 0 && allowed[_from][msg.sender] >= _value
            && balances[_to] + _value > balances[_to]) {
            balances[_from] -= _value;
            allowed[_from][msg.sender] -= _value;
            balances[_to] += _value;
            Transfer(_from, _to, _value);
            return true;
        } else {
            return false;
        }
    }
    
    function approve(address _spender, uint _value) returns (bool success) {
        if (_value >= 0) {
            allowed[msg.sender][_spender] = _value;
            Approval(msg.sender, _spender, _value);
            return true;
        } else {
            return false;
        }
    }
    
    function allowance(address _owner, address _spender) constant returns (uint remaining) {
        return allowed[_owner][_spender];
    }
    
    function burn(uint _value) OnlyBEXOwner returns (bool success) {
        if (balances[msg.sender] >= _value && _value > 0) {
            balances[msg.sender] -= _value;
            balances[burnToAddr] += _value;
            Burn(msg.sender, burnToAddr, _value);
            return true;
        } else {
            return false;
        }
    }
}
