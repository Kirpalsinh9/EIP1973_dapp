pragma solidity ^0.5.0;


import "./Rewards.sol";

contract Sponsors
{
    
     struct sponsor {
        bool issponsor;
        uint256 sponsorship;
        
    }
    
    address public sponsorshipContractAddress=address(this);
    
    mapping(address => sponsor) public sponsorsDB;
    Rewards public rewardsContract;
    
    constructor(address _rewardsContract) public {
        rewardsContract=Rewards(_rewardsContract);
        if(!rewardsContract.isMinter(sponsorshipContractAddress)) {
            rewardsContract.addMinters(sponsorshipContractAddress);
        }
       
       
       sponsorshipContractAddress = address(this);
       
    }
    
    modifier isAuthorized() {
        require(sponsorsDB[tx.origin].issponsor, "caller is not a authorized Sponsor");
        _; 
    }
    function addSponsor(address _sponsor) public {
        require(!sponsorsDB[tx.origin].issponsor, "It's already added");
        sponsorsDB[_sponsor].issponsor = true;
        
    }
    
    function removeSponsor(address _sponsor) public {
        require(sponsorsDB[_sponsor].issponsor, "It's already removed");
        sponsorsDB[_sponsor].issponsor = false;
    }
    
    function sponsoring() public isAuthorized payable {
        sponsorsDB[tx.origin].sponsorship += msg.value;
    }
    
    function triggertokens() public payable {
       rewardsContract.trigger();
    }
    
    function withdraw() public payable {
        rewardsContract.withdraw();
    }
}