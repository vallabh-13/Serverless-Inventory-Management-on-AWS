import React from 'react';

const CoffeeList = ({ coffees, onDelete }) => {
  return (
    <ul>
      {coffees.map((coffee) => (
        <li key={coffee.coffee_id}>
          {coffee.name} ({coffee.roast})
          <button onClick={() => onDelete(coffee.coffee_id)}>Delete</button>
        </li>
      ))}
    </ul>
  );
};

export default CoffeeList;