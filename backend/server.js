const express = require('express');
const crypto = require('crypto');
const bodyParser = require('body-parser');

const app = express();
const port = 3000;

// Middleware
app.use(bodyParser.json());

// Dummy data
let users = [
  {
    userId: 'ba96e516-1006-4899-bd5d-2b38cd6a21d0',
    email: 'asdf@asdf.com',
    fnm: 'ASDF',
    lnm: 'James',
    msisdn: '242443401',
    countryCode: '233',
    pswdDoubleInputCheckedMD5: '6a204bd89f3c8348afd5c77c717a097a',
    uniqueGlobalIdentifier: 'asdfasdfsasdfasdfasdf'
  }
];
let wallets = [];

// Endpoint: Sign Up
app.post('/signup', (req, res) => {
  const { email, fnm, lnm, msisdn, countryCode, pswdDoubleInputCheckedMD5, uniqueGlobalIdentifier } = req.body;

  // Create a new user
  const newUser = {
    email,
    fnm,
    lnm,
    msisdn,
    countryCode,
    pswdDoubleInputCheckedMD5,
    uniqueGlobalIdentifier
  };

  // Add the user to the users array
  users.push(newUser);

  res.status(200).json({ status: '0000', nextPageIds: [2, 1], noactionT: 60000 });
});

// Endpoint: Sign In
app.post('/signin', (req, res) => {
  const { email, pswdDoubleInputCheckedMD5 } = req.body;

  // Find the user by email and password
  const user = users.find(u => u.email === email && u.pswdDoubleInputCheckedMD5 === pswdDoubleInputCheckedMD5);

  if (user) {
    res.status(200).json({ status: '0000', userId: generateSHA1(user.userId), nextPageIds: [2, 1], noactionT: 1000, });
  } else {
    res.status(401).json({ status: '401', message: 'Unauthorized' });
  }
});

// Endpoint: Logout
app.post('/logout', (req, res) => {
  const { uniqueGlobalIdentifier } = req.body;

  // Perform logout operations
  // ...

  res.status(200).json({ status: '0000', nextPageIds: [2, 1], noactionT: 2000 });
});

// Endpoint: Verify Email
app.post('/verifyemail', (req, res) => {
  const { verificationCode } = req.body;

  // Perform email verification
  // ...

  res.status(200).json({ status: '0000', nextPageIds: [2, 1], noactionT: 1000 });
});

// Endpoint: Verify MSISDN
app.post('/verifymsisdn', (req, res) => {
  // Perform MSISDN verification
  // ...

  res.status(200).json({ status: '0000', nextPageIds: [2, 1], noactionT: 1000 });
});

// Endpoint: Reset Password
app.post('/resetpassword', (req, res) => {
  // Perform password reset
  // ...

  res.status(200).json({ status: '0000', nextPageIds: [2, 1], noactionT: 1000 });
});

// Endpoint: Resend Email Verification Code
app.post('/resendemailverificationcode', (req, res) => {
  // Resend the email verification code
  // ...

  res.status(200).json({ status: '0000', nextPageIds: [2, 1], noactionT: 1000 });
});

// Endpoint: Get Wallet Information
app.post('/dashboard/getwalletinfo', (req, res) => {
  const { userId } = req.body;

  // Find the wallet associated with the user ID
  const wallet = wallets.find(w => w.userId === userId);

  if (wallet) {
    res.status(200).json({ status: '0000', userId, wallet, nextPageIds: [2, 1], noactionT: 1000 });
  } else {
    res.status(401).json({ status: '401', message: 'Unauthorized' });
  }
});

// Endpoint: Wallet Credit
app.post('/tx/walletcredit', (req, res) => {
  // Perform wallet credit transaction
  // ...

  res.status(200).json({ status: '0000', nextPageIds: [2, 1], noactionT: 1000 });
});

// Endpoint: Wallet Withdraw
app.post('/tx/walletwithdraw', (req, res) => {
  // Perform wallet withdrawal transaction
  // ...

  res.status(200).json({ status: '0000', nextPageIds: [2, 1], noactionT: 1000 });
});

// Generate a unique user ID
function generateUserId() {
  // Generate a random unique user ID logic
  // ...
}

// Start the server
app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});


function generateSHA1(input) {
  const sha1Hash = crypto.createHash('sha1');
  sha1Hash.update(input);
  return sha1Hash.digest('hex');
}