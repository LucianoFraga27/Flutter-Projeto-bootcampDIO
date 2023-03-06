import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../repository/linguagens_repository.dart';
import '../repository/nivel_repository.dart';
import '../shared/widgets/text_label.dart';

class DadosCadastrais extends StatefulWidget {
  DadosCadastrais({super.key});

  @override
  State<DadosCadastrais> createState() => _DadosCadastraisState();
}

class _DadosCadastraisState extends State<DadosCadastrais> {
  TextEditingController nomeController =
      new TextEditingController(text: "luquinhas");
  TextEditingController dataNascimentoController =
      new TextEditingController(text: "");
  DateTime? dataNascimento;
  var niveis = [];
  var nivelRepository = new NivelRepository();
  var nivelSelecionado = '';

  var linguagens = [];
  var linguagensRepository = new LinguagensRepository();
  var linguagensSelecionada = [];

  double salario = 0;
  int tempoExperiencia = 0;

  bool salvando = false;

  @override
  void initState() {
    niveis = nivelRepository.retornaNiveis();
    linguagens =
        linguagensRepository.retornaLinguagens(); // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Meus Dados")), body: _body());
  }

  List<DropdownMenuItem<int>> returnItens(int qtd) {
    var items = <DropdownMenuItem<int>>[];
    for (var i = 0; i <= qtd; i++) {
      items.add(DropdownMenuItem(child: Text(i.toString()), value: i));
    }
    return items;
  }

  _body() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: salvando
          ? const Center(child: CircularProgressIndicator())
          : ListView(children: [
              TextLabel(texto: "Nome"),
              TextField(controller: nomeController),
              TextLabel(texto: "DataNascimento"),
              _showDatePicker(),
              _separador(),
              TextLabel(texto: "Nivel de Experiência"),
              _separador(),
              _radioList(),
              _separador(),
              TextLabel(texto: "Linguagens Preferidas"),
              _checkBoxListTile(),
              _separador(),
              _separador(),
              TextLabel(texto: "Tempo de experiência"),
              _separador(),
              DropdownButton(
                  value: tempoExperiencia,
                  isExpanded: true,
                  items: returnItens(50),
                  onChanged: (value) {
                    setState(() {
                      tempoExperiencia = int.parse(value.toString());
                    });
                  }),
              _separador(),
              TextLabel(
                  texto:
                      "Pretenção salárial. R\$ ${salario.round().toString()}"),
              _separador(),
              _slider(),
              _separador(),
              _salvar(),
            ]),
    );
  }

  TextField _showDatePicker() {
    return TextField(
      readOnly: true,
      controller: dataNascimentoController,
      onTap: () async {
        // capiturando a data
        var data = await showDatePicker(
            context: context,
            initialDate:
                DateTime(2002, 1, 1), // inicial data ao clicar no formulario
            firstDate: DateTime(1900, 5, 20),
            lastDate: DateTime(2024, 1, 1));
        if (data != null) {
          // print(data);
          dataNascimento = data;
          dataNascimentoController.text = data.toString();
        }
      },
    );
  }

  Slider _slider() {
    return Slider(
        min: 0,
        max: 10000,
        value: salario,
        onChanged: (double value) {
          // print(value);
          setState(() {
            salario = value;
          });
        });
  }

  Column _checkBoxListTile() {
    return Column(
      children: linguagens
          .map((ling) => CheckboxListTile(
              dense: false,
              title: Text(ling),
              value: linguagensSelecionada.contains(ling),
              onChanged: (v) {
                setState(() {
                  if (v == true) {
                    linguagensSelecionada.add(ling);
                  } else {
                    linguagensSelecionada.remove(ling);
                  }
                });
              }))
          .toList(),
    );
  }

  TextButton _salvar() {
    return TextButton(
        onPressed: () {
          if (nomeController.text.trim().length < 3) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("O nome deve ser preenchido")));
            return;
          }
          if (dataNascimento == null) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Data de nascimento inválida")));
            return;
          }
          if (nivelSelecionado.trim() == "") {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("O nível deve ser selecionado")));
            return;
          }

          if (linguagensSelecionada.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Pelo menos uma linguagem deve ser excolhida")));
            return;
          }

          if (tempoExperiencia == 0) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content:
                    Text("O tempo de experiência deve ser maior que zero")));
            return;
          }

          if (salario <= 0) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("O salário deve ser maior que 0")));
            return;
          }

          print("Dados salvos com sucesso!");

          setState(() {
            salvando == true;
          });

          Future.delayed(const Duration(seconds: 3), () {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Dados salvos com sucesso!")));
            setState(() {
              salvando = false;
            });
          });
        },
        child: const Text("Salvar"));
  }

  SizedBox _separador() {
    return SizedBox(
      height: 10,
    );
  }

  Column _radioList() {
    return Column(
      children: niveis
          .map((nivel) => RadioListTile(
              selected: nivelSelecionado == nivel.toString(),
              title: Text(nivel.toString()),
              value: nivel,
              groupValue: nivelSelecionado,
              onChanged: (value) {
                setState(() {
                  nivelSelecionado = value.toString();
                });
                // print(value);
              }))
          .toList(),
    );
  }
}
