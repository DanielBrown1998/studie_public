# Casos de Uso - Studie App

Este documento descreve os casos de uso do aplicativo Studie, organizados por funcionalidade.

## Índice

1. [UC01 - Gerenciar Disciplinas](#uc01---gerenciar-disciplinas)
2. [UC02 - Gerar Plano de Estudos](#uc02---gerar-plano-de-estudos)
3. [UC03 - Gerenciar Cronograma de Estudos](#uc03---gerenciar-cronograma-de-estudos)
4. [UC04 - Consultar Assistente de IA](#uc04---consultar-assistente-de-ia)
5. [UC05 - Utilizar Temporizador de Estudo](#uc05---utilizar-temporizador-de-estudo)
6. [UC06 - Visualizar Trilha de Aprendizado](#uc06---visualizar-trilha-de-aprendizado)

---

## UC01 - Gerenciar Disciplinas

### Descrição
Permite ao usuário adicionar, visualizar e remover disciplinas de estudo da sua lista pessoal.

### Atores
- **Estudante** (Ator Primário)
- **Sistema de Banco de Dados** (Ator Secundário)

### Pré-condições
- O aplicativo deve estar inicializado
- O banco de dados local deve estar acessível

### Fluxo Principal
1. O estudante acessa a tela Home
2. O sistema exibe as disciplinas cadastradas
3. O estudante clica no botão de adicionar disciplina
4. O sistema exibe o diálogo com disciplinas disponíveis
5. O estudante seleciona as disciplinas desejadas
6. O estudante confirma a seleção
7. O sistema persiste as disciplinas no banco de dados
8. O sistema atualiza a lista de disciplinas na tela

### Fluxos Alternativos

**FA01 - Nenhuma disciplina cadastrada**
1. No passo 2, se não houver disciplinas cadastradas
2. O sistema exibe um card informativo
3. O estudante pode clicar para adicionar disciplinas
4. Continua no passo 4

**FA02 - Remover disciplina**
1. No passo 2, o estudante pode desmarcar uma disciplina já cadastrada no diálogo
2. O sistema remove a disciplina do banco de dados
3. O sistema atualiza a lista

### Fluxos de Exceção

**FE01 - Erro ao salvar no banco de dados**
1. O sistema exibe mensagem de erro
2. O sistema mantém o estado anterior
3. O estudante pode tentar novamente

### Pós-condições
- As disciplinas selecionadas estão persistidas no banco de dados
- A tela Home reflete as alterações realizadas

### Regras de Negócio
- RN01: O usuário pode selecionar múltiplas disciplinas de uma vez
- RN02: Disciplinas já cadastradas aparecem pré-selecionadas no diálogo
- RN03: O sistema utiliza uma lista pré-cadastrada de disciplinas/tecnologias

---

## UC02 - Gerar Plano de Estudos

### Descrição
Permite ao usuário gerar automaticamente um plano de estudos com matérias/assuntos para uma disciplina específica utilizando inteligência artificial.

### Atores
- **Estudante** (Ator Primário)
- **Firebase AI (Gemini)** (Ator Secundário)
- **Sistema de Banco de Dados** (Ator Secundário)

### Pré-condições
- O usuário deve ter pelo menos uma disciplina cadastrada
- Conexão com internet disponível
- Firebase AI configurado e disponível

### Fluxo Principal
1. O estudante seleciona uma disciplina na tela Home
2. O estudante solicita a geração do plano de estudos
3. O sistema envia requisição para o Firebase AI com os dados da disciplina
4. O Firebase AI processa e retorna uma lista de matérias
5. O sistema valida os dados retornados
6. O sistema persiste as matérias no banco de dados
7. O sistema exibe as matérias geradas para o estudante

### Fluxos Alternativos

**FA01 - Plano já existente**
1. No passo 2, se já existir um plano para a disciplina
2. O sistema pergunta se deseja regenerar
3. Se sim, continua no passo 3
4. Se não, exibe o plano existente

### Fluxos de Exceção

**FE01 - Falha na comunicação com IA**
1. O sistema exibe mensagem de erro de conexão
2. O sistema sugere tentar novamente mais tarde

**FE02 - Resposta inválida da IA**
1. O sistema descarta a resposta inválida
2. O sistema exibe mensagem de erro
3. O estudante pode tentar novamente

### Pós-condições
- Um plano de estudos com até 50 matérias está cadastrado para a disciplina
- Cada matéria possui título, descrição, nível de dificuldade, métricas e recursos

### Regras de Negócio
- RN01: São geradas até 50 matérias por disciplina
- RN02: Os níveis de dificuldade variam de 1 (fácil) a 50 (difícil)
- RN03: Cada matéria tem descrição com no máximo 200 caracteres
- RN04: Todas as matérias iniciam com status "não concluído"
- RN05: Não pode haver matérias repetidas na mesma disciplina

---

## UC03 - Gerenciar Cronograma de Estudos

### Descrição
Permite ao usuário criar um cronograma semanal de estudos com horários e disciplinas distribuídas automaticamente pela IA.

### Atores
- **Estudante** (Ator Primário)
- **Firebase AI (Gemini)** (Ator Secundário)
- **Sistema de Banco de Dados** (Ator Secundário)

### Pré-condições
- O usuário deve ter pelo menos uma disciplina cadastrada
- Conexão com internet disponível
- Firebase AI configurado e disponível

### Fluxo Principal
1. O estudante acessa a funcionalidade de cronograma
2. O sistema exibe configurações de horários
3. O estudante seleciona os dias da semana disponíveis
4. O estudante define os horários de estudo para cada dia
5. O estudante confirma a criação do cronograma
6. O sistema envia os dados para o Firebase AI
7. O Firebase AI distribui as disciplinas nos horários
8. O sistema persiste as sessões de estudo no banco de dados
9. O sistema exibe o cronograma gerado

### Fluxos Alternativos

**FA01 - Cronograma existente**
1. No passo 1, se já existir um cronograma
2. O sistema exibe o cronograma atual
3. O estudante pode optar por editar ou regenerar

### Fluxos de Exceção

**FE01 - Sem disciplinas cadastradas**
1. No passo 5, se não houver disciplinas
2. O sistema exibe mensagem informativa
3. O sistema redireciona para adicionar disciplinas

**FE02 - Erro ao gerar cronograma**
1. O sistema exibe mensagem de erro
2. O estudante pode ajustar configurações e tentar novamente

### Pós-condições
- Um cronograma semanal está persistido no banco de dados
- Cada sessão contém disciplina, dia da semana, horário início e fim

### Regras de Negócio
- RN01: O horário de início deve ser menor que o horário de fim
- RN02: Os dias são representados pelos dias da semana em português
- RN03: Todas as disciplinas cadastradas são consideradas na distribuição

---

## UC04 - Consultar Assistente de IA

### Descrição
Permite ao usuário fazer perguntas ao assistente de IA e receber respostas contextualizadas sobre seus estudos.

### Atores
- **Estudante** (Ator Primário)
- **Firebase AI (Gemini)** (Ator Secundário)

### Pré-condições
- Conexão com internet disponível
- Firebase AI configurado e disponível

### Fluxo Principal
1. O estudante acessa o assistente de IA
2. O sistema exibe a interface de chat
3. O estudante digita sua pergunta
4. O estudante envia a pergunta
5. O sistema envia a pergunta para o Firebase AI
6. O Firebase AI processa e retorna a resposta
7. O sistema exibe a resposta para o estudante

### Fluxos Alternativos

**FA01 - Histórico de conversas**
1. No passo 2, o sistema pode exibir histórico
2. O estudante pode continuar uma conversa anterior

### Fluxos de Exceção

**FE01 - Falha na comunicação**
1. O sistema exibe mensagem de erro
2. O estudante pode tentar reenviar a pergunta

**FE02 - Tempo limite excedido**
1. O sistema cancela a requisição
2. O sistema exibe mensagem de timeout
3. O estudante pode tentar novamente

### Pós-condições
- A resposta da IA é exibida ao estudante

### Regras de Negócio
- RN01: As perguntas podem ser sobre qualquer assunto relacionado a estudos
- RN02: A IA deve fornecer respostas contextualizadas e educacionais

---

## UC05 - Utilizar Temporizador de Estudo

### Descrição
Permite ao usuário utilizar um temporizador para controlar suas sessões de estudo.

### Atores
- **Estudante** (Ator Primário)

### Pré-condições
- O aplicativo deve estar inicializado

### Fluxo Principal
1. O estudante acessa a tela de Timer
2. O sistema exibe o temporizador
3. O estudante configura o tempo desejado
4. O estudante inicia o temporizador
5. O sistema contabiliza o tempo
6. O sistema notifica ao término do tempo
7. O sistema registra a sessão de estudo

### Fluxos Alternativos

**FA01 - Pausar temporizador**
1. Durante o passo 5, o estudante pode pausar
2. O sistema pausa a contagem
3. O estudante pode retomar ou cancelar

**FA02 - Usar Pomodoro**
1. O estudante pode selecionar modo Pomodoro
2. O sistema alterna entre períodos de estudo e descanso

### Pós-condições
- O tempo de estudo é contabilizado
- A sessão pode ser registrada para estatísticas

### Regras de Negócio
- RN01: O temporizador pode ser pausado e retomado
- RN02: O sistema emite notificação sonora ao término

---

## UC06 - Visualizar Trilha de Aprendizado

### Descrição
Permite ao usuário visualizar sua trilha de aprendizado para uma disciplina específica, mostrando o progresso nos assuntos.

### Atores
- **Estudante** (Ator Primário)
- **Sistema de Banco de Dados** (Ator Secundário)

### Pré-condições
- O usuário deve ter pelo menos uma disciplina cadastrada
- A disciplina deve ter um plano de estudos gerado

### Fluxo Principal
1. O estudante acessa a tela de Trilha
2. O sistema exibe a disciplina atual selecionada
3. O sistema carrega as matérias da disciplina
4. O sistema exibe a trilha de aprendizado
5. O estudante visualiza os assuntos e seus status
6. O estudante pode marcar um assunto como concluído
7. O sistema atualiza o status no banco de dados
8. O sistema recalcula e exibe o progresso

### Fluxos Alternativos

**FA01 - Trocar disciplina**
1. O estudante pode selecionar outra disciplina
2. O sistema carrega a trilha da nova disciplina
3. Continua no passo 4

**FA02 - Sem plano de estudos**
1. No passo 3, se não houver matérias
2. O sistema exibe mensagem informativa
3. O sistema sugere gerar o plano de estudos

### Pós-condições
- O progresso do estudante está atualizado
- A trilha reflete os assuntos concluídos

### Regras de Negócio
- RN01: O progresso é calculado como percentual de assuntos concluídos
- RN02: Os assuntos são exibidos por ordem de dificuldade
- RN03: Assuntos concluídos são visualmente diferenciados

---

## Matriz de Rastreabilidade

| Caso de Uso | Entidades | Repositórios | UseCases |
|-------------|-----------|--------------|----------|
| UC01 | Discipline | DisciplineRepository | DefineDisciplineToStudyUsecase, GetDisciplinesAndYourDataUseCase |
| UC02 | Discipline, Subject | DisciplineRepository, SubjectsRepository, AiRepository | MakeStudyPlanUseCase |
| UC03 | Discipline, StudieSession | DisciplineRepository, StudieSessionRepository, AiRepository | MakeStudyCronogramUseCase, GetStudyCronogramUseCase |
| UC04 | - | AiRepository | MakeAQuestionToAiUsecase |
| UC05 | StudieSession | StudieSessionRepository | - |
| UC06 | Discipline, Subject | DisciplineRepository, SubjectsRepository | GetStudyPlanUseCase |
