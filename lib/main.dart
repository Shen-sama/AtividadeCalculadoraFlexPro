import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: CalculadoraFlexPro()));

class CalculadoraFlexPro extends StatelessWidget {
  const CalculadoraFlexPro({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CombustivelPage(),
    );
  }
}

class CombustivelPage extends StatefulWidget {
  const CombustivelPage({super.key});

  @override
  State<CombustivelPage> createState() => _CombustivelPageState();
}

class _CombustivelPageState extends State<CombustivelPage> {
  final TextEditingController alcoolController = TextEditingController();
  final TextEditingController gasolinaController = TextEditingController();

  String nivelFidelidade = "Básico";
  String resultado = "";
  double valorFinal = 0;
  bool mostrarResultado = false;

  final List<Map<String, dynamic>> niveisFidelidade = [
    {"nome": "Básico", "desconto": 0.0},
    {"nome": "Prata", "desconto": 0.02},
    {"nome": "Ouro", "desconto": 0.05},
  ];

  void calcular() {
    String alcoolTexto = alcoolController.text.replaceAll(',', '.');
    String gasolinaTexto = gasolinaController.text.replaceAll(',', '.');

    double alcool = double.tryParse(alcoolTexto) ?? 0;
    double gasolina = double.tryParse(gasolinaTexto) ?? 0;

    if (alcool == 0 || gasolina == 0) {
      return;
    }

    bool alcoolCompensa = alcool <= gasolina * 0.7;

    String combustivelEscolhido = alcoolCompensa ? "Álcool" : "Gasolina";

    double precoBase = alcoolCompensa ? alcool : gasolina;

    double desconto = niveisFidelidade.firstWhere(
      (nivel) => nivel["nome"] == nivelFidelidade,
    )["desconto"];

    valorFinal = precoBase - (precoBase * desconto);

    setState(() {
      resultado = combustivelEscolhido;
      mostrarResultado = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Posto de Combustível"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: alcoolController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Preço do Álcool"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: gasolinaController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Preço da Gasolina"),
            ),
            const SizedBox(height: 20),

            const Text(
              "Nível de Fidelidade",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              initialValue: nivelFidelidade,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 12),
              ),
              items: niveisFidelidade.map((nivel) {
                return DropdownMenuItem<String>(
                  value: nivel["nome"],
                  child: Text(
                    "${nivel["nome"]} (${(nivel["desconto"] * 100).toInt()}% de desconto)",
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  nivelFidelidade = value!;
                });
                calcular();
              },
            ),

            const SizedBox(height: 20),

            ElevatedButton(onPressed: calcular, child: const Text("Calcular")),

            const SizedBox(height: 30),

            if (mostrarResultado)
              Column(
                children: [
                  Icon(
                    resultado == "Álcool" ? Icons.oil_barrel : Icons.oil_barrel,
                    color: resultado == "Álcool" ? Colors.green : Colors.orange,
                    size: 60,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Melhor opção: $resultado",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Valor final com desconto: R\$ ${valorFinal.toStringAsFixed(2)}",
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
