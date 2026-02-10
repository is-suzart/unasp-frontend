# ⚛️ UNASP Atomic ⚛️

Olá! Aqui vive o nosso **Design System**! 🎨
Construído com base na metodologia de **Atomic Design**, para interfaces consistentes e bonitas! ✨

![Bocchi Design](https://media.tenor.com/w9O8a-cMJQYAAAAC/bocchi-the-rock-hitori-gotoh.gif)

---

## 🧪 Estrutura Atômica

Dividimos nossos componentes em níveis de complexidade:

1.  **Átomos (Atoms)** 🔴: Elementos indivisíveis (Botões, Inputs, Ícones, Cores).
2.  **Moléculas (Molecules)** 🟠: Grupos de átomos (Campo de busca, Card simples).
3.  **Organismos (Organisms)** 🟡: Grupos complexos de moléculas (Header, Sidebar, Formulários completos).
4.  **Templates** 🟢: Estruturas de página (esqueletos).

---

## 📚 Tecnologias

-   **`signals_flutter`** 📡: Para componentes que precisam de reatividade interna.
-   **`google_fonts`**: Tipografia bonitona.

### Como usar

Adicione `atomic` nas dependências do seu projeto Flutter (`portal` ou `website`) e seja feliz!

```yaml
dependencies:
  atomic:
    path: ../atomic
```

---

*Pequenos componentes, grandes interfaces!* 🧩
