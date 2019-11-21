import React from 'react';
import AddEvent from './Components/AddEvent'
import AddSponsor from './Components/AddSponsor'
import Event from './Components/Events'
import Mintingtokens from './Components/Mintingtokens'
import Withdrawtokens from './Components/Withdrawtokens'
import './App.css';

function App() {
  return (
    <div className="App">
      <h4>Deploy New Event</h4>
      <AddEvent />
      <h4>Manage Sponsors</h4>
      <AddSponsor />
      <h4>Sponsoring</h4>
      <Event />
      <h4>Mint Token</h4>
      <Mintingtokens />
      <h4>Withdraw Tokens</h4>
      <Withdrawtokens />

    </div>
  );
}

export default App;
