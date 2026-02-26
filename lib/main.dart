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
      setState(() {
        mostrarResultado = false;
      });
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

  InputDecoration _estiloCampoTexto(String rotulo, {String? prefixo}) {
    return InputDecoration(
      labelText: rotulo,
      prefixText: prefixo,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Colors.black12, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Colors.blueAccent, width: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Posto de Combustível"),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: alcoolController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: _estiloCampoTexto("Preço do Álcool", prefixo: "R\$ "),
              onChanged: (value) => calcular(),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: gasolinaController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: _estiloCampoTexto(
                "Preço da Gasolina",
                prefixo: "R\$ ",
              ),
              onChanged: (value) => calcular(),
            ),
            const SizedBox(height: 25),

            const Text(
              "Nível de Fidelidade",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              initialValue: nivelFidelidade,
              decoration: _estiloCampoTexto("Selecione seu nível"),
              icon: const Icon(
                Icons.arrow_drop_down_circle,
                color: Colors.blueAccent,
              ),
              items: niveisFidelidade.map((nivel) {
                return DropdownMenuItem<String>(
                  value: nivel["nome"],
                  child: Text(
                    "${nivel["nome"]} (${(nivel["desconto"] * 100).toInt()}% off)",
                    style: const TextStyle(fontSize: 16),
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

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: calcular,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 3,
              ),
              child: const Text(
                "Calcular Vantagem",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 30),

            if (mostrarResultado)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 15,
                      spreadRadius: 2,
                      offset: Offset(0, 5),
                    ),
                  ],
                  border: Border.all(
                    color: resultado == "Álcool" ? Colors.green : Colors.orange,
                    width: 2.5,
                  ),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.local_gas_station_rounded,
                      color: resultado == "Álcool"
                          ? Colors.green
                          : Colors.orange,
                      size: 70,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "Abasteça com $resultado",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: resultado == "Álcool"
                            ? Colors.green[700]
                            : Colors.orange[800],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Divider(color: Colors.black12, thickness: 1.5),
                    ),
                    const Text(
                      "Valor final com desconto:",
                      style: TextStyle(fontSize: 15, color: Colors.black54),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "R\$ ${valorFinal.toStringAsFixed(2)} / litro",
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
