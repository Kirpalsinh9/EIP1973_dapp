pragma solidity ^0.5.0;


import "./Rewards.sol";

contract Sponsors
{
    
     struct sponsor {
        bool issponsor;
        uint256 sponsorship;
        
    }
    
    address public owner;
    mapping(address => sponsor) public sponsorsDB;
    uint256 public totalsponsors;
    Rewards public rewardsContract;
    address public sponsorshipaddress = address(this);
    
    constructor(address _rewardsContract) public payable {
        rewardsContract=Rewards(_rewardsContract);
        totalsponsors=0;
        owner = tx.origin;
        if(!rewardsContract.isMinter(sponsorshipaddress)) {
            rewardsContract.addMinters(sponsorshipaddress);
            
        }
    }
    
    modifier isAuthorized() {
        require(sponsorsDB[tx.origin].issponsor, "Caller is not authorized");
        _; 
    }
    
    modifier OnlyOwner() {
        require(tx.origin==owner, "Caller is not authorized");
        _; 
    }
    function addSponsor(address _sponsor) public {
        require(!sponsorsDB[tx.origin].issponsor, "It's already added");
        require(totalsponsors<=1,"New Sponsors can't be added");             
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
    
    function triggertokens()   public OnlyOwner payable {
       rewardsContract.trigger();
    }
    
    function withdraw() public isAuthorized payable {
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
    function withdrawfrom2() public payable {
        database.withdraw();
    }
    
}

contract Factory{
    uint public Id;
    
    mapping(uint => Sponsor2) SponsorList;
    address  public sponsors;
    uint256 goal;
    
   
    
    function deploy(address _sponsors,uint256 _goal) public {
        Id++;
        goal=_goal;
        sponsors=_sponsors;
       
      Sponsor2 f = new Sponsor2(sponsors,goal);
        SponsorList[Id] = f;
       
    }
    
    function getfactoryById(uint _id) public view returns (Sponsor2) {
      return SponsorList[_id];
    }
    
}

contract Dashboard{
     uint public SponsorshipId;
    Factory public database;
   
      
      constructor(address _database) public {
        database = Factory(_database);
    }
    
    function newFactory(address _mainsp,uint256 _goal) public  {
        
        SponsorshipId++;
        
        database.deploy(_mainsp,_goal);
    }
    
    function getid()public view returns(uint)
    {
        return SponsorshipId;
    }
    
    function addSponsorbyId(uint _id,address sponsor) public  {
        Sponsor2  f=Sponsor2(database.getfactoryById(_id));
        f.addMintersfrom2(sponsor);
    }
    function removeSponsorbyId(uint _id,address sponsor) public  {
        Sponsor2  f=Sponsor2(database.getfactoryById(_id));
        f.removeMintersfrom2(sponsor);
    }
    function sponsoringbyID(uint _id) public payable {
        Sponsor2  f=Sponsor2(database.getfactoryById(_id));
        f.sponsoringfrom2.value(msg.value)();
    }
    
    function minttokensbyID(uint _id) public payable{
        Sponsor2  f=Sponsor2(database.getfactoryById(_id));
        f.triggerfrom2();
    }
    function withdrawfromdashboard(uint _id) public payable{
        Sponsor2  f=Sponsor2(database.getfactoryById(_id));
        f.withdrawfrom2();
    }
}