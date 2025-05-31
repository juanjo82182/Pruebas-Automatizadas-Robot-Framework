*** Settings ***
# Documentación de la prueba para interactuar con text box
Documentation    Prueba para interactuar con los text box en demoqa.com
# Importa librerías necesarias
Library    SeleniumLibrary
Library    DataDriver    file=../Resources/Data/textbox_data.csv   
Library    ScreenCapLibrary
Library    AutoRecorder  

# Importa recursos de locadores y keywords
Resource    ../Resources/Locator/Locator_textbox.robot
Resource    ../Keywords/keywords_textbox.robot
# Usa template para iterar sobre el CSV
Test Template    Test Text Box Submission

*** Test Cases ***
# Caso de prueba vacío para que DataDriver proporcione los datos
Test Text Box ${Caso}

*** Keywords ***
# Keyword para ejecutar el envio y verificar los campos
Test Text Box Submission
    [Arguments]      ${Full_Name}    ${Email}    ${Current_Address}    ${Permanent_Address}    ${Esperado_Name}    ${Esperado_Email}    ${Esperado_Current_Address}    ${Esperado_Permanent_Address}  ${Caso}
    # Abre la página
    Open Browser To Text Box Page
    # Completa el formulario y hace submit
    Fill Text Box Form     ${Full_Name}    ${Email}    ${Current_Address}    ${Permanent_Address}   ${Caso}
    # Verifica los resultados y captura de pantalla
    Verify Text Box Results    ${Esperado_Name}    ${Esperado_Email}    ${Esperado_Current_Address}    ${Esperado_Permanent_Address}
    Take Screenshot    filename=${SCREENSHOT_DIR}/verified_${Caso}.png
    # Pausa para observar el resultado
    Sleep    5s
    Close Browser
