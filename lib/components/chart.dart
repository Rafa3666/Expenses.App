import 'package:expenses/components/chart_bar.dart';
import 'package:expenses/transaction.dart'; // Importa o modelo de transação
import 'package:flutter/material.dart'; // Importa os widgets do Flutter
import 'package:intl/intl.dart'; // Importa a biblioteca para formatação de datas

class Chart extends StatelessWidget {
  final List<Transaction>
      recentTransactions; // Declara uma lista de transações recentes, que será passada ao construir o widget

  const Chart(this.recentTransactions,
      {super.key}); // Construtor que inicializa o widget Chart com a lista de transações

  // Getter que agrupa as transações por dia da semana nos últimos 7 dias
  List<Map<String, Object>> get groupedTransactions {
    // Gera uma lista de 7 elementos (um para cada dia da semana, retrocedendo a partir de hoje)
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(
            days:
                index), // Calcula a data do dia correspondente (a partir de hoje)
      );

      double totalSum =
          0.0; // Inicializa a soma total de transações para esse dia

      // Itera sobre as transações recentes para somar as transações do mesmo dia
      for (var i = 0; i < recentTransactions.length; i++) {
        bool sameDay = recentTransactions[i].date.day ==
            weekDay.day; // Verifica se é o mesmo dia
        bool sameMonth = recentTransactions[i].date.month ==
            weekDay.month; // Verifica se é o mesmo mês
        bool sameYear = recentTransactions[i].date.year ==
            weekDay.year; // Verifica se é o mesmo ano

        if (sameDay && sameMonth && sameYear) {
          totalSum += recentTransactions[i]
              .value; // Se for o mesmo dia, adiciona o valor da transação à soma
        }
      }

      // Retorna um mapa contendo o dia da semana (inicial) e o valor total das transações desse dia
      return {
        "day": DateFormat.E().format(
            weekDay)[0], // Formata o dia da semana (inicial da string do dia)
        "value": totalSum, // Valor total de transações do dia
      };
    })
        .reversed
        .toList(); // Deixando o dia mais atual do lado direito dos demais.
  }

  double get weekTotalValue {
    return groupedTransactions.fold(0.0, (sum, tr) {
      return sum + (tr["value"] as double);
    });
  }

  // Método responsável por construir o widget visual do Chart
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6, // Define a elevação (sombra) do Card
      margin: const EdgeInsets.all(20), // Define a margem em torno do Card
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactions.map((tr) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                label: tr["day"] as String,
                value: tr["value"] as double,
                percentage: weekTotalValue == 0
                    ? 0
                    : (tr["value"] as double) / weekTotalValue,
              ),
            );
          }).toList(), // Uma linha vazia (sem widgets no momento), onde os gráficos seriam inseridos
        ),
      ),
    );
  }
}
