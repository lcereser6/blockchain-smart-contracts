// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

interface CSCinterface {
    function addressReceiver(string[] memory addresses) external;
}

contract AddressAuth {
    address public owner;
    address public CSCAddress;

    event addressRequestEvent(string[]);

    
    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function changeOwner(address _owner) public onlyOwner {
        owner = _owner;
    }

    function changeCSCAddress(address _CSCAddress) public onlyOwner {
        CSCAddress = _CSCAddress;
    }

    function addressRequest(string[] memory requirements) public {
        emit addressRequestEvent(requirements);
    }

     function addressUpload(string[] memory addresses) public {
        //emit the event to be listened to by the CSC
        CSCinterface csc = CSCinterface(CSCAddress);
        csc.addressReceiver(addresses);
    }    
}