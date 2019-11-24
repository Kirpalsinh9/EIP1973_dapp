import React, { Component } from 'react'
import firebase from '../Firestore'

export default class Events extends Component {
    constructor() {
        super()
        this.state = {
            Id: "",
            Amount: ""

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
        })
    }
    handlesubmit = async (e) => {
        e.preventDefault();
        console.log(this.state.Id)
        console.log(this.state.Amount)

        this.setState({
            Amount: "",
            Id: ""
        })
    }

    render() {
        return (
            <div>
                <form onSubmit={this.handlesubmit}>
                    <input type="text" name="Id" label="Id" onChange={this.handlechange} value={this.state.Id} placeholder="Enter Event Id" />
                    <br />
                    <input type="text" name="Amount" label="Amount" onChange={this.handlechange} value={this.state.Amount} placeholder="Enter Amount (ex. ETH)" />
                    <button type="submit" >Submit</button>
                </form>
            </div>
        )
    }
}
