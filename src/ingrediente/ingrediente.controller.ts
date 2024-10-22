import {
  Body,
  Controller,
  Delete,
  Get,
  HttpException,
  HttpStatus,
  Param,
  Post,
  Put,
  Query,
  Req,
} from '@nestjs/common';
import { IngredienteService } from './ingrediente.service';
import { Public } from 'src/commons/utils/decorators';
import {
  ApiBearerAuth,
  ApiOperation,
  ApiQuery,
  ApiResponse,
  ApiTags,
} from '@nestjs/swagger';
import { CrearIngredienteDto } from './dto/crear-ingrediente.dto';
import { IGenericResponse } from 'src/commons/utils/general';
import { AuthService } from 'src/commons/security/auth.service';

@ApiBearerAuth()
@ApiTags('Ingredientes')
@Controller('ingrediente')
export class IngredienteController {
  constructor(
    private readonly ingredienteService: IngredienteService,
    private authService: AuthService,
  ) {}

  @Get('')
  @Public()
  @ApiOperation({ summary: 'Listar Ingrediente' })
  @ApiResponse({
    status: HttpStatus.OK,
    description: 'Ingredientes encontrados',
  })
  @ApiResponse({
    status: HttpStatus.NOT_FOUND,
    description: 'Ingredientes no encontrados',
  })
  @ApiQuery({ name: 'descripcion', required: false, type: String })
  async listar(
    @Query() params: any,
    @Req() request: Request,
  ): Promise<IGenericResponse<any>> {
    try {
      return this.ingredienteService.listar(params);
    } catch (error) {
      throw new HttpException(
        error?.message ?? 'Algo salió mal',
        typeof error?.status === 'number'
          ? error.status
          : HttpStatus.INTERNAL_SERVER_ERROR,
      );
    }
  }

  @Get('/:id')
  @Public()
  @ApiOperation({ summary: 'Obtener Ingrediente' })
  @ApiResponse({
    status: HttpStatus.OK,
    description: 'Ingrediente encontrado',
  })
  @ApiResponse({
    status: HttpStatus.NOT_FOUND,
    description: 'Ingrediente no encontrada',
  })
  async buscar(@Param('id') id: number): Promise<IGenericResponse<any>> {
    try {
      return this.ingredienteService.buscar(id);
    } catch (error) {
      throw new HttpException(
        error?.message ?? 'Algo salió mal',
        typeof error?.status === 'number'
          ? error.status
          : HttpStatus.INTERNAL_SERVER_ERROR,
      );
    }
  }

  @Post()
  @Public()
  @ApiOperation({ summary: 'Crear Ingrediente' })
  @ApiResponse({
    status: HttpStatus.CREATED,
    description: 'Ingrediente registrada exitosamente',
  })
  @ApiResponse({
    status: HttpStatus.INTERNAL_SERVER_ERROR,
    description: 'Error al crear el ingrediente',
  })
  async crear(
    @Body() data: CrearIngredienteDto,
  ): Promise<IGenericResponse<any>> {
    try {
      const response = this.ingredienteService.crear(data);

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

  @Put('/:id')
  @Public()
  @ApiOperation({ summary: 'Editar Ingrediente' })
  @ApiResponse({
    status: HttpStatus.CREATED,
    description: 'Ingrediente editado exitosamente',
  })
  @ApiResponse({
    status: HttpStatus.INTERNAL_SERVER_ERROR,
    description: 'Error al editar el ingrediente',
  })
  async actualizar(
    @Param('id') id: number,
    @Body() data: CrearIngredienteDto,
  ): Promise<IGenericResponse<any>> {
    try {
      const response = this.ingredienteService.editar(id, data);

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

  @Delete('/:id')
  @Public()
  @ApiOperation({ summary: 'Eliminar Ingrediente' })
  @ApiResponse({
    status: HttpStatus.CREATED,
    description: 'Ingrediente eliminado exitosamente',
  })
  @ApiResponse({
    status: HttpStatus.INTERNAL_SERVER_ERROR,
    description: 'Error al eliminar el ingrediente',
  })
  async eliminar(
    @Param('id') id: number,
    @Body() data: CrearIngredienteDto,
  ): Promise<IGenericResponse<any>> {
    try {
      const response = this.ingredienteService.eliminar(id);

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
}
