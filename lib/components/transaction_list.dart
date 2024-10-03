import 'package:flutter/material.dart'; // Importa as ferramentas do Flutter para criar a interface.
import 'package:expenses/transaction.dart';
import 'package:intl/intl.dart'; // Importa a classe que representa uma transação.

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions; // Lista de transações a serem exibidas.
  final void Function(String) onRemove;

  const TransactionList(this.transactions, this.onRemove, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 600, // Altura fixa do container que vai mostrar as transações.
        // Cria uma lista rolável de transações.
        child: transactions.isEmpty
            ? Column(
                children: <Widget>[
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Não há Transações Cadastradas!",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 200,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              )
            : ListView.builder(
                itemCount:
                    transactions.length, // Número total de transações na lista.
                itemBuilder: (ctx, index) {
                  final tr =
                      transactions[index]; // Pega a transação atual da lista.
                  return Card(
                    elevation: 5,
                    margin: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 5,
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.purple[45],
                        radius: 30,
                        child: Padding(
                          padding: const EdgeInsets.all(6),
                          child: FittedBox(
                            child: Text("R\$${tr.value}"),
                          ),
                        ),
                      ),
                      title: Text(
                        tr.title,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      subtitle: Text(
                        DateFormat("d MMM y").format(tr.date),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        color: const Color.fromARGB(255, 204, 23, 10),
                        onPressed: () => onRemove(tr.id),
                      ),
                    ),
                  );
                }));
  }
}
