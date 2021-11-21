*** Settings ***
Documentation  Teste Primme Control
Resource    ../Resources/ResourceTestePrimeControl.robot

*** Test Cases ***
Caso de Teste 01: Realizar login no website
    Acessar o website "${URL}"
    Aguardar o carregamento do website "${URL}"
    Clicar no botão login
    Aguardar o carregamento da tela de login
    Inserir usuário e senha
    Clicar em login
    Aguardar carregamento de pagina logada

Caso de Teste 02: Criar uma chave
    Ir até o menu minha conta
    Aguardar o menu minha conta carregar
    Clicar em minha conta
    Clicar em criar uma chave
    Inserir KEY NAME
    Inserir DESCRIPTION
    Inserir IP ADDRESSES
    Clicar no botão Create Key
    Validar mensagem de sucesso

Caso de Teste 03: Obter informações da API
    Clicar na chave
    Capturar o token
    Capturar id da localizacao
    Capturar informacoes do CLA
    Capturar membros da lista do CLA
    Escrever no CSV
    Fechar Navegador

    


