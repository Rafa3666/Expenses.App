import 'package:expenses/components/transaction_form.dart'; // Importa o formulário de transação.
import 'package:flutter/material.dart'; // Importa o pacote Flutter para construção de UI.
import 'dart:math'; // Importa a biblioteca de matemática para geração de números aleatórios.
import 'components/transaction_list.dart'; // Importa a lista de transações.
import 'transaction.dart'; // Importa a classe Transaction.

void main() => runApp(const ExpensesApp()); // Inicia o aplicativo.

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({super.key}); // Construtor principal.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: MyHomePage()); // Define a página inicial do aplicativo.
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() =>
      _MyHomePageState(); // Cria o estado associado à MyHomePage.

  // Lista inicial de transações.
  final List<Transaction> _transactions = [
    /* Transaction(
      id: "t1", // ID da transação.
      title: "Novo Tênis de Corrida", // Título da transação.
      value: 310.76, // Valor da transação.
      date: DateTime.now(), // Data da transação.
    ),
    Transaction(
      id: "t2", // ID da transação.
      title: "Conta de Luz", // Título da transação.
      value: 211.20, // Valor da transação.
      date: DateTime.now(), // Data da transação.
    ), */
  ];

  // Método para acessar a lista de transações
  List<Transaction> get transactions =>
      _transactions; // Getter para as transações.
}

class _MyHomePageState extends State<MyHomePage> {
  // Função para adicionar uma nova transação.
  void _addTransaction(String title, double value) {
    final newTransaction = Transaction(
      id: Random()
          .nextDouble()
          .toString(), // Gera um ID aleatório para a nova transação.
      title: title, // Título da nova transação.
      value: value, // Valor da nova transação.
      date: DateTime.now(), // Data da nova transação.
    );
    setState(() {
      widget._transactions.add(
          newTransaction); // Adiciona a nova transação à lista e atualiza a UI.
    });

    Navigator.of(context).pop();
  }

  // Função para abrir o modal do formulário de transação.
  void _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context, // Contexto atual.
      builder: (_) {
        return TransactionForm(
            _addTransaction); // Passa a função de adição de transação para o formulário.
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Despesas Pessoais", // Título da barra de aplicativo.
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold), // Estilo do título.
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () => _openTransactionFormModal(
                context), // Abre o modal ao pressionar o botão.
            icon: const Icon(Icons.add), // Ícone de adição.
            color: Colors.white, // Cor do ícone.
          ),
        ],
        backgroundColor: Colors.deepPurple, // Cor de fundo da AppBar.
      ),
      body: SingleChildScrollView(
        // SingleChildScrollView permite rolar a página quando o conteúdo é maior que a tela.
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.stretch, // Alinha widgets à esquerda.
          children: <Widget>[
            Container(
              width: double
                  .infinity, // O container ocupa toda a largura disponível.
              child: const Card(
                color: Colors.blue, // Cor de fundo do Card.
                elevation: 5, // Sombra do Card.
                child: Text("Gráfico"), // Texto dentro do Card.
              ),
            ),
            TransactionList(
                widget.transactions), // Exibe a lista de transações.
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        onPressed: () => _openTransactionFormModal(
            context), // Abre o modal ao pressionar o botão flutuante.
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.add), // Ícone de adição do botão flutuante.
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation
          .centerFloat, // Localização do botão flutuante.
    );
  }
}
