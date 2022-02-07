// develop a small  etherum smart contract 
// this contract load , appove and allow transction according to address of the wallet




// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

contract Token {
       string public name;
       string public symbol = "MAV";
       uint256 public decimals = 18;
       uint256 public totalsupply = 100000000;

      mapping(address=>uint256) public balenceof;
      mapping(address=>mapping(address=>uint256)) public allowance;

    event Transfer(address indexed from , address indexed to , uint256 value);
    event Approval(address indexed owner , address indexed spend , uint256 value);
       constructor(string memory _name, string memory _symbol, uint _decimals , uint _totalsupply){
           name = _name;
           symbol = _symbol;
           decimals = _decimals;
           totalsupply = _totalsupply;
           balenceof[msg.sender] == totalsupply;
       }


    function transfer(address _to , uint256 _value ) external returns (bool success){
            require(balenceof[msg.sender] >= _value);
            _transfer(msg.sender , _to , _value);
          return true;
       }
       function _transfer(address _from , address _to , uint256 _value) internal {
         require(_to !=address(0));
         balenceof[_from] = balenceof[_from] - (_value);
         balenceof[_to] = balenceof[_to] + (_value);
         emit Transfer(_from , _to , _value);
       }
      
     function approve(address _spender , uint _value) external returns(bool){
        require(_spender != address(0));
        allowance[msg.sender][_spender] = _value;
        emit Approval(msg.sender,_spender,_value);
        return true;
     }
     function transferFrom(address _from , address _to , uint256 _value) external returns(bool){
        require(_value <= balenceof[_from]);
        require(_value <= allowance[_from][msg.sender]);     
        allowance[msg.sender][_from] = allowance[msg.sender][_from] - (_value);
       _transfer(_from,_to,_value);
        return true;
      }
}
