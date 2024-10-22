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
import { RecetaService } from './receta.service';
import { Public } from 'src/commons/utils/decorators';
import {
  ApiBearerAuth,
  ApiOperation,
  ApiQuery,
  ApiResponse,
  ApiTags,
} from '@nestjs/swagger';
import { CrearRecetaDto } from './dto/crear-receta.dto';
import { IGenericResponse } from 'src/commons/utils/general';
@ApiBearerAuth()
@ApiTags('Receta')
@Controller('receta')
export class RecetaController {
  constructor(private readonly recetaService: RecetaService) {}

  @Get('')
  @Public()
  @ApiOperation({ summary: 'Listar Receta' })
  @ApiResponse({
    status: HttpStatus.OK,
    description: 'Recetas encontrados',
  })
  @ApiResponse({
    status: HttpStatus.NOT_FOUND,
    description: 'Recetas no encontrados',
  })
  @ApiQuery({ name: 'descripcion', required: false, type: String })
  async listar(
    @Query() params: any,
    @Req() request: Request,
  ): Promise<IGenericResponse<any>> {
    try {
      return this.recetaService.listar(params);
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
  @ApiOperation({ summary: 'Obtener Receta' })
  @ApiResponse({
    status: HttpStatus.OK,
    description: 'Receta encontrado',
  })
  @ApiResponse({
    status: HttpStatus.NOT_FOUND,
    description: 'Receta no encontrada',
  })
  async buscar(@Param('id') id: number): Promise<IGenericResponse<any>> {
    try {
      return this.recetaService.buscar(id);
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
  @ApiOperation({ summary: 'Crear Receta' })
  @ApiResponse({
    status: HttpStatus.CREATED,
    description: 'Receta registrada exitosamente',
  })
  @ApiResponse({
    status: HttpStatus.INTERNAL_SERVER_ERROR,
    description: 'Error al crear el receta',
  })
  async crear(@Body() data: CrearRecetaDto): Promise<IGenericResponse<any>> {
    try {
      console.log(data);
      const response = this.recetaService.crear(data);

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
  @ApiOperation({ summary: 'Editar Receta' })
  @ApiResponse({
    status: HttpStatus.CREATED,
    description: 'Receta editado exitosamente',
  })
  @ApiResponse({
    status: HttpStatus.INTERNAL_SERVER_ERROR,
    description: 'Error al editar el receta',
  })
  async actualizar(
    @Param('id') id: number,
    @Body() data: CrearRecetaDto,
  ): Promise<IGenericResponse<any>> {
    try {
      const response = this.recetaService.editar(id, data);

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
  @ApiOperation({ summary: 'Eliminar Receta' })
  @ApiResponse({
    status: HttpStatus.CREATED,
    description: 'Receta eliminado exitosamente',
  })
  @ApiResponse({
    status: HttpStatus.INTERNAL_SERVER_ERROR,
    description: 'Error al eliminar el receta',
  })
  async eliminar(@Param('id') id: number): Promise<IGenericResponse<any>> {
    try {
      const response = this.recetaService.eliminar(id);

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
