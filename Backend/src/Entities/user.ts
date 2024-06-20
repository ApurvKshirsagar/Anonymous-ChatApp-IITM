import { Entity, PrimaryGeneratedColumn, Column } from "typeorm";

@Entity({ name: "User" })
export class User {
  @PrimaryGeneratedColumn("uuid")
  user_id: string;

  @Column()
  username: string;

  @Column()
  email: string;

  @Column()
  password: string;

  // @Column()
  // gender: {
  //   type: string,
  //   default: "male"
  // };

  @Column({ type: "varchar", default: "male" })
gender: string;


  // @Column()
  // city: string;

  // @Column()
  // fcmToken: string;
}

export default User;