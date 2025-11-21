// we want to be able to recive money and be able to withdraw
// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;
import {PriceConverter} from "./lib.sol";

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";



error NotOwner();


contract Fundme{
  // this mean all unit256 will have access to our priceconverter libra
  // it will automatically pass it sel in only wen it accept 2 input that wen we type the other in
  using PriceConverter for uint256;



// to save gas for variable we only declear onces like: we write it in caps MINIMUM_USD we add constant to it
// while for variable  that we only chainge after the contract is deployed we use immutable;


uint256  public constant MINIMUM_USD = 5e18;

  address private immutable i_owner;

// constructer is a fn that is been called righ wen the contruct is deployed

  AggregatorV3Interface private s_pricefeed;
constructor(address _pricefeed){
 i_owner = msg.sender;
 s_pricefeed = AggregatorV3Interface(_pricefeed);
}



function getVersion()public view returns(uint256){
  return s_pricefeed.version();


}







//adderss of funders

address[] public funders;

mapping ( address => uint256) public addressToAmountFunded;




// the payable keyword tell eth that we are going to recive money 
function fundme() public payable {









  // allow users to send $
  // have menimu amount


// the msg.value let us know how much the user is sending
  //msg.value;


// the require is use to set MINIMUM_USD like how we do it below, and we added error message

//msg.value is a uint so it have asse to our priceconver lib
  require(msg.value.getConvertionRate(s_pricefeed) > MINIMUM_USD,'please increase the value');

  addressToAmountFunded[msg.sender] += msg.value;
  funders.push(msg.sender);

//revert note if the require faild any operation that was been done in the function will un do it self back

}


function withdraw()public onlyOwner{
// first we need to create a loop to recent the amount founders send back to zero


//note looping is not a good idea in solidity, it not gas efficient
for(uint256 index = 0;index < funders.length; index++){

  address founder = funders[index];
   addressToAmountFunded[founder] = 0;
}

funders = new address[](0);


// to widthdraw funds from  contract we use
//transfer  if failde it revert the tx
payable(msg.sender).transfer(address(this).balance);

//send // if faild it dont revert the tx we have to specify it, it return bool we done
bool success = payable(msg.sender).send(address(this).balance);
//if it false it will triger the require
require(success,'transfer failed');


//call same with send but this on return to varable so we destructur it
(bool callsuccess,)= payable(msg.sender).call{value:address(this).balance}('');

require(callsuccess,'transfer failed');










}




// modifiers are kinda like guard we put, bufore the function runs it first check if condition are meant
modifier onlyOwner(){


// the string in dis require cost more gas cause it been stored in a string
//instead we use one of this 
// first we create our own custom error outside the function

 //instead of dis 
  require(msg.sender == i_owner,'only owner can call this');

  //we do this 
   require(msg.sender == i_owner,NotOwner());


//or this

if(msg.sender != i_owner){

  // revet to cancel the transaction like require
  revert NotOwner();
}

  
  // this line below simply means after the up one is meant run the rest code here
  _;
}


// is a fn that is been called when users try sending money to our contract address directly
// which is without using oir fund keyword we have here
receive() external payable { 

  fundme();
}

// similar to recive but this time around the user passdata still without using butn direct
fallback() external payable { 

  fundme();
}


//getter functions

function getAmountFunded(address _funder) public view returns(uint256) {

uint256 amountFunded = addressToAmountFunded[_funder];
return amountFunded;
}


function getfunder(uint256 _index) public view returns(address){
 return funders[_index];




}


function getOwner() external view returns(address){

  return i_owner;
}


}