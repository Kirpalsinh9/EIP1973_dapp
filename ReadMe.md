#`Event Sponsoring Through D-App:`
##`Business Use case:`
 This is just a Dapp to get sponsors for ABC Event Company. After every event, Sponsors will be given equal erc20 tokens that can be redeemed to get special services and discounts from ABC event company. 

 ###`Sponsor2 Contract:` 
 It can be deployed with the address of "Sponsors" contract which is the main contract for ABC company. This contract can be deployed for just one particular event. Once event has been executed, only owner can mint the tokens for sponsors and then sponsors can withdraw their tokens. The amount that is needed for an event will be given at the time of deploying this contract and once it gets that amount, it won't add more sponsors for that event. Second condition is that only 100 sponsors will be added through events by ABC company. Once a sponsor has entered in the system, they would have to sponsor something in future events to get rewards or else they can walk out from the system.  

###`Sponsors Contract:` 
It can be deployed with the address of rewards contract so that tokens can be minted and can be given to sponsors. Sponsors can withdraw their tokens from this contract.  
<br/>
<br/>
___
Contract Addresses: [Kovan Network]<br/> 

Rewards Contract: 0xcd27c55939210158666dc9df286ceba56c8c4747<br/> 
Sponsors Contract: 0x5b185fab47aef587f06975b2f38335eee43c2b7b<br/>
Factory Contract: 0xd3b86c3ba386679edaefc77433dbac7308293d29<br/>
Dashboard: 0x7aca5a76324dbe1dfb0276b6960b5f79f21cc193<br/>
___

##`Deployed`
Hosted URL:https://erc1973-c9261.firebaseapp.com [Kovan Network]<br/>

___

##`Instructions:`
In the project directory, you can run:
### `npm install`

#### `npm start`

Runs the app in the development mode.<br />
Open [http://localhost:3000](http://localhost:3000) to view it in the browser.

The page will reload if you make edits.<br />
You will also see any lint errors in the console.

>One thing to mention is that I have set the block interval as zero[0] and total participants or sponsors to 2 just to test the app but later on, those things can be changed as per requirements. 
___

## `Submitted By`
Kirpalsinh Vaghela<br/>
101158480
