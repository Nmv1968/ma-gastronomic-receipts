import { ApiProperty } from '@nestjs/swagger';
import { Type } from 'class-transformer';
import {
  IsArray,
  IsNotEmpty,
  IsNumber,
  IsOptional,
  IsString,
  MaxLength,
  ValidateNested,
} from 'class-validator';

class IngredientesDto {
  id_receta: number;

  @IsNotEmpty()
  @IsNumber(undefined, { message: 'id_ingrediente debe ser tipo string' })
  @ApiProperty({
    example: 2,
    description: 'id_ingrediente',
  })
  id_ingrediente: number;

  @IsNotEmpty()
  @MaxLength(300)
  @IsString({ message: 'descripcion debe ser tipo string' })
  @ApiProperty({
    example: 2,
    description: 'descripcion',
  })
  descripcion: string;

  @IsOptional()
  @IsNumber(undefined, { message: 'cantidad debe ser tipo numérico' })
  @ApiProperty({
    example: 2,
    description: 'cantidad',
  })
  cantidad: number;
}

class ProcedimientosDto {
  id_receta: number;

  @IsNotEmpty()
  @MaxLength(300)
  @IsString({ message: 'descripcion debe ser tipo string' })
  @ApiProperty({
    example: 2,
    description: 'descripcion',
  })
  descripcion: string;
}

export class CrearRecetaDto {
  id: any;

  @IsOptional()
  @MaxLength(300)
  @IsString({ message: 'descripcion debe ser tipo string' })
  @ApiProperty({
    example: 2,
    description: 'ID paciente',
  })
  descripcion: string;

  @IsOptional()
  @ValidateNested({
    each: true,
  })
  @IsArray({ message: `El campo 'invoice_tax' debe ser un array` })
  @Type(() => IngredientesDto)
  @ApiProperty({ type: [IngredientesDto] })
  ingredientes?: IngredientesDto[];

  @IsOptional()
  @ValidateNested({
    each: true,
  })
  @IsArray({ message: `El campo 'invoice_tax' debe ser un array` })
  @Type(() => ProcedimientosDto)
  @ApiProperty({ type: [ProcedimientosDto] })
  procedimientos?: ProcedimientosDto[];
}
