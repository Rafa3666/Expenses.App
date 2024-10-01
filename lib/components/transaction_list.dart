import 'package:flutter/material.dart'; // Importa as ferramentas do Flutter para criar a interface.
import 'package:expenses/transaction.dart'; // Importa a classe que representa uma transação.
import 'package:intl/intl.dart'; // Importa funções para formatação de data.

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions; // Lista de transações a serem exibidas.

  TransactionList(
      this.transactions); // Construtor que recebe a lista de transações.

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400, // Altura fixa do container que vai mostrar as transações.
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
                Container(
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
                  // Cria um cartão para cada transação.
                  child: Row(
                    // Organiza os elementos em uma linha.
                    children: <Widget>[
                      // Container que exibe o valor da transação formatado.
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 10), // Margens para espaçamento.
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.purple,
                              width: 2), // Borda roxa ao redor do valor.
                        ),
                        padding: const EdgeInsets.all(
                            10), // Espaçamento interno do container.
                        child: Text(
                          "R\$ ${tr.value.toStringAsFixed(2)}", // Mostra o valor formatado com duas casas decimais.
                          style: const TextStyle(
                            fontWeight:
                                FontWeight.bold, // Define o texto em negrito.
                            fontSize: 20, // Tamanho da fonte do valor.
                            color: Colors.purple, // Cor do texto do valor.
                          ),
                        ),
                      ),
                      // Coluna que mostra o título e a data da transação.
                      Column(
                        crossAxisAlignment: CrossAxisAlignment
                            .start, // Alinha os textos à esquerda.
                        children: <Widget>[
                          Text(
                            tr.title, // Exibe o título da transação.
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium, // Usa o estilo de texto definido pelo tema do app.
                          ),
                          Text(
                            DateFormat('d MMM y').format(tr
                                .date), // Formata a data para o padrão 'dia mês ano'.
                            style: const TextStyle(
                                color: Colors.grey), // Cor cinza para a data.
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
