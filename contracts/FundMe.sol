
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./PriceConverter.sol";

error FundMe__NotOwner();

contract FundMe{

    using PriceConverter for uint256;

    uint256 public constant minimumUsd = 50 * 1e18;
    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;

    address public immutable i_owner;

    AggregatorV3Interface public priceFeed;

    constructor(address priecFeedAddress){
        i_owner = msg.sender;
        priceFeed = AggregatorV3Interface(priecFeedAddress);
    }

    modifier onlyOwner{
        //require(msg.sender == i_owner,"Sender is not the owner");
        if(msg.sender != i_owner){
            revert FundMe__NotOwner();
        }
        _;
    }

    function fund() public payable{
        require(msg.value.getConversionRate(priceFeed) >= minimumUsd,"Didn't sent enough!");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = msg.value;
    }
    
    function withdraw() public onlyOwner {
        for(uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++){
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        funders = new address[](0);

        (bool callSuccess,) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess);
    }
    function cheaperWithdraw() public onlyOwner{
        address[] memory m_funders = funders;
        for (uint256 funderIndex = 0; funderIndex < m_funders.length; funderIndex++){
            address _funder = m_funders[funderIndex];
            addressToAmountFunded[_funder] = 0;
        }
        funders = new address[](0);
        (bool callSuccess,) = i_owner.call{value: address(this).balance}("");
        require(callSuccess);
    }

    receive() external payable{
        fund();
    }
    fallback() external payable{
        fund();
    }

}