// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

interface CSCinterface {
    //TODO: change the return type to a struct
    function dhSearch(uint8 typeOfLoan, string[] memory requirements) external;
}


contract BankSC {

    event getRequirementsEvent(uint8 typeOfLoan);
    uint8 public typeOfLoan;
    address public CSCAddress;
    address public owner;


    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function changeCSCAddress(address _CSCAddress) public onlyOwner {
        CSCAddress = _CSCAddress;
    }


    function requirementsRequest(uint8 _typeOfLoan) public returns (string memory){
        emit getRequirementsEvent(_typeOfLoan);
        typeOfLoan = _typeOfLoan;
        return "test";
    }

    //write the function to get called from offvchain to upload the requirements array of strings
    function uploadRequirements(uint8 _typeOfLoan, string[] memory requirements) public {
        //emit the event to be listened to by the CSC
        CSCinterface csc = CSCinterface(CSCAddress);
        csc.dhSearch( _typeOfLoan, requirements);
    }

  
}