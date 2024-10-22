import * as bcrypt from 'bcrypt';
import { JwtService } from '@nestjs/jwt';
import { HttpException, HttpStatus, Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { usuarios } from '../commons/entities/usuario.entity';
import {
  Between,
  ILike,
  LessThanOrEqual,
  MoreThanOrEqual,
  Repository,
} from 'typeorm';
import { IGenericResponse } from 'src/commons/utils/general';
import { CrearUsuarioDto } from './dto/crear-usuario.dto';
import { AuthService } from 'src/commons/security/auth.service';

@Injectable()
export class UsuarioService {
  constructor(
    @InjectRepository(usuarios)
    private usuario: Repository<usuarios>,
    private jwtService: JwtService,
    private authService: AuthService,
  ) {}

  async iniciarSesion(params: any): Promise<IGenericResponse<any>> {
    const response: IGenericResponse<any> = {
      success: true,
    };
    const { username, password } = params;
    console.log(params);
    const user: CrearUsuarioDto = await this.usuario.findOneBy({
      username,
    });

    console.log(user);
    if (!user)
      throw new HttpException(`Usuario no encontrado`, HttpStatus.NOT_FOUND);

    if (!(await bcrypt.compare(password, user.password)))
      throw new HttpException(`Contraseña invalida`, HttpStatus.BAD_REQUEST);

    const accessToken = await this.jwtService.signAsync({
      iss: 'RECETAS - AUTH',
      sub: 'RECETAS - sub',
      aud: 'RECETAS',
      kid: '-',
      type: `authorization`,
      provider: `NAIM`,
      user: {
        id: user.id,
        username: user.username,
        full_name: user.nombre_completo,
        profile_id: user.id_perfil,
      },
    });

    if (!accessToken)
      throw new HttpException(
        `No se pudo generar la sesión`,
        HttpStatus.BAD_REQUEST,
      );

    response.success = true;
    response.token = accessToken;
    response.data = {
      id: user.id,
      username: user.username,
      full_name: user.nombre_completo,
      profile_id: user.id_perfil,
    };
    response.message = 'Ingreso exitoso';

    return response;
  }

  async crear(
    CrearUsuarioDto: CrearUsuarioDto,
  ): Promise<IGenericResponse<usuarios>> {
    const response: IGenericResponse<any> = {
      success: false,
    };

    try {
      const newUser = this.usuario.create(CrearUsuarioDto);
      const saltRounds = 10;
      newUser.password = await bcrypt.hash(newUser.password, saltRounds);
      await this.usuario.save(newUser);

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
}
