import { Entity, Column, PrimaryGeneratedColumn } from 'typeorm';

@Entity()
export class ingrediente_usuario {
  @PrimaryGeneratedColumn()
  id: number;

  @Column({ type: 'integer', nullable: true })
  id_ingrediente: number;

  @Column({ type: 'float', nullable: true })
  id_usuario: number;
}
