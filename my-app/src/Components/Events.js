import React, { Component } from 'react'
//import firebase from '../Firestore'
import { ethers } from 'ethers';
import Loader from 'react-loader-spinner';
const abi = require('../abi');

export default class Events extends Component {
    constructor() {
        super()
        this.state = {
            Id: "",
            Amount: "",
            loading: false,
            Error: "",
            Message: ""
        }
        this.handlechange = this.handlechange.bind(this)
        this.handlesubmit = this.handlesubmit.bind(this)
        //this.handlesubmit1 = this.handlesubmit1.bind(this)
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
        console.log(this.state.Id)
        console.log(this.state.Amount)
        //e.preventDefault();
        let eth = window.ethereum;
        let add = await eth.enable()
        let provider = new ethers.providers.Web3Provider(window.web3.currentProvider);
        const signer = provider.getSigner();
        console.log(add.toString());
        let address = '0x7aca5a76324dbe1dfb0276b6960b5f79f21cc193'
        let contract = new ethers.Contract(address, abi, signer);
        try {
            await contract.sponsoringbyID(this.state.Id, { value: ethers.utils.parseEther(this.state.Amount) });

            this.setState({
                Amount: "",
                Id: "",
                Error: "",
                Message: "We've got your sponsorship.Thanks!!",
                loading: false
            })
        } catch (error) {
            console.log(error.message);
            this.setState({
                Error: "You are not authorized or we've got enough sponsorship for this event.",
                Message: ""
            })
        }
    }

    render() {
        const loading = this.state.loading
        return (
            <div>
                <form onSubmit={this.handlesubmit}>
                    <input type="text" name="Id" label="Id" onChange={this.handlechange} value={this.state.Id} placeholder="Enter Event Id" />
                    <br />
                    <input type="text" name="Amount" label="Amount" onChange={this.handlechange} value={this.state.Amount} placeholder="Enter Amount (ex. ETH)" />
                    <button type="submit" disabled={loading}>
                        {this.state.loading === true ? <Loader
                            type="Puff"
                            color="white"
                            height="30"
                            width="30"
                        /> : ""}Submit</button>
                </form>
                {this.state.Message !== "" ? <p>{this.state.Message}</p> : ""}
                {this.state.Error !== "" ? <p>{this.state.Error}</p> : ""}

            </div>
        )
    }
}
