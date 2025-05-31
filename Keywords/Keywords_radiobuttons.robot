*** Keywords ***
# Selecciona el radio button especificado
Select Radio Button
    [Arguments]    ${Radio}
    # Selecciona "Yes" o "Impressive" según el argumento, usando los locadores definidos
    Run Keyword If    '${Radio}' == 'Yes'    Click Element    ${RADIO_YES}
    ...    ELSE IF    '${Radio}' == 'Impressive'    Click Element    ${RADIO_IMPRESSIVE}

# Verifica que el mensaje de selección sea el esperado
Verify Selection Message
    [Arguments]    ${Mensaje Esperado}
    # Espera hasta que el mensaje esperado aparezca en el elemento de resultado
    Wait Until Element Contains    ${RESULT_MESSAGE}    ${Mensaje Esperado}    timeout=5s

    