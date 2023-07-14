const { spawn } = require('child_process');
const path = require('path');
const express = require('express');
const { createServer } = require('http');
const WebSocket = require('ws');
const fs = require('fs');

const app = express();
const server = createServer(app);
const wss = new WebSocket.Server({ server });

// Store the output from index.js
let output = '';

function start() {
  let args = [path.join(__dirname, 'index.js'), ...process.argv.slice(2)];
  console.log([process.argv[0], ...args].join('\n'));

  let p = spawn(process.argv[0], args, { stdio: ['inherit', 'pipe', 'inherit', 'ipc'] });

  // Listen for data events on the stdout stream
  p.stdout.on('data', (data) => {
    const text = data.toString();
    output += text;
    console.log(text);
    fs.appendFileSync('public/console.log', text); // Write to the console.log file
    // Send the output to the connected WebSocket clients
    wss.clients.forEach((client) => {
      client.send(text);
    });
  });

  p.on('message', (data) => {
    if (data === 'reset') {
      console.log('Restarting Bot...');
      p.kill();
      start();
      delete p;
    }
  });

  p.on('exit', (code) => {
    console.error('Exited with code:', code);
    if (code === '.' || code === 1 || code === 0 || code === null) {
      start();
    }
  });
}

// Start the WebSocket server
wss.on('connection', (ws) => {
  console.log('WebSocket client connected');

  // Handle WebSocket connection
  ws.on('message', (message) => {
    console.log('Received message:', message);
    // Handle client messages if needed
  });

  // Handle WebSocket disconnection
  ws.on('close', () => {
    console.log('WebSocket client disconnected');
  });
});

// Serve the index.html file
app.use(express.static(path.join(__dirname, 'public')));

// Start the server
const PORT = 5000;
const serverInstance = server.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});

// Start the bot
start();

// Handle server shutdown or Ctrl+C
process.on('SIGINT', () => {
  console.log('Stopping server...');
  serverInstance.close(() => {
    console.log('Server stopped.');
    // Clear the console.log file
    fs.writeFileSync('public/console.log', '');
    process.exit(0);
  });
});
