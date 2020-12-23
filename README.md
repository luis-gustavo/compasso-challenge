
# Events App

O Events App é um aplicativo baseado no [Teste de para desenvolvedor(a) iOS do Woop Sicredi](https://github.com/WoopSicredi/jobs/issues/3). Trata-se de um aplicativo em Swift que consome uma REST API para exibir uma lista de eventos, mostrar detalhe dos eventos, permitir realizar o check in em um evento e, por fim, compartilhar o evento.

![App's preview](https://github.com/luis-gustavo/compasso-challenge/blob/develop/readme-assets/app-preview.gif)

## Arquitetura

MVVM (Model-View-ViewModel) foi a arquitetura adodata para este projeto com o intuito evitar ViewControllers massivas, garantir boa testabilidade do projeto e por compreender a necessidade do projeto

## Integração Contínua

Foi configurado um CI para este projeto utilizando o [Github Actions](https://github.com/features/actions), com o intuito de evitar a regressão de código. Este CI roda tanto os testes quanto o build da aplicação. O status atual do CI é:

[![Actions Status](https://github.com/luis-gustavo/compasso-challenge/workflows/CI/badge.svg)](https://github.com/luis-gustavo/compasso-challenge/actions)

# Desenvolvimento da Interface

Para o desenvolvimento da interface do projeto foi escolhido o UIKit utilizando a abordagem de ViewCode. O ViewCode foi escolhido pois:

* Permite melhor reuzo e componentização;
* Permite melhor controle sobre o fluxo de inicialização;
* Melhor para trabalhar em equipe (não tem storyboard merge hell).

# Testes

Até o momento foram criados 16 testes automatizados para este projeto:

* 4 Testes são testes focados na interface da aplicação;
* 12 Testes são focados na parte de networking e nas viewmodels, visto que contém a lógica crucial do aplicativo;

**Imagens geradas nos testes de Snapshot:**

![Snapshot Tests](https://github.com/luis-gustavo/compasso-challenge/blob/develop/readme-assets/snapshot-tests.png)

**Todos os testes executando com sucesso:**

![Tests Suite](https://github.com/luis-gustavo/compasso-challenge/blob/develop/readme-assets/test-suite.png)

# Camada de Networking

Foi desenvolvida uma "camada", utilizando [Combine](https://developer.apple.com/documentation/combine), responsável pelo networking, visto que o projeto trabalha essencialmente com uma REST API.

![Nework Layer](https://github.com/luis-gustavo/compasso-challenge/blob/develop/readme-assets/network-layer.png)

Destaca-se a utilização do paradigma [Protocol Oriented Programming](https://developer.apple.com/videos/play/wwdc2015/408/) na construção deste módulo, que permite criar código de alta qualidade diminuindo o número de erros e aumentando a manutenibilidade.

**Exemplo da utilização da técnica de [Type-Erasure](https://chris-dus.medium.com/type-erasure-in-swift-84480c807534) utilizada para implementar a Injeção de DepeNdência nesta camada:**

![Type Erasure](https://github.com/luis-gustavo/compasso-challenge/blob/develop/readme-assets/type-erasure.png)

# Gerenciamento de Dependências

O [Swift Package Manager](https://github.com/apple/swift-package-manager) foi a ferramenta escolhida para o gerenciamento das depedências do projeto, por trazer o benefício de ser completamente integrado com o Xcode, tornando o trabalho mais produtivo. Abaixo estão as depedências deste projeto:

* [Alamofire](https://github.com/Alamofire/Alamofire)
* [AlamofireImage](https://github.com/Alamofire/AlamofireImage)
* [SnapKit](https://github.com/SnapKit/SnapKit)
* [SnapshotTesting](https://github.com/pointfreeco/swift-snapshot-testing)
