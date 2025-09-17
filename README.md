# Studie App

Um aplicativo Flutter para gerenciamento e planejamento de estudos, desenvolvido com foco em organização de tarefas semanais e funcionalidades de estudo.

## 📱 Sobre o Projeto

O Studie é um aplicativo de produtividade voltado para estudantes que desejam organizar seus estudos de forma eficiente. Com interface intuitiva e recursos avançados, o app oferece ferramentas para criar planos de estudo, gerenciar tarefas e utilizar técnicas de produtividade como Pomodoro.

## ✨ Funcionalidades

### 🗓️ Planejamento Semanal
- Criação e gerenciamento de tarefas por dia da semana
- Visualização em formato de carrossel para navegação entre os dias
- Sistema de horários com validação de conflitos

### 🤖 Integração com IA (Gemini)
- Geração automática de planos de estudo personalizados
- Interface de chat integrada para assistência em estudos
- Configuração de horários e intervalos de estudo automatizados

### ⏱️ Timer Pomodoro
- Timer de 25 minutos para sessões de estudo focado
- Controles de play, pause e cancelar
- Interface visual com animações Lottie

### 💾 Persistência de Dados
- Banco de dados local usando Drift
- Sincronização com Firebase (em desenvolvimento)
- Backup e restore de dados na nuvem

### 🔒 Segurança e Monitoramento
- Integração com Firebase App Check
- Crashlytics para monitoramento de erros
- Sistema de autenticação (em desenvolvimento)

## 🛠️ Tecnologias Utilizadas

### Framework e Linguagem
- **Flutter** - Framework de desenvolvimento mobile
- **Dart** - Linguagem de programação

### Gerenciamento de Estado
- **GetX** - Gerenciamento de estado, rotas e dependências

### Banco de Dados
- **Drift** - ORM para SQLite no Flutter
- **SQLite** - Banco de dados local

### Backend e Serviços
- **Firebase Core** - Plataforma de desenvolvimento
- **Firebase AI** - Integração com Gemini AI
- **Firebase Crashlytics** - Monitoramento de crashes
- **Firebase App Check** - Verificação de autenticidade

### Interface e Animações
- **Lottie** - Animações vetoriais
- **Carousel Slider** - Carrossel de widgets
- **Flutter AI Toolkit** - Interface de chat com IA

### Conectividade
- **Connectivity Plus** - Monitoramento de conexão de rede

## 🏗️ Arquitetura

O projeto segue uma arquitetura baseada em camadas:

```
lib/
├── domain/
│   └── workflow/          # Interfaces e contratos
├── source/
│   ├── database/          # Camada de dados (Drift)
│   ├── models/            # Modelos de dados
│   └── service/           # Serviços (Firebase, IA)
├── ui/
│   ├── controllers/       # Controladores GetX
│   ├── core/              # Componentes e temas
│   └── screens/           # Telas da aplicação
└── utils/                 # Utilitários e helpers
```

### Padrões Utilizados
- **Repository Pattern** - Através dos workflows
- **Dependency Injection** - GetX para injeção de dependências
- **Observer Pattern** - GetX Reactive Programming

## 📊 Modelos de Dados

### Task (Tarefa)
```dart
class Task {
  final int timeStart;      // Hora de início (formato 24h)
  final int timeEnd;        // Hora de fim
  final String description; // Descrição da tarefa
  final String discipline;  // Matéria/disciplina
  bool checked;            // Status de conclusão
  final int? uid;          // ID único
  final String daysWeek;   // Dias da semana
}
```

### User (Usuário)
```dart
class User {
  final String name;       // Nome do usuário
  final String email;      // Email
  final String phone;      // Telefone
  final bool isActive;     // Status ativo
}
```

## 🚀 Como Executar

### Pré-requisitos
- Flutter SDK (versão 3.0+)
- Dart SDK
- Android Studio / VS Code
- Conta no Firebase (para funcionalidades de IA e crash reporting)

### Configuração

1. **Clone o repositório:**
```bash
git clone <url-do-repositorio>
cd studie-app
```

2. **Instale as dependências:**
```bash
flutter pub get
```

3. **Configure o Firebase:**
   - Crie um projeto no [Firebase Console](https://console.firebase.google.com)
   - Adicione seu app Android/iOS
   - Baixe e adicione os arquivos de configuração
   - Configure o App Check e Crashlytics

4. **Gere os arquivos do Drift:**
```bash
dart run build_runner build
```

5. **Execute o aplicativo:**
```bash
flutter run
```

## 📝 Funcionalidades Detalhadas

### 🗓️ Gerenciamento de Tarefas
- **Criação**: Formulário completo com validação de horários
- **Visualização**: Lista organizada por dias da semana
- **Edição**: Atualização de tarefas existentes
- **Exclusão**: Remoção com confirmação
- **Status**: Marcar como concluída

### 🤖 Assistente IA
- **Geração de Planos**: Criação automática baseada em:
  - Nome do certame/concurso
  - Horários de estudo
  - Intervalos de descanso
- **Chat Interativo**: Interface de conversação
- **Validação**: Verificação de conectividade

### ⏱️ Pomodoro Timer
- **Timer de 25 minutos**: Padrão da técnica Pomodoro
- **Controles intuitivos**: Play, pause, reset
- **Feedback visual**: Animações e indicadores
- **Auto-reset**: Reinício automático ao completar

## 🔧 Configurações Técnicas

### Dependências Principais
```yaml
dependencies:
  flutter:
    sdk: flutter
  get: ^4.x.x
  drift: ^2.x.x
  drift_flutter: ^0.x.x
  firebase_core: ^2.x.x
  firebase_ai: ^0.x.x
  firebase_crashlytics: ^3.x.x
  firebase_app_check: ^0.x.x
  connectivity_plus: ^4.x.x
  lottie: ^2.x.x
  carousel_slider: ^4.x.x
  flutter_ai_toolkit: ^0.x.x
```

### Configurações do Firebase
O app utiliza Firebase para:
- **AI Services**: Integração com Gemini 2.5 Flash
- **Crashlytics**: Monitoramento de erros
- **App Check**: Verificação de autenticidade
- **Authentication**: Sistema de login (futuro)
- **Firestore**: Sincronização de dados (futuro)

## 📱 Telas da Aplicação

### Home
- Menu principal com navegação por cards
- Acesso rápido às funcionalidades principais
- Design com gradientes e animações

### Tasks (Tarefas)
- Carrossel navegável entre dias da semana
- Lista de tarefas por dia
- Formulário de criação/edição
- Sincronização com nuvem (em desenvolvimento)

### AI Assistant
- Interface de chat com IA
- Formulário para geração de planos de estudo
- Indicadores de status de conectividade
- Animações durante processamento

### Timer
- Interface limpa e focada
- Display digital do tempo
- Controles intuitivos
- Animações Lottie

## 🛣️ Roadmap

### Funcionalidades Planejadas
- [ ] Sistema completo de autenticação
- [ ] Sincronização total com Firebase
- [ ] Relatórios de produtividade
- [ ] Modo escuro
- [ ] Notificações push
- [ ] Integração com calendário
- [ ] Backup automático
- [ ] Compartilhamento de planos

### Melhorias Técnicas
- [ ] Testes unitários e de integração
- [ ] CI/CD pipeline
- [ ] Performance optimization
- [ ] Acessibilidade melhorada
- [ ] Suporte a tablet
- [ ] Versão web

## 🤝 Como Contribuir

1. Fork o projeto
2. Crie uma branch para sua feature (`git checkout -b feature/AmazingFeature`)
3. Commit suas mudanças (`git commit -m 'Add some AmazingFeature'`)
4. Push para a branch (`git push origin feature/AmazingFeature`)
5. Abra um Pull Request

## 📄 Licença

Este projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

## 👥 Equipe

- **Desenvolvedor Principal** - [Seu Nome]

## 📞 Contato

- **Email**: seu.email@exemplo.com
- **LinkedIn**: [Seu LinkedIn]
- **GitHub**: [Seu GitHub]

---

**Studie App** - Organizando seus estudos com tecnologia 📚✨
