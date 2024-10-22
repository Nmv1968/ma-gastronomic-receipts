import { Entity, Column, PrimaryGeneratedColumn } from 'typeorm';

@Entity()
export class favorito_receta_usuario {
  @PrimaryGeneratedColumn()
  id: number;

  @Column({ type: 'integer', nullable: true })
  id_receta: number;

  @Column({ type: 'integer', nullable: true })
  valoracion: number;
}
