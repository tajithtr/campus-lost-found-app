const functions = require("firebase-functions");
const nodemailer = require("nodemailer");

// Gmail transporter
const transporter = nodemailer.createTransport({
  service: "gmail",
  auth: {
    user: "bhagyaabeykoon004@gmail.com",
    pass: "qerqxbgtzkuyptrh",
  },
});

// API function
exports.sendOTP = functions.https.onRequest(async (req, res) => {
  const { email, otp } = req.body;

  if (!email || !otp) {
    return res.status(400).send("Missing email or OTP");
  }

  try {
    await transporter.sendMail({
      from: "bhagyaabeykoon004@gmail.com",
      to: email,
      subject: "OTP Verification",
      text: `Your OTP is: ${otp}`,
    });

    res.status(200).send("OTP sent successfully");
  } catch (error) {
    console.error(error);
    res.status(500).send("Error sending OTP");
  }
});