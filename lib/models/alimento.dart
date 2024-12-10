class Alimento {
  final String name;
  final double quantity; // Quantidade em gramas ou unidade (ex: 100g, 1 unidade)
  final double caloriesPerUnit; // Calorias por 100g ou unidade

  Alimento({
    required this.name,
    required this.quantity,
    required this.caloriesPerUnit,
  });

  // Calcula as calorias totais para esse item
  double getTotalCalories() {
    return (quantity / 100) * caloriesPerUnit; // Se for em gramas
  }
}
