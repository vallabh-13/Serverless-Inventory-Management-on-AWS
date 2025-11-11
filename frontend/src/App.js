import React, { useEffect, useState } from "react";
import { getCoffees, postCoffee, putCoffee, deleteCoffee } from "./api";
import CoffeeForm from "./CoffeeForm";
import CoffeeList from "./CoffeeList";

function App() {
  const [coffees, setCoffees] = useState([]);
  const [selectedCoffee, setSelectedCoffee] = useState(null);

  const loadCoffees = async () => {
    try {
      const data = await getCoffees();
      setCoffees(data);
    } catch (err) {
      console.error("Error loading coffees:", err);
    }
  };

  useEffect(() => {
    loadCoffees();
  }, []);

  const handleAdd = async (coffee) => {
    await postCoffee(coffee);
    loadCoffees();
  };

  const handleUpdate = async (coffee_name, updates) => {
    await putCoffee(coffee_name, updates);
    setSelectedCoffee(null);
    loadCoffees();
  };

  const handleDelete = async (coffee_name) => {
    await deleteCoffee(coffee_name);
    loadCoffees();
  };

  return (
    <div className="app-container">
      <h1>☕ Coffee Inventory</h1>
      <CoffeeForm
        onAdd={handleAdd}
        onUpdate={handleUpdate}
        selected={selectedCoffee}
      />
      <CoffeeList
        coffees={coffees}
        onEdit={setSelectedCoffee}
        onDelete={handleDelete}
      />
    </div>
  );
}

export default App;
