import { ApiProperty } from '@nestjs/swagger';
import { IsNotEmpty, IsString, MaxLength } from 'class-validator';

export class LoginUsuarioDto {
  @IsNotEmpty({ message: `El campo 'username' es obligatorio` })
  @MaxLength(100)
  @IsString({ message: 'username debe ser tipo string' })
  @ApiProperty({
    example: 2,
    description: 'Username',
  })
  username: string;

  @IsNotEmpty({ message: `El campo 'password' es obligatorio` })
  @MaxLength(100)
  @IsString({ message: 'password debe ser tipo string' })
  @ApiProperty({
    example: 2,
    description: 'Password',
  })
  password: string;
}
