import { Test, TestingModule } from '@nestjs/testing';
import { IngredienteService } from './ingrediente.service';

describe('IngredienteService', () => {
  let service: IngredienteService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [IngredienteService],
    }).compile();

    service = module.get<IngredienteService>(IngredienteService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });
});
