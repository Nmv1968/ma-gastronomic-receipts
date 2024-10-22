import {
  Body,
  Controller,
  Get,
  HttpException,
  HttpStatus,
  Post,
  Query,
} from '@nestjs/common';
import { UsuarioService } from './usuario.service';
import { Public } from 'src/commons/utils/decorators';
import {
  ApiBearerAuth,
  ApiOperation,
  ApiQuery,
  ApiResponse,
  ApiTags,
} from '@nestjs/swagger';
import { CrearUsuarioDto } from './dto/crear-usuario.dto';
import { IGenericResponse } from 'src/commons/utils/general';
import { LoginUsuarioDto } from './dto/login-usuario.dto';

@ApiBearerAuth()
@ApiTags('Usuarios')
@Controller('usuario')
export class UsuarioController {
  constructor(private readonly usuarioService: UsuarioService) {}

  @Post()
  @Public()
  @ApiOperation({ summary: 'Crear Usuario' })
  @ApiResponse({
    status: HttpStatus.CREATED,
    description: 'Usuario registrada exitosamente',
  })
  @ApiResponse({
    status: HttpStatus.INTERNAL_SERVER_ERROR,
    description: 'Error al crear el usuario',
  })
  async create(@Body() data: CrearUsuarioDto): Promise<IGenericResponse<any>> {
    try {
      const response = this.usuarioService.crear(data);

      return response;
    } catch (error) {
      throw new HttpException(
        error?.message ?? 'Algo salió mal',
        typeof error?.status === 'number'
          ? error.status
          : HttpStatus.INTERNAL_SERVER_ERROR,
      );
    }
  }

  @Post('/login')
  @Public()
  findOne(@Body() params: LoginUsuarioDto): Promise<IGenericResponse<any>> {
    return this.usuarioService.iniciarSesion(params);
  }
}
