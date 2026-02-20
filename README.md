# ⛽ Calculadora Flex Pro - Flutter

Aplicativo simples desenvolvido em Flutter para auxiliar o usuário a decidir qual combustível compensa mais: **Álcool ou Gasolina**, considerando também descontos baseados em um programa de fidelidade.

---

## 📌 📱 Funcionalidades

- Entrada do preço do **Álcool**
- Entrada do preço da **Gasolina**
- Seleção do **Nível de Fidelidade**
  - Básico (sem desconto)
  - Prata (2% de desconto)
  - Ouro (5% de desconto)
- Cálculo automático baseado na regra dos **70%**
- Exibição do combustível recomendado
- Aplicação automática do desconto
- Ícone e cor dinâmica conforme combustível escolhido

---

## 🧮 🧠 Regra de Negócio

O Álcool compensa quando:

Preço do Álcool ≤ 70% do Preço da Gasolina

Caso contrário, a Gasolina é recomendada.

Após a escolha, o sistema aplica o desconto conforme o nível de fidelidade.

---

## 🛠️ Tecnologias Utilizadas

- Flutter
- Dart
- Material Design
- VS Code

---

## 🚀 Como Executar o Projeto

1. Clone o repositório:
```cmd
git clone <url-do-repositorio>
```
   
3. Acesse a pasta do projeto:
```cmd
cd posto_combustivel
```

4. Instale as dependências:
```cmd
flutter pub get
```

5. Execute o projeto:
```cmd
flutter run
```

---

## 📷 Interface

O aplicativo possui:

- Campos para inserção dos preços
- Dropdown para seleção do nível de fidelidade
- Botão para cálculo
- Resultado com ícone e valor final com desconto aplicado

---

## 👨‍💻 Autor

Desenvolvido como atividade prática da disciplina de Desenvolvimento Mobile.
