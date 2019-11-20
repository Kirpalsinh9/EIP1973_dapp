import React from "react"
//import firebase from './Firestore'
import { ethers } from 'ethers';
import Loader from 'react-loader-spinner'



class AddEvent extends React.Component {
    constructor() {
        super()
        this.state = {

            Goal: ""

            // loading1: false,
            // loading2:false,

        }
        this.handlechange = this.handlechange.bind(this)
        this.handlesubmit = this.handlesubmit.bind(this)
        //this.handlesubmit1 = this.handlesubmit1.bind(this)
    }
    handlechange = (e) => {
        this.setState({
            [e.target.name]: e.target.value
        }, console.log(this.state))
    }
    handlesubmit = async (e) => {
        e.preventDefault();
        let ethereum = window.ethereum;
        let addr = await ethereum.enable()
        let provider = new ethers.providers.Web3Provider(window.web3.currentProvider);
        const signer = provider.getSigner();
        let abi = []

        let address = "0xc5352569c97a485fc359444fcd6ab6c9ed25d797"

        let contract = new ethers.Contract(address, abi, signer);
        let rewards = "0x8566f909e9af442dcfb075bfc48e489dd2f43019"

        let tx1 = await contract.newFactory(this.state.Goal, rewards)

        let Id = await contract.getid()
        console.log("The id is", parseInt(Id._hex))
        Id = parseInt(Id._hex)

        //const db = firebase.firestore();

        // const userRef = db.collection("users").add({
        //     Id: Id,
        //     Name:this.state.Name,



        //   });

        this.setState({
            Goal: ""
        })




    }

    render() {
        return (
            <div>
                <form onSubmit={this.handlesubmit}>
                    <input type="text" name="Name" label="Name" onChange={this.handlechange} value={this.state.Name} placeholder="Enter Name" />
                    <input type="text" name="Goal" label="Goal" onChange={this.handlechange} value={this.state.Goal} placeholder="Enter Amount (ex. ETH)" />
                    <button type="submit" >Submit</button>


                </form>
                {/* <form onSubmit={this.handlesubmit1}>
                 <h4>Check your ID</h4>
                 <input type="text" name="Name1" onChange={this.handlechange} value={this.state.Name1} placeholder="YOUR CONTRACT NAME"/>
                 <button type="submit" >Submit</button>
                 <br/> */}
                {/*                 
                {this.state.Id !== "" ? <h3 style={{textAlign: 'center'}}>The Id is {this.state.Id}</h3> : ""}

                </form> */}
            </div>
        )
    }

}

export default AddEvent