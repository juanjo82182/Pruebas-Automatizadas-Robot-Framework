*** Settings ***
# Documentación de la prueba para interactuar con la tabla CRUD
Documentation    Prueba para interactuar con la tabla web en demoqa.com
# Importa librerías necesarias
Library    SeleniumLibrary
Library    DataDriver    file=../Resources/Data/webtable_data.csv   
Library    String
Library    ScreenCapLibrary
Library    AutoRecorder 
# Importa recursos de locadores y keywords
Resource    ../Resources/Locator/Locator_webtables.robot
Resource    ../Keywords/keywords_webtables.robot
# Usa template para iterar sobre el CSV
Test Template    Test Web Table Interaction

*** Test Cases ***
# Caso de prueba vacío para que DataDriver proporcione los datos
Test Web Table ${Caso}

*** Keywords ***
# Keyword para interactuar con el CRUD de prueba
Test Web Table Interaction
    [Arguments]      ${Caso}    ${Accion}    ${Parametros}    ${Resultado_Esperado}
    # Abre la página
    Open Browser To web table Page
    # Ejecuta la acción según el valor de Acción
    Interact With WebTables    ${Accion}    ${Parametros}    ${Resultado_Esperado}    ${Caso}
    # Pausa para observación 
    Sleep    5s
    # Cierra el navegador
    Close Browser
