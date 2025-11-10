import React from "react";

function CoffeeList({ coffees, onEdit, onDelete }) {
  return (
    <table>
      <thead>
        <tr>
          <th>Name</th>
          <th>Price</th>
          <th>Availability</th>
          <th>Actions</th>
        </tr>
      </thead>
      <tbody>
        {coffees.map((coffee) => (
          <tr key={coffee.coffee_name}>
            <td>{coffee.coffee_name}</td>
            <td>{coffee.price}</td>
            <td>{coffee.availability}</td>
            <td>
              <button onClick={() => onEdit(coffee)}>Edit</button>
              <button onClick={() => onDelete(coffee.coffee_name)}>Delete</button>
            </td>
          </tr>
        ))}
      </tbody>
    </table>
  );
}

export default CoffeeList;
