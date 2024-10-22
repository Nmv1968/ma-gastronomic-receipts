import { Module } from '@nestjs/common';
import { UsuarioController } from './usuario.controller';
import { UsuarioService } from './usuario.service';
import { TypeOrmModule } from '@nestjs/typeorm';
import { usuarios } from '../commons/entities/usuario.entity';
import { JwtModule } from '@nestjs/jwt';

@Module({
  imports: [
    JwtModule.register({
      global: true,
      secret: 'vQ54Jz2NV6MRK9v3ofZgA95W5E11eu',
      signOptions: { expiresIn: '24h' },
    }),
    TypeOrmModule.forFeature([usuarios]),
  ],
  controllers: [UsuarioController],
  providers: [UsuarioService],
})
export class UsuarioModule {}
