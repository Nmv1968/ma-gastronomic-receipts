import { Entity, Column, PrimaryGeneratedColumn } from 'typeorm';

@Entity()
export class ingredientes {
  @PrimaryGeneratedColumn()
  id: number;

  @Column({ type: 'varchar', nullable: true })
  descripcion: string;
}
