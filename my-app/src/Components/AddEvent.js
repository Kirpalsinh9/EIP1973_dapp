import React from "react"
//import firebase from './Firestore'
import { ethers } from 'ethers';
import Loader from 'react-loader-spinner'
const abi = require('../abi')

class AddEvent extends React.Component {
    constructor() {
        super()
        this.state = {

            Goal: "",
            Id: "",
            loading: false


        }
        this.handlechange = this.handlechange.bind(this)
        this.handlesubmit = this.handlesubmit.bind(this)
        this.handlesubmit1 = this.handlesubmit1.bind(this)
    }
    handlechange = (e) => {
        this.setState({
            [e.target.name]: e.target.value
        })
    }
    handlesubmit = async (e) => {
        e.preventDefault();
        this.setState({
            loading: true
        })
        let eth = window.ethereum;
        let add = await eth.enable()
        let provider = new ethers.providers.Web3Provider(window.web3.currentProvider);
        const signer = provider.getSigner();
        console.log(add.toString());
        let address = '0x7aca5a76324dbe1dfb0276b6960b5f79f21cc193'
        let contract = new ethers.Contract(address, abi, signer);
        const addressofSponsors = '0x5b185fab47aef587f06975b2f38335eee43c2b7b'
        await contract.newFactory(addressofSponsors, this.state.Goal);
        // const db = firebase.firestore();
        // db.collection("Events").add({  
        //     Goal: this.state.Goal
        // }) 
        this.setState({
            Goal: "",
            loading: false
        })

    }
    handlesubmit1 = async (e) => {
        e.preventDefault();
        let eth = window.ethereum;
        let add = await eth.enable()
        let provider = new ethers.providers.Web3Provider(window.web3.currentProvider);
        const signer = provider.getSigner();
        console.log(add.toString());
        let address = '0x7aca5a76324dbe1dfb0276b6960b5f79f21cc193'
        let contract = new ethers.Contract(address, abi, signer);
        //const addressofSponsors = '0x5b185fab47aef587f06975b2f38335eee43c2b7b'
        let newid = await contract.getid();

        this.setState({
            Id: newid.toString()
        })

    }

    render() {
        const loading = this.state.loading
        return (
            <div>
                <form onSubmit={this.handlesubmit}>

                    <input type="text" name="Goal" label="Goal" onChange={this.handlechange} value={this.state.Goal} placeholder="Enter Amount (ex. ETH)" />
                    <button type="submit" disabled={loading}>
                        {this.state.loading === true ? <Loader
                            type="Puff"
                            color="white"
                            height="30"
                            width="30"
                        /> : ""}
                        Submit</button>


                </form>
                <button onClick={this.handlesubmit1}> Get Your New  Event Id!!</button>
                {this.state.Id !== "" ? <p>New Event Id:{this.state.Id}</p> : ""}
            </div>
        )
    }

}

export default AddEvent