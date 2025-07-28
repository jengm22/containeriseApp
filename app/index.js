// /app/index.js
const express = require('express');
const app = express();

// The port the app will run on. Azure App Service sets the PORT environment variable.
// We fall back to 3000 for local development.
const PORT = process.env.PORT || 3000;

// Health check endpoint
app.get('/health', (req, res) => {
  res.status(200).json({ status: 'ok' });
});

// Root endpoint
app.get('/', (req, res) => {
  res.send('Hello, World! Your containerized app is running on Azure.');
});

app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});