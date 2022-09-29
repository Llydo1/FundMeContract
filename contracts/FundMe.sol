//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
import "./PriceConverter.sol";
 
contract FundMe{
    using PriceConverter for uint256;
    
    uint256 public constant MINIMUM_USD=50* 1e18;

    address[] public funders;
    mapping(address => uint256) public addressToamountFunded;
    address public immutable i_owner;
    constructor(){
        i_owner=msg.sender;
    }



    function fund() public payable{
        require((msg.value).getConversionRate( ) > MINIMUM_USD, "Did not send enough");
        funders.push(msg.sender);
        addressToamountFunded[msg.sender] += msg.value;
    }

    function withdraw() public onlyOwner{
        for(uint8 i = 0; i< funders.length; i++){
            addressToamountFunded[funders[i]] = 0;
        }
        funders = new address[](0);
        (bool callSuccess,) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "There was an error");
  }

    modifier onlyOwner{
        require(msg.sender == i_owner, "Sender is not owner");
        _;
    }

}