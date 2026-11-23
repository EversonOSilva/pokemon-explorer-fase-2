# Pokémon Explorer --- React Native

Tela adicional desenvolvida como parte do projeto **Pokémon Explorer**,
para a disciplina **Desenvolvimento de Sistemas Mobile --- Fase 2**.

## 1. Sobre o projeto

Esta versão foi desenvolvida em **React Native**, utilizando **Expo**.
Ela apresenta uma tela adicional de exploração de Pokémon com dados de
demonstração definidos diretamente no código e mantidos em memória.

Conforme a proposta da atividade, esta implementação secundária não
depende de integração com a PokéAPI.

## 2. Tecnologias utilizadas

-   React Native.
-   JavaScript.
-   Expo.
-   Node.js e npm.
-   Visual Studio Code.
-   Android Studio para emulador Android.

## 3. Funcionalidades

-   Exibição de uma lista de Pokémon de demonstração.
-   Imagens dos Pokémon nos cartões.
-   Pesquisa pelo nome.
-   Pesquisa pelo número.
-   Filtros por tipo.
-   Seleção de mais de um tipo de filtro.
-   Mensagem quando a pesquisa não encontra resultados.
-   Navegação demonstrativa pelas opções Explorar, Favoritos e Perfil.

**Observação:** os dados da lista são exemplos definidos no próprio
aplicativo. As opções Favoritos e Perfil são demonstrativas e não
representam sincronização com a versão Flutter.

## 4. Organização geral

Os principais arquivos do projeto Expo incluem:

``` text
React_Native/
├── assets/
├── App.js
├── package.json
└── README.md
```

Outros arquivos de configuração criados pelo Expo também devem ser
mantidos.

## 5. Como executar

### Pré-requisitos

-   Node.js instalado.
-   npm disponível.
-   Android Studio com emulador Android configurado, ou dispositivo
    compatível.
-   Conexão com a internet para carregar as imagens remotas.

### Passos

1.  Abra a pasta `React_Native` no Visual Studio Code.

2.  Abra o terminal nessa pasta.

3.  Instale as dependências:

    ``` bash
    npm install
    ```

4.  Inicie o Expo:

    ``` bash
    npm start
    ```

5.  Para abrir no emulador Android, pressione `a` no terminal do Expo.

No Windows PowerShell, se `npm` apresentar bloqueio relacionado ao
arquivo `npm.ps1`, utilize:

``` powershell
npm.cmd install
npm.cmd start
```

## 6. Dados e imagens

Os dados dos Pokémon são definidos em uma lista JavaScript dentro de
`App.js`. As imagens são carregadas por endereços remotos do repositório
de sprites Pokémon no GitHub.

É necessária conexão com a internet para exibir essas imagens.

## 7. Observações

-   A pasta `node_modules/` é recriada com `npm install` e não precisa
    ser incluída no ZIP.
-   Esta é a implementação secundária em React Native.
-   Os dados são demonstrativos e ficam em memória; não há integração
    com API ou banco de dados nesta versão.

## 8. Contexto acadêmico

Esta implementação corresponde à **tecnologia secundária** do projeto
Pokémon Explorer na Fase 2 da disciplina Desenvolvimento de Sistemas
Mobile. Seu objetivo é demonstrar a construção de uma tela móvel
utilizando uma segunda tecnologia, conforme solicitado na atividade.
