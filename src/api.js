import axios from 'axios';

const API_URL = process.env.REACT_APP_API_URL;

export const getCoffees = () => axios.get(API_URL);
export const addCoffee = (data) => axios.post(API_URL, data);
export const updateCoffee = (id, data) => axios.put(`${API_URL}/${id}`, data);
export const deleteCoffee = (id) => axios.delete(`${API_URL}/${id}`);