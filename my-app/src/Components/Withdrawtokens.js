import React, { Component } from 'react'
import { ethers } from 'ethers'
import Loader from 'react-loader-spinner';
const abi = require('../abi')

export default class Withdrawtokens extends Component {
    constructor() {
        super()
        this.state = {
            Id: "",



            loading: false,


        }
        this.handlechange = this.handlechange.bind(this)
        this.handlesubmit = this.handlesubmit.bind(this)

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
        let eth = window.ethereum;
        let add = await eth.enable()
        let provider = new ethers.providers.Web3Provider(window.web3.currentProvider);
        const signer = provider.getSigner();
        console.log(add.toString());
        let address = '0x7aca5a76324dbe1dfb0276b6960b5f79f21cc193'
        let contract = new ethers.Contract(address, abi, signer);
        await contract.withdrawfromdashboard(this.state.Id);


        this.setState({

            Id: "",
            loading: false
        })
    }

    render() {
        const loading = this.state.loading
        return (
            <div>
                <form onSubmit={this.handlesubmit}>
                    <input type="text" name="Id" label="Id" onChange={this.handlechange} value={this.state.Id} placeholder="Enter Event Id" />
                    <br />

                    <button type="submit" disabled={loading}>
                        {this.state.loading === true ? <Loader
                            type="Puff"
                            color="white"
                            height="30"
                            width="30"
                        /> : ""}Submit</button>
                </form>
            </div>
        )
    }
}
