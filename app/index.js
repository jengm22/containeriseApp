// /app/index.js
const express = require('express');
const app = express();

// The port the application will run on. Azure App Service sets the PORT environment variable.
// We fall back to 3000 for local development.
const PORT = process.env.PORT || 3000;

// Health check endpoint
app.get('/health', (req, res) => {
  res.status(200).json({ status: 'ok' });
});

// Root endpoint
app.get('/', (req, res) => {
  res.send('Yow Mandemm !!! Your containerized app is running on Azure. Wow this is mad');
});

app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});