import { Router } from "express";
import {controller} from "./controller";
import verifyJwt from "../middleware/jwt";
export const authRoutes = Router();

authRoutes.post('/refresh',controller.refresh);
authRoutes.post('/login',controller.login);
authRoutes.post('/register',controller.register);
authRoutes.post('/logout',verifyJwt,controller.logout);
authRoutes.post('/verifyotp',controller.verifyOTP);
authRoutes.post('/resendotp',controller.resendOTPVerificationCode);
authRoutes.post('/updateuser',controller.updateUser);
authRoutes.post('/forgetpassword',controller.forgetPassword);
// authRoutes.get('/resetpassword/:id/:token',controller.getResetPassword);
authRoutes.post('/resetpassword',controller.postResetPassword);