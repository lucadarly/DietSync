import 'alimento.dart';

class Refeicao {
  final String name;
  final List<Alimento> alimentos;

  Refeicao({required this.name, required this.alimentos});

  // Calcula as calorias totais da refeição
  double getTotalCalories() {
    double totalCalories = 0;
    for (var item in alimentos) {
      totalCalories += item.getTotalCalories();
    }
    return totalCalories;
  }
}
