# Primeiros Passos

Esta seção descreve os passos iniciais para o grupo poder trabalhar com o código em seus próprios computadores.
Este repositório se trata do sistema de controle desenvolvido pela Toradex ***(logo, nada de deixar público)*** para o controle do MELO, o robô equilibrista do laboratório. Ele será utilizado para o trabalho final da disciplina SAA0168 - Sistemas de Controle de Aeronaves I.

## Criação do Fork

Para poder realizar alterações no código, o grupo deve realizar um fork do repositório.

Para fazer isso, siga os seguintes passos:

* No lado superior direito, clique no botão `Fork`.

![Demonstrando o botão do fork](../main/docs/new-fork.png)

* Escolha um nome para o seu repositório. O nome não pode conter espaços ou caracteres especiais. Após isso, clique em `Create fork`.

![Página de configuração do fork](../main/docs/name-fork.png)

## Utilização no seu computador 

Agora que você tem acesso ao seu repositório remoto, vocêU+
Caso não tenha git no seu computador, é necessário instála-lo. Vá em [Git - Downloads](https://git-scm.com/downloads) e baixe a versão para o seu sistema operacional.

![Site para download do git](../main/docs/git.png)

Para baixar o VS code, vá em [Download Visual Studio Code](https://code.visualstudio.com/Download).

![Site para download do VS Code](../main/docs/vscode.png)


### Tutorial de Integração do VS Code com o GitHub

Siga o tutorial em [Working with GitHub in VS Code](https://code.visualstudio.com/docs/sourcecontrol/github) para começar a utilizar o seu repositório na sua máquina local.

# Estrutura do Repositório

Esta seção descreve brevemente a estrutura do repositório. Para uma descrição mais detalhada, veja o arquivo original fornecido pela toradex em [tbot-toradex.md](../main/docs/tbot-toradex.md).

### Pastas:

* **docs**: arquivos de documentação. Basicamente, todas as imagens e links presentes neste README.
* **armgcc**: arquivos de configuração para a compilação do código para o robô.
* **nxp_files**: arquivos de configuração do hardware da placa que controla o robô, especificamente os relacionados ao módulo de processamento.
* **drivers**: arquivos dos drivers dos motores, encoders, acelerômetro e giroscópio.
* **libs**: bibliotecas da toradex para realizar operações específicas em C. Vale a pena conferir o filtro de Kalman (`Kalman.c`e `Kalman.h`) e o temporizador (`tdxtick.c`e `tdxtick.h`).
* **src**: códigos utilizados para a programação do comportamento do robô, será o foco principal do desenvolvimento do grupo.

## Arquivos na pasta **src**

* **main.c**: inicialização do sistema e loop de execução principal, o qual chama a execução do controle.
* **control.c**: realiza o controle do sistema - ***Arquivo principal a ser modificado pelo grupo.***
* **motor_defs.c**: define as configurações dos motores.
* **robot_encoders.c**: define os encoders dos motores.

> [!TIP]
> **Header Files**
> 
> Você pode perceber que todo arquivo de código `<exemplo>.c` tem seu par `<exemplo>.h`. Esses são os chamados *header files*, uma convenção (e uma boa prática) de programação em C. No *.h*, são declaradas todas as estruturas das funções do *.c* (tipo, nome, seus argumentos e respectivos tipos). Também são declaradas todas as dependências e definições do código (Por exemplo, o `motor_defs.h` define as constantes físicas para converter entre a velocidade do motor e a da roda). Com isso, ao compilar um sistema com muitas fontes de código diferentes, é possível evitar conflitos de definições.

# Objetivo do Trabalho

O Objetivo do presente trabalho é modificar o código de controle existente no MELO, o qual pode ser encontrado dentro da pasta **src** chamado `control.c`. Além desse arquivo, pode ser necessário analisar e alterar o `control.h` e o `main.c`. 

O sistema de controle atual do MELO é um PI (Proporcional + Integrativo) e o grupo deve propor e implementar mudanças nessa malha. A mudança fica a cargo dos alunos, pode ser adicionar um termo derivativo, mudar o controle para adaptativo, robusto ou qualquer outra abordagem. Além disso, é de bom grado fazer mudanças adicionais, tais como comentários explicativos e filtros de dados adicionais. 

O grupo deve ter entre 4 a 6 alunos e o trabalho deve ser entregue em um PDF explicativo, tanto a teoria quanto a implementação, e o link do fork que será compilado e testado no robô. 

Ademais, logo será enviado uma simulação em Simulink/MATLAB para testar o modelo de controle de cada grupo antes de implementar no robô para evitar divergências não planejadas e danificar o hardware. 

PS: O MELO é sensível ☺️

