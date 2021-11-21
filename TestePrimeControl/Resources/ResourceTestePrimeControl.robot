*** Settings ***

Library           SeleniumLibrary
Library           ../libs/GetExternalIP.py
Library           ../libs/Logger.py
Library           ../libs/CustomLibraryCR.py

*** Variables ***
${URL}                        https://developer.clashroyale.com
${BROWSER}                    chrome
${LINK_LOGIN}                 xpath=//*[@id="content"]/div/div[2]/div/header/div/div/div[3]/div/a[2]
${TITLE_PAGE}                 Clash Royale API
${EMAIL_LOGIN}                raafita.rad@gmail.com
${SENHA_LOGIN}                \#teste@123
${INPUT_EMAIL_LOGIN}          email
${INPUT_PASSWORD_LOGIN}       password
${SUBMIT_LOGIN}               css=button.ladda-button.btn.btn-primary.btn-lg
${LOGIN_PAGE_LOADED}          css=p.lead
${BUTTON_DROPDOWN_MYACCOUNT}  css=button.btn.btn-default.dropdown-toggle
${LINK_MYACCOUNT}             xpath=//*[@id="content"]/div/div[2]/div/header/div/div/div[3]/div/div/ul/li[1]/a
${CREATE_NEW_KEY}             xpath=//*[@id="content"]/div/div[2]/div/div/section[2]/div/div/div[2]/p/a
${INPUT_KEY_NAME}             name
${INPUT_KEY_NAME_TEXT}        KEY TESTE
${INPUT_DESCRIPTION}          description
${INPUT_DESCRIPTION_TEXT}     Essa é uma chave para teste
${IP_EXTERNO}
${IP_EXTERNO_FIXO}            999.999.999.999
${INPUT_IP_ADDRESSES}         range-0 
${BUTTON_CREATE_KEY}          css=button.ladda-button.btn.btn-primary.btn-lg.btn-block
${MSG_SUCCESS_CREATE_KEY}     css=div.alert.alert-success
${REGISTERED_KEY_ICON}        css=span.dev-site-icon-key.dev-site-icon
${TOKEN}                      xpath=//*[@id="content"]/div/div[2]/div/div/section/div/div/div[2]/form/div[1]/div
${ID_LOCALIZATION}
${AUTHORIZATION}
${INFOS_CLA}
${MEMBER_LIST_CLA}


*** Keywords ***
Acessar o website "${URL}"
    log_info  Acessar o website "${URL}"
    Open Browser    url=${URL}  browser=${BROWSER}
    Maximize Browser Window

Aguardar o carregamento do website "${URL}"
    log_info  Aguardando carregamento do website "${URL}"
    Wait Until Element Is Visible  ${LINK_LOGIN}

Clicar no botão login
    log_info  Clicar no botão de login "${URL}"
    Click Element  ${LINK_LOGIN}

Aguardar o carregamento da tela de login
    log_info  Aguardando página logar
    Wait Until Element Is Visible  ${INPUT_EMAIL_LOGIN}
    log_info  Pagina logada"

Inserir usuário e senha
    log_info  Entrar com E-mail e Senha  also_console=True
    Input Text  ${INPUT_EMAIL_LOGIN}  ${EMAIL_LOGIN}
    Input Text  ${INPUT_PASSWORD_LOGIN}  ${SENHA_LOGIN}

Clicar em login
    log_info  Clicar em login
    Click Element    ${SUBMIT_LOGIN}

Aguardar carregamento de pagina logada
    Wait Until Element Is Visible  ${BUTTON_DROPDOWN_MYACCOUNT} 
    log_info  Pagina logada

Ir até o menu minha conta
    log_info  Acessar o menu minha conta
    Click Element  ${BUTTON_DROPDOWN_MYACCOUNT} 

Aguardar o menu minha conta carregar
    log_info  Aguardar o menu minha conta carregar
    Wait Until Element Is Visible  ${LINK_MYACCOUNT}
    log_info  Menu minha conta carregado

Clicar em minha conta
    log_info  Clicar em minha conta
    Click Element  ${LINK_MYACCOUNT} 

Clicar em criar uma chave 
    log_info  Clicar em criar uma chave
    Click Element   ${CREATE_NEW_KEY}

Inserir KEY NAME
    log_info  Inserir KEY NAME
    Wait Until Element Is Visible  ${INPUT_KEY_NAME}
    Input Text  ${INPUT_KEY_NAME}  ${INPUT_KEY_NAME_TEXT}

Inserir DESCRIPTION
    log_info  Inserir DESCRIPTION
    Input Text  ${INPUT_DESCRIPTION}  ${INPUT_DESCRIPTION_TEXT}

Inserir IP ADDRESSES
    log_info  Inserir IP ADDRESSES
    ${IP_EXTERNO}  get_external_ip  ${IP_EXTERNO_FIXO} 
    Set Test Variable    ${IP_EXTERNO}
    Input Text  ${INPUT_IP_ADDRESSES}  ${IP_EXTERNO} 

Clicar no botão Create Key
    log_info  Clicar no botão Create Key
    Click Element  ${BUTTON_CREATE_KEY}

Validar mensagem de sucesso
    Wait Until Element Is Visible  ${MSG_SUCCESS_CREATE_KEY}
    log_info  Chave criada com sucesso!!!

Clicar na chave
    log_info  Capturar o token da chave cadastrada
    Wait Until Element Is Visible  ${REGISTERED_KEY_ICON}
    Click Element  ${REGISTERED_KEY_ICON}

Capturar o token
    ${AUTHORIZATION}  Get Text  ${TOKEN} 
    Set Test Variable  ${AUTHORIZATION}
    log_debug  Token capturado:
    log_debug  ${AUTHORIZATION}

Capturar id da localizacao
    ${ID_LOCALIZATION}  get_id_localization  ${AUTHORIZATION}  Brazil
    Set Test Variable  ${ID_LOCALIZATION}
    log_debug  ID da localizacao ${ID_LOCALIZATION}

Capturar informacoes do CLA
    log_info  Capturar  informacoes do CLA
    ${INFOS_CLA}  get_info_cla  ${AUTHORIZATION}  The resistance  ${ID_LOCALIZATION}  \#9V2Y
    Set Test Variable  ${INFOS_CLA}

Capturar membros da lista do CLA
    log_info  Capturar membros da lista do CLA
    ${MEMBER_LIST_CLA}  get_member_list_cla  ${AUTHORIZATION}  ${INFOS_CLA}
    Set Test Variable  ${MEMBER_LIST_CLA}

Escrever no CSV
    log_info  Escrever no CSV
    write_csv  ${MEMBER_LIST_CLA}  ../csv/dados.csv

Fechar Navegador
    Close Browser
    log_info  ROBOT FINALIZADO COM SUCESSO!!!