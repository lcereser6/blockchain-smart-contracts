// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

interface CSCinterface {
    //TODO: change the return type to a struct
    function hmmComputeRequest(bytes memory data) external;
}
contract DH2 {
    uint8 public a;
    address public CSCAddress;
    address public owner;
    event receiveKeysEvent(bytes param, bytes pk);


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

    function receiveKeys(bytes memory param, bytes memory pk) public {
        emit receiveKeysEvent(param, pk);
        
    }

    function uploadData(bytes memory data) public {
        CSCinterface csc = CSCinterface(CSCAddress);
        csc.hmmComputeRequest(data);
        
    }
}