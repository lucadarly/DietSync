import 'package:flutter/material.dart';
import '../models/refeicao.dart';
import '../models/alimento.dart';
import '../services/calcula_caloria.dart';

class RefeicaoPlanScreen extends StatefulWidget {
  @override
  _RefeicaoPlanScreenState createState() => _RefeicaoPlanScreenState();
}

class _RefeicaoPlanScreenState extends State<RefeicaoPlanScreen> {
  final List<Refeicao> refeicoes = [];
  final TextEditingController _numRefeicoesController = TextEditingController();
  final TextEditingController _alimentoNameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _caloriesController = TextEditingController();
  int currentRefeicaoIndex = 0; // Indica a refeição que está sendo editada

  void _createRefeicoes() {
    int numRefeicoes = int.tryParse(_numRefeicoesController.text) ?? 0;
    if (numRefeicoes > 0) {
      setState(() {
        refeicoes.clear();
        for (int i = 0; i < numRefeicoes; i++) {
          refeicoes.add(Refeicao(name: 'Refeição ${i + 1}', alimentos: []));
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Digite um número válido de refeições.')),
      );
    }
  }

  void _addAlimento() {
    final String name = _alimentoNameController.text;
    final double quantity = double.tryParse(_quantityController.text) ?? 0;
    final double caloriesPerUnit = double.tryParse(_caloriesController.text) ?? 0;

    if (name.isNotEmpty && quantity > 0 && caloriesPerUnit > 0) {
      setState(() {
        Alimento newItem = Alimento(
          name: name,
          quantity: quantity,
          caloriesPerUnit: caloriesPerUnit,
        );
        refeicoes[currentRefeicaoIndex].alimentos.add(newItem);
      });

      _alimentoNameController.clear();
      _quantityController.clear();
      _caloriesController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Preencha todos os campos corretamente.')),
      );
    }
  }

  void _switchToRefeicao(int index) {
    setState(() {
      currentRefeicaoIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double totalCalories = CalorieCalculator.calculateTotalCalories(refeicoes);

    return Scaffold(
      appBar: AppBar(
        title: Text('Plano Alimentar'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _numRefeicoesController,
              decoration: InputDecoration(labelText: 'Número de Refeições'),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
              onPressed: _createRefeicoes,
              child: Text('Criar Refeições'),
            ),
            if (refeicoes.isNotEmpty) ...[
              Text(
                'Refeição Atual: ${refeicoes[currentRefeicaoIndex].name}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: _alimentoNameController,
                decoration: InputDecoration(labelText: 'Nome do Alimento'),
              ),
              TextField(
                controller: _quantityController,
                decoration: InputDecoration(labelText: 'Quantidade (g ou unidade)'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _caloriesController,
                decoration: InputDecoration(labelText: 'Calorias por 100g ou unidade'),
                keyboardType: TextInputType.number,
              ),
              ElevatedButton(
                onPressed: _addAlimento,
                child: Text('Adicionar Alimento'),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: refeicoes.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(refeicoes[index].name),
                      subtitle: Text(
                        'Calorias: ${refeicoes[index].getTotalCalories().toStringAsFixed(2)} kcal',
                      ),
                      trailing: ElevatedButton(
                        onPressed: () => _switchToRefeicao(index),
                        child: Text('Editar'),
                      ),
                    );
                  },
                ),
              ),
            ],
            Text(
              'Total de Calorias de Todas as Refeições: ${totalCalories.toStringAsFixed(2)} kcal',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
