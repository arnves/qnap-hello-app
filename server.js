const express = require('express');
const app = express();
const port = 3000; // The port inside the container

app.get('/', (req, res) => {
  const appVersion = process.env.APP_VERSION || "1.0.1";
  res.send(`Hello again from QNAP! Version: ${appVersion} - Deployed at: ${new Date().toISOString()}`);
});

app.listen(port, () => {
  console.log(`qnap-hello-app listening on port ${port}`);
});