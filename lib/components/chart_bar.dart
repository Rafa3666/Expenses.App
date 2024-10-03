import 'package:flutter/material.dart';

// Define a classe ChartBar, que estende StatelessWidget
class ChartBar extends StatelessWidget {
  // Declaração dos parâmetros que a classe receberá
  final String
      label; // Rótulo (label) que será exibido na parte inferior da barra
  final double
      value; // Valor total que a barra representa (ex: valor total de despesas)
  final double
      percentage; // Percentual que indica a altura da barra em relação a um valor total

  // Construtor da classe ChartBar, que inicializa os parâmetros
  const ChartBar({
    super.key,
    required this.label, // Rótulo é obrigatório
    required this.value, // Valor é obrigatório
    required this.percentage, // Percentual é obrigatório
  });

  // Método que constrói a interface do usuário para o ChartBar
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // Exibe o valor formatado em Reais (R$) com duas casas decimais
        SizedBox(
          height: 20,
          child: FittedBox(
            child: Text(value.toStringAsFixed(2)),
          ),
        ),
        const SizedBox(
            height: 5), // Espaçamento vertical entre o valor e a barra
        SizedBox(
          height: 60, // Altura fixa da barra
          width: 10, // Largura fixa da barra
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.green,
                    width: 1,
                  ),
                  color: const Color.fromRGBO(220, 220, 220, 1),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              FractionallySizedBox(
                heightFactor: percentage.clamp(0, 1),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ],
          ), // Aqui pode-se adicionar um widget (como uma cor) para representar a barra
        ),
        const SizedBox(
            height: 5), // Espaçamento vertical entre a barra e o rótulo
        Text(label) // Exibe o rótulo abaixo da barra
      ],
    );
  }
}
