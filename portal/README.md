# 🎀 UNASP Portal 🎀

Bem-vindo(a) ao **Portal**, a aplicação principal onde os usuários interagem com nosso sistema! (´｡• ᵕ •｡`)
Feito com Flutter para rodar liso em qualquer lugar! 🦋

![Bocchi Happy](https://media.tenor.com/t1k5YfFqK8EAAAAC/bocchi-the-rock-hitori-gotoh.gif)

---

## 🏗️ Arquitetura: MVU (Model-View-Update)

Aqui seguimos uma arquitetura reativa e previsível baseada no **Elm Architecture**! 🔄

-   **Model**: O estado único da verdade. 📁
-   **View**: A interface que desenha o estado na tela. 🎨
-   **Update**: Funções puras que atualizam o estado. ⚡
-   **Side-Effects**: Chamadas de API e logicas que "sujam" a pureza (ficam isolados!). 🌊

### 📚 Principais Bibliotecas
-   **`signals_flutter`** 📡: Gerenciamento de estado reativo super rápido!
-   **`atomic`**: Nossa biblioteca de componentes de design (veja `../atomic`). ⚛️
-   **`entities`**: Nossas regras de negócio compartilhadas (veja `../entities`). 📦
-   **`get_it`**: Injeção de dependência para manter tudo desacoplado. 💉

---

## 🚀 Como Rodar

Basta rodar o comando padrão do Flutter:

```bash
flutter run
```

Se precisar gerar arquivos (como JSON serializable):
```bash
flutter pub run build_runner build
```

---

*Vamos codar algo incrível!* 🎸
