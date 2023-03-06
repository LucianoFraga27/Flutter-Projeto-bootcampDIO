import 'dart:math';

class GeradorNumeroAleatorioService {
  static int geraNumeroAleatorio(int max) {
    Random random = Random();
    return random.nextInt(max);
  }
}
