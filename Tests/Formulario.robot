*** Settings ***
# Documentación de la prueba para interactuar con formulario
Documentation    Prueba para llenar formulario en demoqa.com
# Importa librerías necesarias
Library    SeleniumLibrary
Library    DataDriver    file=../Resources/Data/formulario_data.csv  
Library    String
Library    ScreenCapLibrary
Library    AutoRecorder
# Importa recursos de locadores y keywords
Resource    ../Resources/Locator/locator_formulario.robot
Resource    ../Keywords/Keywords_formulario.robot
# Usa template para iterar sobre el CSV
Test Template     Submit Form And Verify

*** Test Cases ***
Test Formulario ${Caso}

*** Keywords ***
# Keyword para interactuar con el Formulario de prueba
Submit Form And Verify
    [Arguments]     ${Caso}    ${First_Name}    ${Last_Name}    ${Email}    ${Gender}    ${Mobile}    ${Day}    ${Month}    ${Year}    ${Subjects}    ${Hobbies}    ${Picture}    ${Current_Address}    ${State}    ${City}    ${Esperado_Student_Name}    ${Esperado_Email}    ${Esperado_Gender}    ${Esperado_Mobile}    ${Esperado_Date_of_Birth}    ${Esperado_Subjects}    ${Esperado_Hobbies}    ${Esperado_Picture}    ${Esperado_Address}    ${Esperado_State_and_City}
    # Abre la página
    Open Browser To Form
    # Ejecuta la acción según el valor de Acción
    Fill Personal Details    ${First_Name}    ${Last_Name}    ${Email}    ${Mobile}
    Select Gender    ${Gender}
    Set Date Of Birth By Picker    ${Day}    ${Month}    ${Year} 
    Add Subjects    ${Subjects}
    # Tomar screenshot 
    Take Screenshot    filename=${SCREENSHOT_DIR}/Formulario1_${Caso}.png
    Select Hobbies    ${Hobbies}
    Upload Picture    ${Picture}
    Fill Address    ${Current_Address}
    Select State And City    ${State}    ${City}
    # Tomar screenshot 
    Take Screenshot    filename=${SCREENSHOT_DIR}/Formulario2_${Caso}.png
    Submit Form
    # Tomar screenshot 
    Take Screenshot    filename=${SCREENSHOT_DIR}/Formulario3_${Caso}.png
    Verify Form Submission    ${Esperado_Student_Name}    ${Esperado_Email}    ${Esperado_Gender}    ${Esperado_Mobile}    ${Esperado_Date_of_Birth}    ${Esperado_Subjects}    ${Esperado_Hobbies}    ${Esperado_Picture}    ${Esperado_Address}    ${Esperado_State_and_City}
    # Pausa para observación 
    Sleep    5s
    # Cierra el navegador
    Close Browser