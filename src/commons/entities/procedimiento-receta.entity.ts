import { Entity, Column, PrimaryGeneratedColumn } from 'typeorm';

@Entity()
export class procedimiento_receta {
  @PrimaryGeneratedColumn()
  id: number;

  @Column({ type: 'integer', nullable: true })
  id_receta: number;

  @Column({ type: 'varchar', nullable: true })
  descripcion: string;

  @Column({ type: 'float', nullable: true })
  tiempo: number;
}
