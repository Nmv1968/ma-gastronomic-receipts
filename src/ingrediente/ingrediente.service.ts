import { JwtService } from '@nestjs/jwt';
import { HttpException, HttpStatus, Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { ingredientes } from '../commons/entities/ingrediente.entity';
import {
  Between,
  ILike,
  LessThanOrEqual,
  MoreThanOrEqual,
  Repository,
} from 'typeorm';
import { IGenericResponse } from 'src/commons/utils/general';
import { CrearIngredienteDto } from './dto/crear-ingrediente.dto';
import { AuthService } from 'src/commons/security/auth.service';

@Injectable()
export class IngredienteService {
  constructor(
    @InjectRepository(ingredientes)
    private ingrediente: Repository<ingredientes>,
    private jwtService: JwtService,
    private authService: AuthService,
  ) {}

  async listar(params: any): Promise<any> {
    try {
      const response: IGenericResponse<any> = {
        success: true,
      };

      const ingrediente: CrearIngredienteDto[] =
        await this.ingrediente.find(params);

      response.message = 'Ingreso exitoso';
      response.data = ingrediente;
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

      const ingrediente: CrearIngredienteDto = await this.ingrediente.findOneBy(
        {
          id,
        },
      );

      if (!ingrediente)
        throw new HttpException(
          `Ingrediente no encontrado`,
          HttpStatus.NOT_FOUND,
        );

      response.message = 'Ingreso exitoso';
      response.data = ingrediente;
      return response;
    } catch (error) {
      throw new HttpException(
        error?.message ?? `Algo salió mal`,
        error?.status ?? HttpStatus.INTERNAL_SERVER_ERROR,
      );
    }
  }

  async crear(
    CrearIngredienteDto: CrearIngredienteDto,
  ): Promise<IGenericResponse<ingredientes>> {
    const response: IGenericResponse<any> = {
      success: false,
    };

    try {
      const nuevo = this.ingrediente.create(CrearIngredienteDto);
      await this.ingrediente.save(nuevo);

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
    CrearIngredienteDto: CrearIngredienteDto,
  ): Promise<IGenericResponse<ingredientes>> {
    const response: IGenericResponse<any> = {
      success: false,
    };

    try {
      await this.ingrediente.update({ id }, CrearIngredienteDto);

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

  async eliminar(id: any): Promise<IGenericResponse<ingredientes>> {
    const response: IGenericResponse<any> = {
      success: false,
    };

    try {
      await this.ingrediente.delete({ id });

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
