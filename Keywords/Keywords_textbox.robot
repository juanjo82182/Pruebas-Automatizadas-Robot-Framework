*** Keywords ***
# Completa los campos del formulario
Fill Text Box Form
    [Arguments]    ${Full_Name}    ${Email}    ${Current_Address}    ${Permanent_Address}   ${Caso}
    # Completa solo si el valor no está vacío
    Run Keyword If    '${Full_Name}' != ''    Input Text    ${INPUT_FULL_NAME}    ${Full_Name}
    Run Keyword If    '${Email}' != ''        Input Text    ${INPUT_EMAIL}        ${Email}
    Run Keyword If    '${Current_Address}' != ''    Input Text    ${INPUT_CURRENT_ADDRESS}    ${Current_Address}
    Run Keyword If    '${Permanent_Address}' != ''    Input Text    ${INPUT_PERMANENT_ADDRESS}    ${Permanent_Address}
    # Captura de pantalla de formulario lleno
    Take Screenshot    filename=${SCREENSHOT_DIR}/Fill_${Caso}.png
    # Desplaza al fin de pagina
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
    # Hace submit
    Click Element    ${SUBMIT}

# Verifica los resultados mostrados
Verify Text Box Results
    [Arguments]    ${Esperado_Name}    ${Esperado_Email}    ${Esperado_Current_Address}    ${Esperado_Permanent_Address}
    # Verifica presencia o ausencia de cada resultado según el valor esperado
    Run Keyword If    '${Esperado_Name}' != ''    
    ...    Wait Until Element Contains    ${RESULT_NAME}    Name:${Esperado_Name}    timeout=15s
    ...    ELSE    
    ...    Element Should Not Be Visible    ${RESULT_NAME}
    Run Keyword If    '${Esperado_Email}' != ''    
    ...    Wait Until Element Contains    ${RESULT_EMAIL}    Email:${Esperado_Email}    timeout=15s
    ...    ELSE    
    ...    Element Should Not Be Visible    ${RESULT_EMAIL}
    Run Keyword If    '${Esperado_Current_Address}' != ''    
    ...    Wait Until Element Contains    ${RESULT_CURRENT_ADDRESS}    Current Address :${Esperado_Current_Address}    timeout=15s
    ...    ELSE    
    ...    Element Should Not Be Visible    ${RESULT_CURRENT_ADDRESS}
    Run Keyword If    '${Esperado_Permanent_Address}' != ''    
    ...    Wait Until Element Contains    ${RESULT_PERMANENT_ADDRESS}    Permananet Address :${Esperado_Permanent_Address}    timeout=15s
    ...    ELSE    
    ...    Element Should Not Be Visible    ${RESULT_PERMANENT_ADDRESS}
