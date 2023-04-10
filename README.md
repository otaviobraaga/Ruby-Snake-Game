# Jogo da Cobrinha

O Jogo da Cobravia é uma versão do clássico jogo da cobrinha, criado utilizando a biblioteca Ruby2D. Neste jogo, você controla uma cobra que precisa comer maçãs para crescer e marcar pontos, enquanto evita colidir com as paredes ou com o próprio corpo.

# Como jogar

O jogo é controlado pelas setas do teclado. Pressione as setas para cima, baixo, esquerda ou direita para mover a cobra na direção desejada. Quando a cobra come uma maçã, ela cresce um bloco e sua pontuação aumenta em um ponto. Se a cobra colidir com as paredes ou com o próprio corpo, o jogo acaba.

Para começar uma nova partida, pressione a tecla R quando o jogo acabar.

# Como executar

Certifique-se de ter o Ruby e a biblioteca Ruby2D instalados em sua máquina. Para instalar a biblioteca, execute o seguinte comando no terminal:

`gem install ruby2d`

Em seguida, faça o download ou clone este repositório em sua máquina. Navegue até a pasta do projeto e execute o seguinte comando para iniciar o jogo:

git clone SnakeInRuby

# Arquivos do projeto

O projeto é composto pelos seguintes arquivos:

snake.rb: Codigo fonte geral, arquivo que define a classe Snake, responsável por gerenciar a cobra e suas movimentações, e randomização do spawn da "maçã".
README.md: arquivo que você está lendo agora, que explica o jogo e o código.
