pragma solidity ^0.5.0;


import "./Rewards.sol";

contract Sponsors
{
    
     struct sponsor {
        bool issponsor;
        uint256 sponsorship;
        
    }
    
    mapping(address => sponsor) public sponsorsDB;
    uint256 public totalsponsors;
    Rewards public rewardsContract;
    address public sponsorshipaddress = address(this);
    
    constructor(address _rewardsContract) public payable {
        rewardsContract=Rewards(_rewardsContract);
        totalsponsors=0;
        if(!rewardsContract.isMinter(sponsorshipaddress)) {
            rewardsContract.addMinters(sponsorshipaddress);
            
        }
    }
    
    modifier isAuthorized() {
        require(sponsorsDB[tx.origin].issponsor, "Caller is not a authorized Sponsor");
        _; 
    }
    function addSponsor(address _sponsor) public {
        require(!sponsorsDB[tx.origin].issponsor, "It's already added");
        require(totalsponsors<=2,"New Sponsors can't be added");             
       rewardsContract.addMinters(_sponsor);
       totalsponsors++;
        sponsorsDB[_sponsor].issponsor = true;
        
    }
    
    function removeSponsor(address _sponsor) public {
        require(sponsorsDB[_sponsor].issponsor, "It's already removed");
        rewardsContract.removeMinters(_sponsor);
        totalsponsors--;
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
    constructor(address _database, uint256 _initialgoal) public payable{
        database = Sponsors(_database);
        initialgoal = _initialgoal;
        totalsponsorship = 0;
    }
    
    function addMintersfrom2(address _mins) public{
        database.addSponsor(_mins);
    }
    
    function removeMintersfrom2(address _mins) public{
        database.removeSponsor(_mins);
    }
    
    function sponsoringfrom2() public payable{
        require(totalsponsorship<initialgoal,"Sponsorship is over.");
        amt = msg.value/(1 ether) ;
        totalsponsorship += amt;
        database.sponsoring(amt);
    }
    
    function triggerfrom2() public payable {
        database.triggertokens();
    }
    
}