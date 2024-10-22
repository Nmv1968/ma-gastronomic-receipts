import { Entity, Column, PrimaryGeneratedColumn } from 'typeorm';

@Entity()
export class perfiles {
  @PrimaryGeneratedColumn()
  id: number;

  @Column({ type: 'varchar', nullable: true })
  descripcion: string;
}
