import { Module } from '@nestjs/common';
import { RecetaService } from './receta.service';
import { RecetaController } from './receta.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { recetas } from 'src/commons/entities/receta.entity';
import { ingrediente_receta } from 'src/commons/entities/ingrediente-receta.entity';
import { procedimiento_receta } from 'src/commons/entities/procedimiento-receta.entity';

@Module({
  imports: [
    TypeOrmModule.forFeature([
      recetas,
      ingrediente_receta,
      procedimiento_receta,
    ]),
  ],
  providers: [RecetaService],
  controllers: [RecetaController],
})
export class RecetaModule {}
