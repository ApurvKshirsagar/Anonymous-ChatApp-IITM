import AppDataSource from "../config";
import bcrypt from "bcrypt";
import * as jwt from "jsonwebtoken";
import User from "../entities/user";
import OtpVerify from "../entities/otpVerify";
import nodemailer from "nodemailer";

const generateAccessToken = (user: User): String => {
  const id = user.user_id;
  return jwt.sign({ id: id }, process.env.TOKEN_SECRET || "", {
    expiresIn: "20s",
  });
};

const generateRefreshToken = (user: User): String => {
  const id = user.user_id;
  return jwt.sign({ id: id }, process.env.REFRESH_TOKEN_SECRET || "");
};

let refreshTokens: any = [];

const refresh = async (req: any, res: any) => {
  const refreshToken = req.body.token;

  if (!refreshToken)
    return res.status(401).json({ message: "You are not authenticated." });
  if (!refreshTokens.includes(refreshToken)) {
    return res.status(403).json({ message: "Refresh token is not valid." });
  }
  jwt.verify(
    refreshToken,
    process.env.REFRESH_TOKEN_SECRET || "",
    (err: any, user: any) => {
      err && console.log(err);
      refreshTokens = refreshTokens.filter((token: any) => {
        token !== refreshToken;
      });
      const newAccessToken = generateAccessToken(user);
      const newRefreshToken = generateRefreshToken(user);

      refreshTokens.push(newRefreshToken);

      res.status(200).json({
        accessToken: newAccessToken,
        refreshToken: newRefreshToken,
      });
    }
  );
};

const login = async (req: any, res: any) => {
  const userRepo = AppDataSource.getRepository(User);

  const user = await userRepo.findOne({
    where: { email: req.body.email },
  });

  if (!user) {
    res.status(404).json({ error: "User not found, Please Register." });
  } else {
    const matchPassword = await bcrypt.compare(
      req.body.password,
      user.password
    );
    if (!matchPassword) {
      res.status(404).json({ error: "Invalid Credentials" });
    } else {
      const accessToken = generateAccessToken(user);
      const refreshToken = generateRefreshToken(user);

      refreshTokens.push(refreshToken);
      res.status(200).json({
        message: "User Logged In",
        accessToken: accessToken,
        refreshToken: refreshToken,
      });
    }
  }
};

const register = async (req: any, res: any) => {
  const userRepo = AppDataSource.getRepository(User)

  const user = await userRepo.findOne({
    where: { email: req.body.email },
  });

  var email = req.body.email;
  const mailformat = /^[a-z]{2}\d{2}[a-z]\d{3}@smail\.iitm\.ac\.in$/;

  if (!email.match(mailformat)) {
    res.status(404).json({
      message: "Invalid Smail",
      status: "Failed"
    })
  } else {
    if (user) {
      if (user) {
        res.status(203).json({
          message: "User already Registered, Please Login to your account",
        });
      }
      // else {
      //   res.status(202).json({
      //     message: "User already exist, please verify",
      //   });
      //   const otp_Sent = sendOtp(user, res)
      //   console.log(otp_Sent)
      // }

    } else {
      let user = { ...req.body };
      console.log(user)
      // const hashedpassword = await bcrypt.hash(user.password, 12);
      // user.password = hashedpassword;
      await sendOtp(user, res)
    }
  }
};

const logout = (req: any, res: any) => {
  const refreshToken = req.body.token;
  refreshTokens = null;
  return res.json({ message: "User logged out" });
};

// const transporter = nodemailer.createTransport({
//   host: "smtp.ethereal.email",
//   port: 587,
//   auth: {
//     user: process.env.AUTH_EMAIL,
//     pass: process.env.AUTH_PASSWORD,
//   },
// });
const transporter = nodemailer.createTransport({
  // host: "gmail",
  // port: 587,
  // secure: true,
  service: "gmail",
  auth: {
    user: process.env.AUTH_EMAIL,
    pass: process.env.AUTH_PASSWORD,
  },
});


const sendOtp = async (user: any, res: any) => {
  // console.log(user)
  const otpRepo = AppDataSource.getRepository(OtpVerify)

  let userExist = await otpRepo.findOne({
    where: { email: user.email }
  })

  if (userExist) {
    await otpRepo.delete({ email: user.email })
  }

  try {
    const otp = `${Math.floor(100000 + Math.random() * 900000)}`
    console.log(otp)
    const mailOptions = {
      from: process.env.USER_EMAIL,
      to: user.email,
      subject: 'Verification Email',
      text: `Enter the code: ${otp}​. This is OTP will expire in 1 hrs`,
      html: `<p>Enter the code: <strong>${otp}</strong></p>
      <p>This is OTP will <strong>expire in 1 hrs</strong></p>`
    };

    const saltRounds = 10
    const hashedOtp = await bcrypt.hash(otp, saltRounds)
    let newOtp = new OtpVerify();
    newOtp = {
      user_id: user.user_id,
      email: user.email,
      otp: hashedOtp,
      createdAt: new Date(Date.now()),
      expiresAt: new Date(Date.now() + 3600000)
    }

    // console.log(newOtp)
    try {
      const otpsaved = await otpRepo.save(newOtp)
    } catch (err) {
      console.log(err)
    }

    transporter.sendMail(mailOptions, (error, info) => {
      if (error) {
        console.log('Error:', error);
      } else {
        console.log('Email sent:', info.response);
      }
    });

    // transporter.sendMail(mailOptions)

    res.json({
      status: "Pending",
      message: "otp sent",
      data: {
        userId: user.user_id,
        email: user.email
      }
    })

  } catch {
    res.json({
      status: "Failed",
      message: "otp sent"
    })
  }
}


const verifyOTP = async (req: any, res: any) => {
  const userRepo = AppDataSource.getRepository(User);
  console.log(req.body)
  try {
    let user = req.body;
    console.log(user)
    let inputEmail = user.email;
    let inputOtp = req.body.otp

    console.log(inputEmail)
    console.log(inputOtp)
    if (!inputEmail || !inputOtp) {
      throw Error("empty otp details not allowed")
    } else {
      const otpRepo = AppDataSource.getRepository(OtpVerify)

      const userOtpVerification = await otpRepo.findOne({
        where: { email: inputEmail }
      })
      console.log(userOtpVerification)

      if (!userOtpVerification) {
        throw new Error("Account record doesn't exist or verified")
      } else {
        console.log("hh")
        const expiresAt = userOtpVerification.expiresAt
        // const hashedOtp = userOtpVerification[0].otp
        const otp = userOtpVerification.otp

        console.log(otp)


        if (expiresAt < new Date(Date.now())) {
          // await userOtpVerification.delete({ user_id:userId })
          await otpRepo.delete({ email: inputEmail })

          // throw new Error("Code expired")
          return res.json(
            { error: "OTP Expired" }
          )
        } else {
          const validOtp = await bcrypt.compare(inputOtp, otp)
          console.log(validOtp)
          if (!validOtp) {
            return res.status(404).json(
              { error: "Invalid code passed" }
            )
          } else {
            const hashedpassword = await bcrypt.hash(user.password, 12);
            user.password = hashedpassword;

            await otpRepo.delete({ email: inputEmail })
            await userRepo.save(user);

            res.status(200).send({
              status: "verified",
              message: ({ message: "User Registered" })
            })

          }
        }
      }
    }
  } catch (error) {
    res.status(404).json({
      status: "Failed",
      message:({message:error})
    })
  }
}


const resendOTPVerificationCode = async (req: any, res: any) => {
  try {
    console.log(req.body)
    // let userId = req.body.userId
    let inputEmail = req.body.email

    if (!inputEmail) {
      throw Error("empty otp details not allowed")
    } else {
      const otpRepo = AppDataSource.getRepository(OtpVerify)
      await otpRepo.delete({ email: inputEmail })
      const user = {
        // user_id: userId,
        email: inputEmail
      }
      console.log(user)
      await sendOtp(user, res)
    }
  } catch (error) {
    console.log(error)
    res.json({
      status: "failed",
      message: error
    })
  }
}

const updateUser = async (req: any, res: any) => {
  const userRepo = AppDataSource.getRepository(User)

  const user = await userRepo.findOne({
    where: { email: req.body.email },
  });
  if (user) {
    user.gender=req.body.gender;
  }
}

const forgetPassword = async (req: any, res: any) => {
  const userRepo = AppDataSource.getRepository(User)

  const user = await userRepo.findOne({
    where: { email: req.body.email },
  });
  if (user) {
    await sendOtp(user, res);
  } else {
    res.status(404).json({
      message: "email not registered"
    })
  }
  // if (user) {
  //   const secret = process.env.JWT_SECRET + user.password
  //   const payload = {
  //     email: user.email,
  //     id: user.user_id
  //   }
  //   const token = jwt.sign(payload, secret, { expiresIn: '15m' })
  //   const link = `http://localhost:3000/api/v1/auth/resetpassword/${user.user_id}/${token}`
  //   console.log(link)
  //   //send link to email via nodemailer

  //   const mailOptions = {
  //     from: process.env.USER_EMAIL,
  //     to: user.email,
  //     subject: 'Reset Password',
  //     text: `Link to update your password`,
  //     html: `<p>Click on the Link: <strong>${link}</strong></p>
  //     <p>This Link will <strong>expire in 15minutes</strong></p>`
  //   };

  //   transporter.sendMail(mailOptions, (error, info) => {
  //     if (error) {
  //       console.log('Error:', error);
  //     } else {
  //       console.log('Email sent:', info.response);
  //     }
  //   });

  //   res.send("link sent ")

  // } else {
  //   res.send({
  //     message: "user not found"
  //   })
  //   return;
  // }
}

const getResetPassword = async (req: any, res: any) => {
  // const { id, token } = req.params
  // const userRepo = AppDataSource.getRepository(User)

  // const user = await userRepo.findOne({
  //   where: { user_id: id },
  // });

  // if (user) {
  //   const secret = process.env.JWT_SECRET + user.password
  //   try {
  //     const payload = jwt.verify(token, secret)
  //     res.render('reset-password', { email: user.email })
  //   } catch (error) {
  //     console.log(error)
  //     res.send(error)
  //   }


  // } else {
  //   res.send({
  //     message: "user not found"
  //   })
  //   return;
  // }

}

const postResetPassword = async (req: any, res: any) => {
  const otpRepo = AppDataSource.getRepository(OtpVerify)

  const userOtpVerification = await otpRepo.findOne({
    where: { email: req.body.email }
  })

  var inputEmail = req.body.email;
  var inputOtp = req.body.otp;
  // const { id, token } = req.params
  const inputPassword = req.body.password
  const userRepo = AppDataSource.getRepository(User)

  const user = await userRepo.findOne({
    // where: { user_id: id },
    where: { email: req.body.email }
  });

  if (user) {
    if (!userOtpVerification) {
      throw new Error("Account record doesn't exist or verified")
    } else {
      console.log("hh")
      const expiresAt = userOtpVerification.expiresAt
      // const hashedOtp = userOtpVerification[0].otp
      const otp = userOtpVerification.otp

      console.log(otp)


      if (expiresAt < new Date(Date.now())) {
        // await userOtpVerification.delete({ user_id:userId })
        await otpRepo.delete({ email: inputEmail })

        // throw new Error("Code expired")
        return res.status(404).json(
          { error: "OTP Expired" }
        )
      } else {
        const validOtp = await bcrypt.compare(inputOtp, otp)
        console.log(validOtp)
        if (!validOtp) {
          return res.status(404).json(
            { error: "Invalid code passed" }
          )
        } else {
          const hashedpassword = await bcrypt.hash(inputPassword, 12);
          user.password = hashedpassword;

          await otpRepo.delete({ email: inputEmail })
          await userRepo.save(user);

          res.status(200).send({
            status: "Otp Verified",
            message: ({ message: "User Password Updated" })
          })

        }
      }
    }
  }


}

export const controller = {
  refresh,
  login,
  register,
  logout,
  verifyOTP,
  resendOTPVerificationCode,
  forgetPassword,
  updateUser,
  getResetPassword,
  postResetPassword
};
