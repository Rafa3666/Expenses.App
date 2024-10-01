import 'package:expenses/components/transaction_form.dart'; // Importa o formulário para registrar novas despesas.
import 'package:flutter/material.dart'; // Importa as ferramentas do Flutter para criar a interface.
import 'dart:math'; // Importa funções matemáticas, como para gerar números aleatórios.
import 'components/transaction_list.dart'; // Importa a lista que mostra todas as transações.
import 'transaction.dart'; // Importa a classe que representa uma transação.

void main() => runApp(const ExpensesApp()); // Inicia o aplicativo de despesas.

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({super.key}); // Construtor do aplicativo.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(), // Define a tela inicial do aplicativo.
      theme: ThemeData(
        fontFamily: "Quicksand", // Fonte padrão do aplicativo.
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
              fontFamily: "OpenSans", // Fonte do título da barra de app.
              fontSize: 20, // Tamanho da fonte do título.
              fontWeight: FontWeight.bold), // Estilo da fonte do título.
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() =>
      _MyHomePageState(); // Cria o estado da tela inicial.

  // Lista de transações já registradas.
  final List<Transaction> _transactions = [
    // Transaction(
    //   id: "t1", // ID único para a primeira transação.
    //   title: "Novo Tênis de Corrida", // Nome da primeira despesa.
    //   value: 310.76, // Valor da primeira despesa.
    //   date: DateTime.now(), // Data da primeira despesa.
    // ),
    // Transaction(
    //   id: "t2", // ID único para a segunda transação.
    //   title: "Conta de Luz", // Nome da segunda despesa.
    //   value: 211.20, // Valor da segunda despesa.
    //   date: DateTime.now(), // Data da segunda despesa.
    // ),
  ];

  // Função para acessar a lista de transações.
  List<Transaction> get transactions =>
      _transactions; // Retorna a lista de transações.
}

class _MyHomePageState extends State<MyHomePage> {
  // Função para adicionar uma nova despesa.
  void _addTransaction(String title, double value) {
    final newTransaction = Transaction(
      id: Random()
          .nextDouble()
          .toString(), // Cria um ID aleatório para a nova despesa.
      title: title, // Nome da nova despesa.
      value: value, // Valor da nova despesa.
      date: DateTime.now(), // Data da nova despesa.
    );
    setState(() {
      widget._transactions.add(
          newTransaction); // Adiciona a nova despesa à lista e atualiza a tela.
    });

    Navigator.of(context).pop(); // Fecha o modal após adicionar a despesa.
  }

  // Função para abrir o formulário de nova despesa.
  void _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context, // Passa o contexto atual.
      builder: (_) {
        return TransactionForm(
            _addTransaction); // Passa a função que adiciona a despesa para o formulário.
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Despesas Pessoais", // Título do aplicativo.
            style: TextStyle(
              color: Colors.white, // Cor do texto do título.
            )),
        actions: <Widget>[
          IconButton(
            onPressed: () => _openTransactionFormModal(
                context), // Abre o formulário ao clicar no botão.
            icon: const Icon(Icons.add), // Ícone de adicionar.
            color: Colors.white, // Cor do ícone.
          ),
        ],
        backgroundColor: Colors.deepPurple, // Cor de fundo da barra de app.
      ),
      body: SingleChildScrollView(
        // Permite rolar a tela se o conteúdo for maior que a tela.
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.stretch, // Alinha todos os widgets à esquerda.
          children: <Widget>[
            Container(
              width:
                  double.infinity, // O container ocupa toda a largura da tela.
              child: const Card(
                color: Colors.blue, // Cor de fundo do card.
                elevation: 5, // Sombra do card.
                child: Text("Gráfico"), // Texto que aparece dentro do card.
              ),
            ),
            TransactionList(widget
                .transactions), // Exibe a lista de transações registradas.
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        onPressed: () => _openTransactionFormModal(
            context), // Abre o formulário ao clicar no botão flutuante.
        backgroundColor: Colors.deepPurple, // Cor do botão flutuante.
        child: const Icon(Icons.add), // Ícone de adição do botão flutuante.
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation
          .centerFloat, // Posição do botão flutuante na tela.
    );
  }
}
