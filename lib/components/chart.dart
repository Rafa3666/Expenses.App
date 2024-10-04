import 'package:expenses/components/chart_bar.dart';
import 'package:expenses/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Widget que exibe o gráfico de barras para representar as transações recentes
class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions; // Lista de transações recentes

  // Construtor que inicializa o widget Chart
  const Chart(this.recentTransactions, {super.key});

  // Agrupa as transações por dia da semana, considerando os últimos 7 dias
  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0.0;

      // Soma o valor das transações que ocorreram no mesmo dia da semana
      for (var i = 0; i < recentTransactions.length; i++) {
        bool sameDay = recentTransactions[i].date.day == weekDay.day;
        bool sameMonth = recentTransactions[i].date.month == weekDay.month;
        bool sameYear = recentTransactions[i].date.year == weekDay.year;

        if (sameDay && sameMonth && sameYear) {
          totalSum += recentTransactions[i].value;
        }
      }

      // Retorna o dia da semana e o valor total de transações desse dia
      return {
        "day": DateFormat.E().format(weekDay)[0], // Inicial do dia da semana
        "value": totalSum, // Soma total das transações do dia
      };
    })
        .reversed
        .toList(); // Reverte a lista para exibir o dia mais recente por último
  }

  // Soma total das transações da semana
  double get weekTotalValue {
    return groupedTransactions.fold(0.0, (sum, tr) {
      return sum + (tr["value"] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6, // Sombra do card
      margin: const EdgeInsets.all(20), // Margem externa do card
      child: Padding(
        padding: const EdgeInsets.all(10), // Espaçamento interno do card
        child: Row(
          mainAxisAlignment: MainAxisAlignment
              .spaceAround, // Distribui as barras uniformemente
          children: groupedTransactions.map((tr) {
            return Flexible(
              fit: FlexFit.tight, // Cada barra ocupa o mesmo espaço disponível
              child: ChartBar(
                label: tr["day"] as String, // Dia da semana
                value:
                    tr["value"] as double, // Valor total de transações do dia
                percentage: weekTotalValue == 0
                    ? 0
                    : (tr["value"] as double) /
                        weekTotalValue, // Percentual da barra
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
