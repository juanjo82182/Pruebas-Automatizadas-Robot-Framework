*** Settings ***
# Documentación de la prueba para interactuar con radio buttons
Documentation    Prueba para interactuar con los radio buttons en demoqa.com
# Importa librerías necesarias
Library    SeleniumLibrary
Library    DataDriver    file=../Resources/Data/radio_data.csv   
Library    ScreenCapLibrary
Library    AutoRecorder  

# Importa recursos de locadores y keywords
Resource    ../Resources/Locator/Locator_radiobuttons.robot
Resource    ../Keywords/keywords_radiobuttons.robot
# Usa template para iterar sobre el CSV
Test Template    Test Radio Button Selection

*** Test Cases ***
# Caso de prueba vacío para que DataDriver proporcione los datos
Test Radio Button ${Radio}

*** Keywords ***
# Keyword para ejecutar la selección y verificación de cada radio button
Test Radio Button Selection
    [Arguments]    ${Radio}    ${Mensaje Esperado}
    # Abre la página
    Open Browser To Radio Button Page
    # Selecciona el radio button especificado
    Select Radio Button    ${Radio}
    # Verifica que el mensaje sea el esperado y captura pantalla
    Verify Selection Message    ${Mensaje Esperado}
    Take Screenshot    filename=${SCREENSHOT_DIR}/verified_${Radio}.png
    # Pausa para observar el resultado
    Sleep    5s
    Close Browser