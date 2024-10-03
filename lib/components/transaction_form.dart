import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  const TransactionForm(this.onSubmit, {super.key});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime? _selectedDate = DateTime.now();

  _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0 || _selectedDate == null) {
      return;
    }

    widget.onSubmit(title, value, _selectedDate!);
  }

  _showDatePicker() {
    showDatePicker(
      context: context,
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
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
              controller: _titleController,
              onSubmitted: (_) => _submitForm,
              decoration: const InputDecoration(labelText: "Título"),
            ),
            TextField(
              controller: _valueController,
              keyboardType:
                  TextInputType.number, // Define o tipo numérico do teclado.
              onSubmitted: (_) => _submitForm,
              decoration: const InputDecoration(labelText: "Valor (R\$)"),
            ),
            SizedBox(
              height: 70,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      _selectedDate != null
                          ? DateFormat("dd/MM/y").format(_selectedDate!)
                          : "Nenhuma data selecionada!",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Theme.of(context).primaryColor,
                    ),
                    onPressed: _showDatePicker,
                    child: const Text(
                      "Selecionar Data",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.end, // Alinha botão à direita.
              children: <Widget>[
                ElevatedButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white, // Cor do texto do botão.
                    backgroundColor: Colors.deepPurple,
                  ),
                  onPressed: _submitForm,
                  child: const Text(
                    "Nova Transação",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ), // Texto do botão.
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
