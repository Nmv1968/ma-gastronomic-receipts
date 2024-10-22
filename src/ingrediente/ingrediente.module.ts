import { Module } from '@nestjs/common';
import { IngredienteService } from './ingrediente.service';
import { IngredienteController } from './ingrediente.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { ingredientes } from 'src/commons/entities/ingrediente.entity';

@Module({
  imports: [TypeOrmModule.forFeature([ingredientes])],
  providers: [IngredienteService],
  controllers: [IngredienteController],
})
export class IngredienteModule {}
