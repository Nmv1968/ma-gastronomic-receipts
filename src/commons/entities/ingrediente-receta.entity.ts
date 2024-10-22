import { Entity, Column, PrimaryGeneratedColumn } from 'typeorm';

@Entity()
export class ingrediente_receta {
  @PrimaryGeneratedColumn()
  id: number;

  @Column({ type: 'integer', nullable: true })
  id_ingrediente: number;

  @Column({ type: 'integer', nullable: true })
  id_receta: number;

  @Column({ type: 'varchar', nullable: true })
  descripcion: string;

  @Column({ type: 'integer', nullable: true })
  cantidad: number;
}
