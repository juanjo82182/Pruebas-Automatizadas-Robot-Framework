*** Settings ***
# Documentación general de la prueba
Documentation    Prueba para interactuar con los checkboxes en demoqa.com
# Importa librerías necesarias para automatización, manejo de datos, capturas y grabación
Library    SeleniumLibrary
Library    DataDriver    file=../Resources/Data/checkbox_data.csv
Library    String
Library    ScreenCapLibrary
Library    AutoRecorder 
# Importa recursos con locators y keywords personalizados
Resource    ../Resources/Locator/Locator_checkbox.robot
Resource    ../Keywords/Keywords_checkbox.robot
# Define el template para ejecutar casos de prueba basados en el CSV
Test Template    Test Checkbox Interaction

*** Test Cases ***
# Caso genérico que DataDriver llena con los datos del CSV
Test Checkbox ${Caso}

*** Keywords ***
# Keyword para ejecutar la interacción con checkboxes y verificar resultados
Test Checkbox Interaction
    [Arguments]    ${Expand_Nodes}    ${Checkboxes}    ${Esperado_Resultados}    ${Caso}
    # Abre la página de checkboxes
    Open Browser To Checkbox Page
    # Expande nodos, selecciona checkboxes y verifica resultados
    Interact With Checkboxes    ${Expand_Nodes}    ${Checkboxes}    ${Esperado_Resultados}    ${Caso}
    # Pausa para observar el resultado
    Sleep    5s
    # Cierra el navegador
    Close Browser