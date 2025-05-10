const express = require('express')
const os = require('os');
const app = express()
const port = 8080

app.get('/', (req, res) => {
  let response = `Server IP Address: ${getIPAddress()}\n`;
  response += `Server Name (hostname): ${os.hostname()}\n`;
  response += `Application Version: ${process.env.VERSION}\n`;
  res.send(response);
})

function getIPAddress() {
  const interfaces = os.networkInterfaces();
  for (const dev in interfaces) {
    const iface = interfaces[dev].filter(details => details.family === 'IPv4' && !details.internal);
    if (iface.length > 0) return iface[0].address;
  }
  return '0.0.0.0';
}

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`)
})
