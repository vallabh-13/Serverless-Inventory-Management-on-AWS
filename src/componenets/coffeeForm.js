import React, { useState } from 'react';

const CoffeeForm = ({ onSubmit }) => {
  const [name, setName] = useState('');
  const [roast, setRoast] = useState('');

  const handleSubmit = (e) => {
    e.preventDefault();
    onSubmit({ name, roast });
    setName('');
    setRoast('');
  };

  return (
    <form onSubmit={handleSubmit}>
      <input
        type="text"
        placeholder="Coffee Name"
        value={name}
        onChange={(e) => setName(e.target.value)}
        required
      />
      <input
        type="text"
        placeholder="Roast Type"
        value={roast}
        onChange={(e) => setRoast(e.target.value)}
        required
      />
      <button type="submit">Add Coffee</button>
    </form>
  );
};

export default CoffeeForm;