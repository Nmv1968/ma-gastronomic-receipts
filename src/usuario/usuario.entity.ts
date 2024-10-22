import { Entity, Column, PrimaryGeneratedColumn } from 'typeorm';

@Entity()
export class usuarios {
  @PrimaryGeneratedColumn()
  id: number;

  @Column({ type: 'varchar', nullable: true })
  nombre_completo: string;

  @Column({ type: 'varchar', nullable: true })
  username: string;

  @Column({ type: 'varchar', nullable: true })
  password: string;

  @Column({ type: 'integer', nullable: true })
  id_perfil: number;
}
