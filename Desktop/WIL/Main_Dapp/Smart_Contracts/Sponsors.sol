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
    
    constructor(address _rewardsContract) public payable {
        rewardsContract=Rewards(_rewardsContract);
        // if(!rewardsContract.isMinter(sponsorshipContractAddress)) {
        //     rewardsContract.addMinters(sponsorshipContractAddress);
        // }
       
       
       sponsorshipContractAddress = address(this);
       
    }
    
    modifier isAuthorized() {
        require(sponsorsDB[tx.origin].issponsor, "caller is not a authorized Sponsor");
        _; 
    }
    function addSponsor(address _sponsor) public {
        require(!sponsorsDB[tx.origin].issponsor, "It's already added");
        rewardsContract.addMinters(_sponsor);
        sponsorsDB[_sponsor].issponsor = true;
        
    }
    
    function removeSponsor(address _sponsor) public {
        require(sponsorsDB[_sponsor].issponsor, "It's already removed");
        rewardsContract.removeMinters(_sponsor);
        sponsorsDB[_sponsor].issponsor = false;
    }
    
    function sponsoring(uint256 _amt) public isAuthorized payable {
        sponsorsDB[tx.origin].sponsorship += _amt;
    }
    
    function triggertokens() public payable {
       rewardsContract.trigger() ;
    }
    
    function withdraw() public payable {
        rewardsContract.withdraw();
    }
}

contract Sponsor2 {
    Sponsors database;
    uint256  public initialgoal;
    uint256 public totalsponsorship;
    uint256 amt;
    constructor(address _database, uint256 _initialgoal) public {
        database = Sponsors(_database);
        initialgoal = _initialgoal ;
        totalsponsorship = 0;
    }
    
    function addMintersfrom2(address _mins) public{
        database.addSponsor(_mins);
    }
    
    function removeMintersfrom2(address _mins) public{
        database.removeSponsor(_mins);
    }
    
    function sponsoringfrom2() public payable{
        require(totalsponsorship<=initialgoal,"Sponsorship is done.");
        amt = msg.value ;
        totalsponsorship += amt;
        database.sponsoring(amt);
    }
    
}