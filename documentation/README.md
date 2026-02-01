# 📚 Documentação do Studie

Este diretório contém toda a documentação técnica e de requisitos do aplicativo Studie.

## 📋 Índice

### 1. Visão Geral
- [README Principal](../app/README.md) - Visão geral do projeto, tecnologias e arquitetura

### 2. Diagrama de Casos de Uso
- [use_case_diagram.puml](./use_case_diagram.puml) - Diagrama principal com todos os casos de uso

### 3. Descrição dos Casos de Uso
- [use_cases/README.md](./use_cases/README.md) - Descrição detalhada de cada caso de uso

### 4. Diagramas por Caso de Uso

| Caso de Uso | Diagrama de Estados | Diagrama de Sequência |
|-------------|--------------------|-----------------------|
| UC01 - Gerenciar Disciplinas | [state_manage_disciplines.puml](./state_manage_disciplines.puml) | [sequence_manage_disciplines.puml](./sequence_manage_disciplines.puml) |
| UC02 - Gerar Plano de Estudos | [state_generate_study_plan.puml](./state_generate_study_plan.puml) | [sequence_generate_study_plan.puml](./sequence_generate_study_plan.puml) |
| UC03 - Gerenciar Cronograma | [state_manage_study_cronogram.puml](./state_manage_study_cronogram.puml) | [sequence_manage_study_cronogram.puml](./sequence_manage_study_cronogram.puml) |
| UC04 - Consultar Assistente IA | [state_ask_ai_assistant.puml](./state_ask_ai_assistant.puml) | [sequence_ask_ai_assistant.puml](./sequence_ask_ai_assistant.puml) |
| UC05 - Utilizar Temporizador | [state_timer.puml](./state_timer.puml) | [sequence_timer.puml](./sequence_timer.puml) |
| UC06 - Visualizar Trilha | [state_learning_trail.puml](./state_learning_trail.puml) | [sequence_learning_trail.puml](./sequence_learning_trail.puml) |

### 5. Diagramas Legados (Referência)
- [state_manage_study_plan.puml](./state_manage_study_plan.puml) - Estados do gerenciamento de plano
- [sequence_manage_study_plan.puml](./sequence_manage_study_plan.puml) - Sequência do gerenciamento de plano

---

## 🎨 Design System
- [DESIGN_SYSTEM.md](./DESIGN_SYSTEM.md) - Sistema de design e componentes visuais

---

## 📐 Como Visualizar os Diagramas PlantUML

### Opção 1: VS Code
1. Instale a extensão "PlantUML" 
2. Abra o arquivo `.puml`
3. Use `Alt+D` para visualizar

### Opção 2: Online
1. Acesse [plantuml.com](https://www.plantuml.com/plantuml/uml)
2. Cole o conteúdo do arquivo
3. Clique em "Submit"

### Opção 3: Linha de Comando
```bash
# Instale o PlantUML
# Windows (chocolatey)
choco install plantuml

# Gere PNG de todos os diagramas
plantuml *.puml
```

---

## 🗂️ Estrutura de Arquivos

```
documentation/
├── README.md                           # Este arquivo (índice)
├── DESIGN_SYSTEM.md                    # Sistema de design
├── use_case_diagram.puml               # Diagrama de casos de uso
│
├── use_cases/
│   └── README.md                       # Descrição detalhada dos casos de uso
│
├── state_manage_disciplines.puml       # UC01 - Estados
├── sequence_manage_disciplines.puml    # UC01 - Sequência
│
├── state_generate_study_plan.puml      # UC02 - Estados
├── sequence_generate_study_plan.puml   # UC02 - Sequência
│
├── state_manage_study_cronogram.puml   # UC03 - Estados
├── sequence_manage_study_cronogram.puml# UC03 - Sequência
│
├── state_ask_ai_assistant.puml         # UC04 - Estados
├── sequence_ask_ai_assistant.puml      # UC04 - Sequência
│
├── state_timer.puml                    # UC05 - Estados
├── sequence_timer.puml                 # UC05 - Sequência
│
├── state_learning_trail.puml           # UC06 - Estados
└── sequence_learning_trail.puml        # UC06 - Sequência
```

---

## 📊 Resumo dos Casos de Uso

| ID | Nome | Descrição | Ator |
|----|------|-----------|------|
| UC01 | Gerenciar Disciplinas | CRUD de disciplinas para estudo | Estudante |
| UC02 | Gerar Plano de Estudos | IA gera plano baseado nas disciplinas | Estudante |
| UC03 | Gerenciar Cronograma | IA cria cronograma de horários | Estudante |
| UC04 | Consultar Assistente IA | Chat com assistente para dúvidas | Estudante |
| UC05 | Utilizar Temporizador | Timer para sessões de estudo | Estudante |
| UC06 | Visualizar Trilha | Acompanhar progresso dos estudos | Estudante |

---

## 🔗 Relacionamentos entre Casos de Uso

```
UC01 (Gerenciar Disciplinas)
    └──► UC02 (Gerar Plano) - extends
         └──► UC03 (Gerenciar Cronograma) - extends

UC02 (Gerar Plano)
    └──► UC06 (Visualizar Trilha) - includes

UC04 (Consultar Assistente) - independente
UC05 (Utilizar Temporizador) - independente
```

---

## 📝 Notas

- Todos os diagramas utilizam o tema `cerulean-outline` do PlantUML
- A documentação segue padrões UML 2.0
- Os diagramas de sequência mostram tanto o fluxo principal quanto alternativo
- Os diagramas de estado incluem estados compostos quando apropriado
