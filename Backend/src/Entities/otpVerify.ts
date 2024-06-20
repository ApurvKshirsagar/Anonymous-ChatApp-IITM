import { Entity, PrimaryGeneratedColumn, Column } from "typeorm";

@Entity({ name: "OtpVerify" })
export class OtpVerify {
    @PrimaryGeneratedColumn("uuid")
    user_id: string;

    @Column()
    email:string;

    @Column()
    otp: string;

    @Column()
    createdAt:Date;

    @Column()
    expiresAt:Date;   
}

export default OtpVerify;