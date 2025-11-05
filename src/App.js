import React, { useEffect, useState } from 'react';
import { getCoffees, addCoffee, deleteCoffee } from './api';
import CoffeeForm from './components/CoffeeForm';
import CoffeeList from './components/CoffeeList';

const App = () => {
  const [coffees, setCoffees] = useState([]);

  const fetchData = async () => {
    const response = await getCoffees();
    setCoffees(response.data);
  };

  useEffect(() => {
    fetchData();
  }, []);

  const handleAdd = async (coffee) => {
    await addCoffee(coffee);
    fetchData();
  };

  const handleDelete = async (id) => {
    await deleteCoffee(id);
    fetchData();
  };

  return (
    <div>
      <h1>Coffee Inventory</h1>
      <CoffeeForm onSubmit={handleAdd} />
      <CoffeeList coffees={coffees} onDelete={handleDelete} />
    </div>
  );
};

export default App;