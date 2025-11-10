const BASE_URL = process.env.REACT_APP_API_URL;

export async function getCoffees() {
  const response = await fetch(`${BASE_URL}/coffee`);
  if (!response.ok) throw new Error("Failed to fetch coffee list");
  return await response.json();
}

export async function postCoffee(coffee) {
  const response = await fetch(`${BASE_URL}/coffee`, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify(coffee),
  });
  if (!response.ok) throw new Error("Failed to add coffee");
  return await response.json();
}

export async function putCoffee(coffee_name, updates) {
  const response = await fetch(`${BASE_URL}/coffee/${coffee_name}`, {
    method: "PUT",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify(updates),
  });
  if (!response.ok) throw new Error("Failed to update coffee");
  return await response.json();
}

export async function deleteCoffee(coffee_name) {
  const response = await fetch(`${BASE_URL}/coffee/${coffee_name}`, {
    method: "DELETE",
  });
  if (!response.ok) throw new Error("Failed to delete coffee");
  return await response.json();
}
