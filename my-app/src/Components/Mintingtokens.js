import React, { Component } from 'react'

export default class Mintingtokens extends Component {
    constructor() {
        super()
        this.state = {
            Id: "",



            // loading1: false,
            // loading2:false,

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
        console.log(this.state.Id)

        this.setState({

            Id: ""
        })
    }
    render() {
        return (
            <div>
                <form onSubmit={this.handlesubmit}>
                    <input type="text" name="Id" label="Id" onChange={this.handlechange} value={this.state.Id} placeholder="Enter Event Id" />
                    <br />

                    <button type="submit" >Submit</button>
                </form>
            </div>

        )
    }

}
