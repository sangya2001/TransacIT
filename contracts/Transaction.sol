// SPDX-License-Identifier: Not-Licensed
pragma solidity >=0.4.22 <0.7.0;

contract Transactions{
    mapping(address => uint) private accountHolders;
    
    event FundTransferred(address to, address from, uint fund);
    event FundWithdrawed(address by, uint fund);
    event FundDeposited(address by, uint fund);
    
    modifier notEmpty(){
        require(accountHolders[msg.sender] > 0);
        _;
    }
    
    // function to send the ether amount
    function sendFund(uint _fund, address _to) public notEmpty{
        require(accountHolders[msg.sender] >= _fund);
        accountHolders[msg.sender] -=_fund;
        accountHolders[_to]+=_fund;
        emit FundTransferred(_to, msg.sender, _fund);
    }
    
    // function to withdraw ether amount
    function withdrawFund(uint _fund) public notEmpty{
        require(accountHolders[msg.sender] >= _fund);
        accountHolders[msg.sender] -= _fund;
        emit FundWithdrawed(msg.sender, _fund);
    }
    
    // function to deposit ether amount
    function depositFund(uint _fund) payable public{
        accountHolders[msg.sender] += _fund;
        emit FundDeposited(msg.sender, _fund);
    }
    
    // function to check the available fund
    function checkFund() public view returns (uint){
        return accountHolders[msg.sender];
    }
}
