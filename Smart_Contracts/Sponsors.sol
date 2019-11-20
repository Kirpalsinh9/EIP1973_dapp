pragma solidity ^0.5.0;


import "./Rewards.sol";

//the main contract that adds and removes sponsors from dapp and keeps track of 
//sponsors for example how many sponsors we have got and how much has been sponsored by particular sponsor. 
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
    
   //takes address of reward contract and checks whether the address of this contract is minter or not 
   //if not then adds it in  minter{added this as I was getting issues in minting tokens}   
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
    //add minters as sponsors[participants] 
    function addSponsor(address _sponsor) public {
        require(!sponsorsDB[tx.origin].issponsor, "It's already added");
        require(totalsponsors<=1,"New Sponsors can't be added");             
       rewardsContract.addMinters(_sponsor);
       totalsponsors++;
        sponsorsDB[_sponsor].issponsor = true;
        
    }
    
    //remove sponsor
    function removeSponsor(address _sponsor) public {
        require(sponsorsDB[_sponsor].issponsor, "It's already removed");
        rewardsContract.removeMinters(_sponsor);
        totalsponsors--;
        sponsorsDB[_sponsor].issponsor = false;
    }
    
    //get the ethers from sponsors for sponsoring an event and saves that amount with the address of that account
    function sponsoring(uint256 _amt) public isAuthorized payable {
        sponsorsDB[tx.origin].sponsorship += _amt;
    }
    
    //to mint tokens and bring it to system which is only executed by owner
    function triggertokens()   public OnlyOwner payable {
       rewardsContract.trigger();
    }
    
    //to withdraw tokens
    function withdraw() public isAuthorized payable {
        rewardsContract.withdraw();
    }
}

//the secondary contract that is deployed for a particular event to get sponsorship
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
    //to get sponsorship and checks totalsponsorship doesn't excceed the amount of initialgoal
    function sponsoringfrom2() public payable{
        require(totalsponsorship<initialgoal,"Sponsorship is over.");
        amt = msg.value/(1 ether) ;
        totalsponsorship += amt;
        database.sponsoring(amt);
    }
    //to mint tokens after the event
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