import { ApiProperty } from '@nestjs/swagger';
import { IsOptional, IsString, MaxLength } from 'class-validator';

export class CrearIngredienteDto {
  id: any;

  @IsOptional()
  @MaxLength(300)
  @IsString({ message: 'descripcion debe ser tipo string' })
  @ApiProperty({
    example: 2,
    description: 'ID paciente',
  })
  descripcion: string;
}
