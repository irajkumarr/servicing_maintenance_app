const nodemailer = require("nodemailer");

const transporter = nodemailer.createTransport({
  service: "gmail",
  auth: {
    user: process.env.AUTH_EMAIL,
    pass: process.env.AUTH_PASSWORD,
  },
});

const sendEmailWithOTP = (userEmail, name, otp) => {
  const mailOptions = {
    from: "ServiceOnWheels <kumarffraj85@gmail.com>",
    to: userEmail,
    subject: `Verify your Email - OTP `,
    html: `
    <div style="font-family: Roboto, Arial, sans-serif; color: #333; max-width: 600px; margin: auto; padding: 20px; border: 1px solid #ddd; border-radius: 8px;">
     <h2  style="color: #9b1e29; text-align: center;">Verify Email</h2>
     <p style="text-align: center;">Hello <strong>${name}</strong>,</p>
            <p style="text-align: center;"> Use the OTP code below to verify it:</p>
            <h3 style="text-align: center;">Code: <strong style="text-decoration: underline;">${otp}</strong></h3>
            <p style="text-align: center;">This OTP code will expire in 60 minutes.</p>
           
            <p>For support, contact us at <a href="mailto:contact@serviceonwheels.com" style="color: #9b1e29;">contact@serviceonwheels.com</a></p>
            <p style="text-align: center;">Thanks,<br>The ServiceOnWheels Team</p>
            </div>
     `,
  };

  transporter.sendMail(mailOptions, (error, info) => {
    // if (error) {
    //   console.log("Error sending email:", error);
    // } else {
    //   console.log(" email sent:", info.response);
    // }
  });
};
module.exports = { sendEmailWithOTP };
