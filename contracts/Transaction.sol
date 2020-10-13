// SPDX-License-Identifier: Not-Licensed
pragma solidity >=0.4.22 <0.7.0;

contract Transaction{
    mapping(address => uint) private accountHolders;
    
    event FundTransferred(address to, address from, uint fund);
    event FundWithdrawed(address by, uint fund);
    event FundDeposited(address by, uint fund);
    
    // function to send the ether amount
    function sendFund(uint _fund, address _to) public{
        require(accountHolders[msg.sender] > 0 && accountHolders[msg.sender] > _fund);
        accountHolders[_to] = _fund;
        emit FundTransferred(_to, msg.sender, _fund);
    }
    
    // function to withdraw ether amount
    function withdrawFund(uint _fund) public{
        require(accountHolders[msg.sender] > 0 && accountHolders[msg.sender] > _fund);
        uint amount = accountHolders[msg.sender];
        amount -= _fund;
        accountHolders[msg.sender] = amount;
        emit FundWithdrawed(msg.sender, _fund);
    }
    
    // function to deposit ether amount
    function depositFund(uint _fund) payable public{
        uint amount = accountHolders[msg.sender];
        amount += _fund;
        accountHolders[msg.sender] = amount;
        emit FundDeposited(msg.sender, _fund);
    }
    
    // function to check the available fund
    function checkFund() public view returns (uint){
        return accountHolders[msg.sender];
    }
}