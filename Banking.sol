// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

contract Banking
{
    struct TransactionHist
    {
        uint amount;
        uint timestamp;
    }

    struct payment
    {
        uint totalBalance;
        uint numDeposite;
        mapping(uint=>TransactionHist) deposites;
        uint numWithdraw;
        mapping(uint=>TransactionHist) withdrawes;
    }

    mapping(address=>payment) public RecievedBalance;

    // Get Deposites Details

    function getDeposite(address _from, uint _numDeposite) public view returns(TransactionHist memory)
    {
        return RecievedBalance[_from].deposites[_numDeposite];
    }

    // Get Withdrawals Details

    function getWithdraw(address _from, uint _numWithdraw) public view returns(TransactionHist memory)
    {
        return RecievedBalance[_from].withdrawes[_numWithdraw];
    }

    function DepositeMoney() payable public
    {
        RecievedBalance[msg.sender].totalBalance+= msg.value; //increase the balance by the amount of deposite
        //record a new deposite
        TransactionHist memory deposite = TransactionHist(msg.value,block.timestamp);
        RecievedBalance[msg.sender].deposites[RecievedBalance[msg.sender].numDeposite] = deposite;
        RecievedBalance[msg.sender].numDeposite++;
    }

    function WithdrawMoney(address payable _to, uint _amount) payable public
    {
        RecievedBalance[msg.sender].totalBalance-=_amount; //reduce the balance by the amount of withdraw
        //record a new withdrawal
        TransactionHist memory Withdraw  = TransactionHist(_amount, block.timestamp);
        RecievedBalance[msg.sender].withdrawes[RecievedBalance[msg.sender].numWithdraw] = Withdraw;
        RecievedBalance[msg.sender].numWithdraw++;
        _to.transfer(_amount);
    }
}
