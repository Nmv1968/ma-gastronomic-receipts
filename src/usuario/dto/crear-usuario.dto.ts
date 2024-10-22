import { ApiProperty } from '@nestjs/swagger';
import { IsNumber, IsOptional, IsString, MaxLength } from 'class-validator';

export class CrearUsuarioDto {
  id: any;

  @IsOptional()
  @MaxLength(300)
  @IsString({ message: 'patient_uuid debe ser tipo string' })
  @ApiProperty({
    example: 2,
    description: 'ID paciente',
  })
  nombre_completo: string;

  @IsOptional()
  @MaxLength(300)
  @IsString({ message: 'patient_uuid debe ser tipo string' })
  @ApiProperty({
    example: 2,
    description: 'ID paciente',
  })
  username: string;

  @IsOptional()
  @MaxLength(300)
  @IsString({ message: 'patient_uuid debe ser tipo string' })
  @ApiProperty({
    example: 2,
    description: 'ID paciente',
  })
  password: string;

  @IsOptional()
  @MaxLength(300)
  @IsNumber(undefined, { message: 'patient_uuid debe ser tipo string' })
  @ApiProperty({
    example: 2,
    description: 'ID paciente',
  })
  id_perfil: number;
}
