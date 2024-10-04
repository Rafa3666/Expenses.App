import 'package:flutter/material.dart';
import 'package:expenses/transaction.dart';
import 'package:intl/intl.dart';

// Componente que exibe a lista de transações
class TransactionList extends StatelessWidget {
  final List<Transaction> transactions; // Lista de transações
  final void Function(String) onRemove; // Função para remover transações

  const TransactionList(this.transactions, this.onRemove, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 600, // Define a altura fixa da lista de transações
      child: transactions.isEmpty
          // Caso não haja transações, exibe uma mensagem e uma imagem
          ? Column(
              children: <Widget>[
                const SizedBox(height: 20),
                Text(
                  "Não há Transações Cadastradas!",
                  style:
                      Theme.of(context).textTheme.titleLarge, // Estilo do texto
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 200,
                  child: Image.asset(
                    'assets/images/waiting.png', // Imagem quando não há transações
                    fit: BoxFit.cover, // Ajusta a imagem ao container
                  ),
                ),
              ],
            )
          // Se houver transações, exibe uma lista rolável
          : ListView.builder(
              itemCount: transactions.length, // Número total de transações
              itemBuilder: (ctx, index) {
                final tr = transactions[index]; // Transação atual
                return Card(
                  elevation: 5, // Sombra do card
                  margin: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 5,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.purple[45], // Cor do círculo
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: FittedBox(
                          child: Text(
                              "R\$${tr.value}"), // Exibe o valor da transação
                        ),
                      ),
                    ),
                    title: Text(
                      tr.title,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium, // Estilo do título
                    ),
                    subtitle: Text(
                      DateFormat("d MMM y")
                          .format(tr.date), // Exibe a data formatada
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete), // Ícone de remoção
                      color: const Color.fromARGB(
                          255, 204, 23, 10), // Cor do ícone
                      onPressed: () =>
                          onRemove(tr.id), // Remove a transação ao clicar
                    ),
                  ),
                );
              },
            ),
    );
  }
}
