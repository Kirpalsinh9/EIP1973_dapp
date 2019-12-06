import React from 'react';
import AddEvent from './Components/AddEvent'
import AddSponsor from './Components/AddSponsor'
import Event from './Components/Events'
import Mintingtokens from './Components/Mintingtokens'
import Withdrawtokens from './Components/Withdrawtokens'
import './App.css';

function App() {
  return (
    <div className="main">
      <h1>Sponsoring Through D-App</h1>
      <h2>Deploy New Event</h2>
      <AddEvent />
      <h2>Manage Sponsors</h2>
      <AddSponsor />
      <h2>Sponsoring</h2>
      <Event />
      <h2>Mint Token</h2>
      <Mintingtokens />
      <h2>Withdraw Tokens</h2>
      <Withdrawtokens />

    </div>
  );
}

export default App;
