import React from 'react';
import AddEvent from './Sponsoring'
import AddSponsor from './AddSponsor'
import './App.css';

function App() {
  return (
    <div className="App">
      <h4>Create your contract here</h4>
      <AddEvent />
      <h4>AddContributor</h4>
      <AddSponsor />

    </div>
  );
}

export default App;
