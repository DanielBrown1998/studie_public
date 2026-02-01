# 🎨 Design System - Studie App

## Figma
**Projeto:** [Mobile Study Planner App](https://www.figma.com/design/AdurN2kj0SCRnQQ9pUqmrE/Mobile-Study-Planner-App)

---

## Mapeamento: Design → Código

| Tela (Figma) | Arquivo Flutter | Status |
|--------------|-----------------|--------|
| Home | `lib/features/presenter/pages/home/home_page.dart` | ✅ Implementado |
| Trail/Trilha | `lib/features/presenter/pages/trail/trail_page.dart` | 🔄 Em andamento |
| Timer | `lib/features/presenter/pages/timer/timer_page.dart` | ⏳ Pendente |
| Agenda | `lib/features/presenter/pages/agenda/agenda_page.dart` | ⏳ Pendente |
| Chat AI | `lib/features/presenter/pages/chat/chat_page.dart` | ⏳ Pendente |
| Profile | `lib/features/presenter/pages/profile/profile_page.dart` | ⏳ Pendente |
| Login | `lib/features/presenter/pages/login/login_page.dart` | ⏳ Pendente |

---

## Componentes Reutilizáveis

| Componente (Figma) | Widget Flutter | Arquivo |
|--------------------|----------------|---------|
| Primary Button | `PrimaryButton` | `components/primary_button.dart` |
| Discipline Card | `DisciplineHomeWidget` | `pages/home/widgets/discipline_home_widget.dart` |
| Discipline Data | `DisciplineDataWidget` | `components/discipline_data_widget.dart` |
| Header | `HeaderHome` | `pages/home/widgets/header_home.dart` |

---

## Cores (Theme)

Definidas em: `lib/core/theme/theme.dart`

| Token | Valor | Uso |
|-------|-------|-----|
| `primaryColor` | - | Cor principal |
| `secondaryColor` | - | Cor secundária |
| `backgroundColor` | - | Fundo das telas |
| `cardColor` | - | Cards e containers |
| `accentColor` | - | Destaques e ações |
| `textColor` | - | Texto principal |
| `errorColor` | - | Erros e alertas |

---

## Como Usar

1. Abra o Figma e selecione o frame desejado
2. Copie o link (Ctrl+L ou Right-click → Copy link)
3. Cole na issue correspondente do GitHub
4. Implemente seguindo o design

---

## Convenções

- Sempre referenciar o frame do Figma na Issue/PR
- Manter este documento atualizado ao implementar novas telas
- Usar os componentes existentes antes de criar novos
