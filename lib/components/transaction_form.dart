import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double) onSubmit;

  TransactionForm(this.onSubmit);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final titleController = TextEditingController();

  final valueController = TextEditingController();

  _submitForm() {
    final title = titleController.text;
    final value = double.tryParse(valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0) {
      return;
    }

    widget.onSubmit(title, value);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5, // Define a elevação do Card.
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: 8.0, horizontal: 20), // Espaçamento interno do Card.
        child: Column(
          children: <Widget>[
            TextField(
              controller: titleController,
              onSubmitted: (_) => _submitForm,
              decoration: const InputDecoration(labelText: "Título"),
            ),
            TextField(
              controller: valueController,
              keyboardType:
                  TextInputType.number, // Define o tipo numérico do teclado.
              onSubmitted: (_) => _submitForm,
              decoration: const InputDecoration(labelText: "Valor (R\$)"),
            ),
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.end, // Alinha botão à direita.
              children: <Widget>[
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.purple, // Cor do texto do botão.
                  ),
                  onPressed: _submitForm,
                  child: const Text("Nova Transação"), // Texto do botão.
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
