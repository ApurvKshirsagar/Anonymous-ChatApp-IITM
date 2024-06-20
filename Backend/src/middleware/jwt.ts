import { Request, Response, NextFunction } from "express";
import jwt, { VerifyErrors } from "jsonwebtoken";

interface AuthRequest extends Request {
  user?: any;
}

const verifyJwt = (req: AuthRequest, res: Response, next: NextFunction) => {
  const authHeader = req.headers.auth as string;

  if (!authHeader) {
    return res
      .status(401)
      .json({ message: "Unauthorized: Missing Authorization header" });
  }

  const token = authHeader.split(" ")[1];

  jwt.verify(
    token,
    process.env.TOKEN_SECRET || "",
    (err: VerifyErrors | null, user: any) => {
      if (err) {
        return res.status(403).json({ error: err, message: "Invalid token" });
      }

      // Add a check for user existence before assigning
      if (!req.hasOwnProperty("user")) {
        req.user = user;
      }

      next();
    }
  );
};

export default verifyJwt;
