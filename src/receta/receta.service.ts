import { JwtService } from '@nestjs/jwt';
import { HttpException, HttpStatus, Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { recetas } from '../commons/entities/receta.entity';
import {
  Between,
  ILike,
  LessThanOrEqual,
  MoreThanOrEqual,
  Repository,
} from 'typeorm';
import { IGenericResponse } from 'src/commons/utils/general';
import { CrearRecetaDto } from './dto/crear-receta.dto';
import { AuthService } from 'src/commons/security/auth.service';
import { ingrediente_receta } from 'src/commons/entities/ingrediente-receta.entity';
import { procedimiento_receta } from 'src/commons/entities/procedimiento-receta.entity';

@Injectable()
export class RecetaService {
  constructor(
    @InjectRepository(recetas)
    private receta: Repository<recetas>,
    @InjectRepository(ingrediente_receta)
    private ingrediente: Repository<ingrediente_receta>,
    @InjectRepository(procedimiento_receta)
    private procedimiento: Repository<procedimiento_receta>,
    private jwtService: JwtService,
    private authService: AuthService,
  ) {}

  async listar(params: any): Promise<any> {
    try {
      const response: IGenericResponse<any> = {
        success: true,
      };

      const receta: CrearRecetaDto[] = await this.receta.find(params);

      response.message = 'Ingreso exitoso';
      response.data = receta;
      return response;
    } catch (error) {
      throw new HttpException(
        error?.message ?? `Algo salió mal`,
        error?.status ?? HttpStatus.INTERNAL_SERVER_ERROR,
      );
    }
  }

  async buscar(id: any): Promise<IGenericResponse<any>> {
    try {
      const response: IGenericResponse<any> = {
        success: true,
      };

      const receta: CrearRecetaDto = await this.receta.findOneBy({
        id,
      });

      if (!receta)
        throw new HttpException(`Receta no encontrado`, HttpStatus.NOT_FOUND);

      response.message = 'Ingreso exitoso';
      response.data = receta;
      return response;
    } catch (error) {
      throw new HttpException(
        error?.message ?? `Algo salió mal`,
        error?.status ?? HttpStatus.INTERNAL_SERVER_ERROR,
      );
    }
  }

  async crear(data: CrearRecetaDto): Promise<IGenericResponse<recetas>> {
    const response: IGenericResponse<any> = {
      success: false,
    };

    try {
      const nuevo = this.receta.create(data);
      const { id } = await this.receta.save(nuevo);

      const ingrediente = data.ingredientes.map(async (ing) => {
        ing.id_receta = id;
        return await this.ingrediente.insert(ing);
      });
      const procedimiento = data.procedimientos.map(async (pro) => {
        pro.id_receta = id;
        return await this.procedimiento.insert(pro);
      });

      await Promise.all(ingrediente);
      await Promise.all(procedimiento);

      response.success = true;
      response.message = 'Datos creados exitosamente';
      return response;
    } catch (error) {
      throw new HttpException(
        `Error al registrar: ${error.message}`,
        error.status ?? HttpStatus.INTERNAL_SERVER_ERROR,
      );
    }
  }

  async editar(
    id: any,
    CrearRecetaDto: CrearRecetaDto,
  ): Promise<IGenericResponse<recetas>> {
    const response: IGenericResponse<any> = {
      success: false,
    };

    try {
      await this.receta.update({ id }, CrearRecetaDto);

      response.success = true;
      response.message = 'Datos actualizados exitosamente';
      return response;
    } catch (error) {
      throw new HttpException(
        `Error al registrar: ${error.message}`,
        error.status ?? HttpStatus.INTERNAL_SERVER_ERROR,
      );
    }
  }

  async eliminar(id: any): Promise<IGenericResponse<recetas>> {
    const response: IGenericResponse<any> = {
      success: false,
    };

    try {
      await this.receta.delete({ id });

      response.success = true;
      response.message = 'Datos actualizados exitosamente';
      return response;
    } catch (error) {
      throw new HttpException(
        `Error al registrar: ${error.message}`,
        error.status ?? HttpStatus.INTERNAL_SERVER_ERROR,
      );
    }
  }
}
