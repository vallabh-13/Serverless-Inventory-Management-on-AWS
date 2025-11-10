import React, { useState, useEffect } from "react";

function CoffeeForm({ onAdd, onUpdate, selected }) {
  const [coffee_name, setCoffeeName] = useState("");
  const [price, setPrice] = useState("");
  const [availability, setAvailability] = useState("");

  useEffect(() => {
    if (selected) {
      setCoffeeName(selected.coffee_name);
      setPrice(selected.price || "");
      setAvailability(selected.availability || "");
    } else {
      setCoffeeName("");
      setPrice("");
      setAvailability("");
    }
  }, [selected]);

  const handleSubmit = (e) => {
    e.preventDefault();
    const coffee = { coffee_name, price, availability };
    selected ? onUpdate(coffee_name, coffee) : onAdd(coffee);
  };

  return (
    <form onSubmit={handleSubmit} style={{ marginBottom: "2rem" }}>
      <input
        type="text"
        placeholder="Coffee Name"
        value={coffee_name}
        onChange={(e) => setCoffeeName(e.target.value)}
        required
      />
      <input
        type="number"
        placeholder="Price"
        value={price}
        onChange={(e) => setPrice(e.target.value)}
        step="0.01"
      />
      <input
        type="text"
        placeholder="Availability"
        value={availability}
        onChange={(e) => setAvailability(e.target.value)}
      />
      <button type="submit">{selected ? "Update" : "Add"} Coffee</button>
    </form>
  );
}

export default CoffeeForm;
