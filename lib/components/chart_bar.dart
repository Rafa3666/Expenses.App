import 'package:flutter/material.dart';

// Componente que representa uma barra no gráfico
class ChartBar extends StatelessWidget {
  // Parâmetros recebidos pela barra
  final String label; // Rótulo exibido abaixo da barra
  final double value; // Valor representado pela barra
  final double percentage; // Percentual da barra em relação ao valor total

  // Construtor que inicializa os valores da barra
  const ChartBar({
    super.key,
    required this.label,
    required this.value,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // Exibe o valor numérico da barra, ajustado para caber no espaço
        SizedBox(
          height: 20,
          child: FittedBox(
            child: Text(
                value.toStringAsFixed(2)), // Exibe o valor com 2 casas decimais
          ),
        ),
        const SizedBox(height: 5), // Espaçamento entre o valor e a barra
        SizedBox(
          height: 60, // Altura fixa da barra
          width: 10, // Largura fixa da barra
          child: Stack(
            alignment:
                Alignment.bottomCenter, // Alinha a barra preenchida no fundo
            children: <Widget>[
              // Caixa que representa a barra vazia
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.green, // Cor da borda da barra
                    width: 1,
                  ),
                  color: const Color.fromRGBO(
                      220, 220, 220, 1), // Cor de fundo da barra
                  borderRadius: BorderRadius.circular(5), // Bordas arredondadas
                ),
              ),
              // Parte preenchida da barra, de acordo com o percentual
              FractionallySizedBox(
                heightFactor:
                    percentage.clamp(0, 1), // Limita o percentual entre 0 e 1
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.deepPurple, // Cor da parte preenchida
                    borderRadius:
                        BorderRadius.circular(5), // Bordas arredondadas
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 5), // Espaçamento entre a barra e o rótulo
        Text(label), // Exibe o rótulo abaixo da barra
      ],
    );
  }
}
