import { Entity, Column, PrimaryGeneratedColumn } from 'typeorm';

@Entity()
export class recetas {
  @PrimaryGeneratedColumn()
  id: number;

  @Column({ type: 'varchar', nullable: true })
  descripcion: string;

  @Column({ type: 'integer', nullable: true })
  id_usuario: number;
}
