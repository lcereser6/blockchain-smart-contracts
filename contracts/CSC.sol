// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;


interface BankSCinterface {
    function requirementsRequest(uint8 typeOfLoan) external;
    function receiveKeys(bytes memory param, bytes memory pk, bytes memory party) external;
}

interface AddressAuthInterface {
    function addressRequest(string[] memory) external;
}

interface DHInterface {
    function receiveKeys(bytes memory param, bytes memory pk, uint256 holders) external;
}

interface UserInterface {
    function receiveKeys(bytes memory param, bytes memory pk, bytes memory party) external;
}


contract CSC {
    address public bankAddress;
    address public owner;
    address public addressAuthAddress;
    address public userAddress;
    address public dh1Address;
    address public dh2Address;
    address public dh3Address;
    address public pick;

    event generateHMMKeysEvent(string[] addressList);

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function changeBankAddress(address _bankAddress) public onlyOwner {
        bankAddress = _bankAddress;
    }

    function changeAddressAuthAddress(address _addressAuthAddress) public onlyOwner {
        addressAuthAddress = _addressAuthAddress;
    }

    function changeUserAddress(address _userAddress) public onlyOwner {
        userAddress = _userAddress;
    }

    function changeDH1Address(address _dh1Address) public onlyOwner {
        dh1Address = _dh1Address;
    }

    function changeDH2Address(address _dh2Address) public onlyOwner {
        dh2Address = _dh2Address;
    }

    function changeDH3Address(address _dh3Address) public onlyOwner {
        dh3Address = _dh3Address;
    }

    

function toAddress(string memory s) public  returns (address) {
        bytes memory _bytes = hexStringToAddress(s);
        require(_bytes.length >= 1 + 20, "toAddress_outOfBounds");
        address tempAddress;

        assembly {
            tempAddress := div(mload(add(add(_bytes, 0x20), 1)), 0x1000000000000000000000000)
        }

        pick = tempAddress;
    }
     function hexStringToAddress(string memory s) public pure  returns (bytes memory) {
        bytes memory ss = bytes(s);
        require(ss.length%2 == 0); // length must be even
        bytes memory r = new bytes(ss.length/2);
        for (uint i=0; i<ss.length/2; ++i) {
            r[i] = bytes1(fromHexChar(uint8(ss[2*i])) * 16 +
                        fromHexChar(uint8(ss[2*i+1])));
        }

        return r;

    }

     function fromHexChar(uint8 c) public pure returns (uint8) {
        if (bytes1(c) >= bytes1('0') && bytes1(c) <= bytes1('9')) {
            return c - uint8(bytes1('0'));
        }
        if (bytes1(c) >= bytes1('a') && bytes1(c) <= bytes1('f')) {
            return 10 + c - uint8(bytes1('a'));
        }
        if (bytes1(c) >= bytes1('A') && bytes1(c) <= bytes1('F')) {
            return 10 + c - uint8(bytes1('A'));
        }
        return 0;
    }

    function quoteRequest(uint8 typeOfLoan) public {

        BankSCinterface bank = BankSCinterface(bankAddress);
        bank.requirementsRequest(typeOfLoan);
    }

    function dhSearch(uint8 typeOfLoan, string[] memory requirements) public{

        AddressAuthInterface addressAuth = AddressAuthInterface(addressAuthAddress);
        addressAuth.addressRequest(requirements);
    }

    function addressReceiver (string[] memory addressList) public {
        generateHMMKeys(addressList);
    }

    function generateHMMKeys(string[] memory addressList) public{
        emit generateHMMKeysEvent(addressList);
    }
    
    function uploadHMMKeys(bytes memory param,bytes memory pk, bytes memory bankParty, bytes memory userParty, string[] memory addressList ) public {
        sendKeysToBank(param, pk, bankParty);
        sendKeysToUser(param, pk, userParty);
        sendKeysToDHs(param, pk, addressList);
    }
   
    function sendKeysToBank(bytes memory param, bytes memory pk, bytes memory party) public {
        BankSCinterface bank = BankSCinterface(bankAddress);
        bank.receiveKeys(param, pk, party);
    }

    function sendKeysToUser(bytes memory param, bytes memory pk, bytes memory party) public {
        UserInterface user = UserInterface(bankAddress);
        user.receiveKeys(param, pk, party);
    }

    function sendKeysToDHs(bytes memory param, bytes memory pk, string[] memory addressList) public {
        //for each address in the addressList, send the keys to the DH
        for(uint i = 0; i < addressList.length; i++){
            //convert the string address to an address type
            DHInterface dh = DHInterface(toAddress(addressList[i]));
            dh.receiveKeys(param, pk, addressList.length);
        }
    }

    function hmmComputeRequest(bytes memory data) public {
        //event to invoke computation
    }

    function hmmResultUpload(bytes memory data) public {
        //result send user

        //result send bank
    }

    
}