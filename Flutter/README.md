# Pokémon Explorer --- Flutter

Aplicativo móvel desenvolvido como projeto da disciplina
**Desenvolvimento de Sistemas Mobile --- Fase 2**.

## 1. Sobre o projeto

O Pokémon Explorer é um aplicativo de consulta de Pokémon. A versão
principal foi desenvolvida em **Flutter** e consome dados da **PokéAPI**
para apresentar informações de Pokémon e seus movimentos.

## 2. Tecnologias utilizadas

-   Flutter e Dart.
-   PokéAPI (API REST).
-   Pacote HTTP para requisições.
-   Shared Preferences para persistência local dos favoritos.
-   Android Studio para emulador e ferramentas Android.
-   Visual Studio Code para edição do código-fonte.

## 3. Funcionalidades

-   Listagem de Pokémon obtidos da PokéAPI.
-   Carregamento de mais resultados por paginação.
-   Pesquisa por nome ou número do Pokémon.
-   Filtros por tipos.
-   Visualização dos movimentos de um Pokémon.
-   Tela de detalhes de um movimento.
-   Marcação e remoção de Pokémon favoritos.
-   Persistência local dos favoritos.
-   Tela de favoritos.
-   Tela de perfil com informações resumidas do aplicativo.

## 4. Organização geral

O código-fonte principal fica na pasta `lib/`. O projeto também contém
arquivos de configuração e pastas específicas da plataforma.

``` text
Flutter/
├── android/
├── lib/
├── test/
├── pubspec.yaml
└── README.md
```

A estrutura interna de `lib/` pode ser consultada diretamente no
projeto.

## 5. API utilizada

-   Documentação: https://pokeapi.co/docs/v2
-   Endereço-base: `https://pokeapi.co/api/v2/`

É necessária conexão com a internet para consultar os dados remotos e
carregar as imagens.

## 6. Como executar

### Pré-requisitos

-   Flutter instalado e configurado.
-   Android Studio com emulador Android configurado, ou dispositivo
    Android com depuração habilitada.
-   Conexão com a internet.

### Passos

1.  Abra a pasta `Flutter` no Visual Studio Code.

2.  Abra o terminal nessa pasta.

3.  Instale as dependências:

    ``` bash
    flutter pub get
    ```

4.  Confira os dispositivos disponíveis:

    ``` bash
    flutter devices
    ```

5.  Execute o aplicativo:

    ``` bash
    flutter run
    ```

## 7. Observações

-   As pastas `.dart_tool/` e `build/` podem ser recriadas pelo Flutter.
-   Os favoritos são armazenados localmente no dispositivo por meio de
    Shared Preferences.
-   A disponibilidade dos dados da PokéAPI depende de acesso à internet.

## 8. Contexto acadêmico

Este aplicativo corresponde à **tecnologia principal** escolhida para a
Fase 2 da disciplina Desenvolvimento de Sistemas Mobile. A implementação
contempla consumo de API REST, apresentação dinâmica de dados e
navegação entre telas.
