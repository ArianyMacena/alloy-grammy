# Projeto Alloy — Lógica para Computação

Este projeto modela, utilizando Alloy, o sistema de premiação do Grammy Awards, com foco na consistência das regras de indicação e relações entre artistas, álbuns e canções.

## 🧩 Principais Especificações do Sistema

- O Grammy apresenta 4 categorias principais, cada uma com 4 a 8 indicados:
    - Melhor Artista/Banda;
    - Melhor Álbum;
    - Melhor Canção;
    - Melhor Colaboração.
- Cada álbum é de propriedade de um único artista/banda e contém uma coleção de canções.
- Cada canção possui um ou mais artistas (para permitir colaborações).
- A categoria Melhor Artista/Banda deve conter apenas artistas com álbuns indicados na categoria Melhor Álbum.
- Na categoria Melhor Colaboração, apenas canções com mais de um artista podem ser indicadas.
- Na categoria Melhor Canção, pelo menos metade das canções indicadas deve estar presente em álbuns indicados a Melhor Álbum.
- Uma canção pode fazer parte de no máximo dois álbuns.

## 📌 Orientações adicionais

- A entrega consiste em uma especificação em Alloy (.als), de acordo com os requisitos do tema definido para o grupo.
- Cada tema possui um cliente responsável pelo esclarecimento de dúvidas.
- Devem ser utilizadas assinaturas, relações binárias, cardinalidades, extends ou in, e quantificadores nos fatos.
- Incluir pelo menos duas asserções que permitam verificar propriedades desejáveis do sistema.
- Crie um cenário exemplo e utilize escopo mínimo 5.

## 👨‍💻 Como usar o Alloy

1. Instale o Alloy Analyzer: http://alloytools.org
2. Abra o arquivo .als no Alloy Analyzer.
3. Clique em “Run” para gerar instâncias do modelo, definindo o escopo máximo de elementos (recomendado 12 elementos e inteiros limitados a 5).
4. Clique em “Check” para verificar os asserts, garantindo que as propriedades desejadas do sistema estão sendo respeitadas.
5. Explore os modelos gerados para analisar visualmente as relações entre artistas, álbuns e canções.

## 👥 Integrantes do Grupo

- Ariany da Silva Macena;
- Ana Paula Soares Cassimiro;
- Fabiana Simplício da Silva;
- Viviane Alves da Silva;
- Yasmim Dantas da Costa Souza.

# 📘 Componente Curricular

- Disciplina: Lógica para Computação
- Período: 2025.1
- Professor: Salatiel Dantas