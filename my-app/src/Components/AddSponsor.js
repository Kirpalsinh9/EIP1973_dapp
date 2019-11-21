import React from "react"
//import firebase from './Firestore'
//import { ethers } from 'ethers';
//import Loader from 'react-loader-spinner'

class AddSponsor extends React.Component {
    constructor() {
        super()
        this.state = {
            Id: "",
            Address: "",
            Address1: "",
            Id1: ""
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

        console.log(this.state.Address)
        console.log(this.state.Id)
        this.setState({
            Address: "",
            Id: ""
        })
    }
    handlesubmit1 = async (e) => {
        e.preventDefault();

        console.log(this.state.Address1)
        console.log(this.state.Id1)
        this.setState({
            Address1: "",
            Id1: ""
        })
    }
    render() {
        return (
            <div>
                <h5>Add Sponsor</h5>
                <form onSubmit={this.handlesubmit}>
                    <input type="text" name="Id" label="Id" onChange={this.handlechange} value={this.state.Id} placeholder="Enter Id" />
                    <br />
                    <input type="text" name="Address" label="Address" onChange={this.handlechange} value={this.state.Address} placeholder="Enter Address to add" />

                    <button type="submit" >Submit</button>


                </form>


                <h5>Remove Sponsor</h5>
                <form onSubmit={this.handlesubmit1}>
                    <input type="text" name="Id1" label="Id" onChange={this.handlechange} value={this.state.Id1} placeholder="Enter ID" />
                    <br />
                    <input type="text" name="Address1" label="Address" onChange={this.handlechange} value={this.state.Address1} placeholder="Enter Address to remove" />

                    <button type="submit" >Submit</button>


                </form>
            </div>
        )
    }
}
export default AddSponsor