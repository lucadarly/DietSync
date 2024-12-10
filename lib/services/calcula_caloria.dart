import '../models/refeicao.dart';

class CalorieCalculator {
  static double calculateTotalCalories(List<Refeicao> refeicoes) {
    double totalCalories = 0;
    for (var refeicao in refeicoes) {
      totalCalories += refeicao.getTotalCalories();
    }
    return totalCalories;
  }
}
