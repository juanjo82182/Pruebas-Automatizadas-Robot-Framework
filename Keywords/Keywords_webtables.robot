*** Keywords ***
Add New Row
  [Arguments]    ${first_name}    ${last_name}    ${age}    ${email}    ${salary}    ${department}
  Click Element    ${ADD_BUTTON}
  Input Text       ${INPUT_FIRST_NAME}    ${first_name}
  Input Text       ${INPUT_LAST_NAME}     ${last_name}
  Input Text       ${INPUT_EMAIL}         ${email}
  Input Text       ${INPUT_AGE}           ${age}
  Input Text       ${INPUT_SALARY}        ${salary}
  Input Text       ${INPUT_DEPARTMENT}    ${department}
  Click Element    ${SUBMIT_BUTTON}

Find Row By Name
  # Busca una fila en la tabla por nombre y apellido, devolviendo la fila y su índice
  [Arguments]    ${first_name}    ${last_name}
  ${rows}=       Get WebElements       ${TABLE_ROWS}
  ${index}=      Set Variable    1
  FOR    ${row}    IN    @{rows}
    ${cells}=    Get WebElements    xpath=(//div[@class='rt-tbody']//div[@role='row'])[${index}]//div[@role='gridcell']
    ${fn}=       Get Text    ${cells}[0]
    ${ln}=       Get Text    ${cells}[1]
    ${fn}=       Strip String    ${fn}
    ${ln}=       Strip String    ${ln}
    ${first_name}=    Strip String    ${first_name}
    ${last_name}=     Strip String    ${last_name}
    Run Keyword If    '${fn}' == '${first_name}' and '${ln}' == '${last_name}'    Return From Keyword    ${row}    ${index}
    ${index}=    Evaluate    ${index} + 1
  END
  Fail    Fila no encontrada

Edit Row
  # Edita una fila existente con nuevos datos
  [Arguments]    ${target_first_name}  ${target_last_name}  ${new_first_name}  ${new_last_name}  ${new_age}  ${new_email}  ${new_salary}  ${new_department}
  ${row}    ${index}=    Find Row By Name    ${target_first_name}  ${target_last_name}
  Click Element    xpath=//*[@id="edit-record-${index}"]
  Input Text       ${INPUT_FIRST_NAME}   ${new_first_name}
  Input Text       ${INPUT_LAST_NAME}    ${new_last_name}
  Input Text       ${INPUT_AGE}          ${new_age}
  Input Text       ${INPUT_EMAIL}        ${new_email}
  Input Text       ${INPUT_SALARY}       ${new_salary}
  Input Text       ${INPUT_DEPARTMENT}   ${new_department}
  Click Element    ${SUBMIT_BUTTON}

Delete Row
  # Elimina una fila de la tabla por nombre y apellido
  [Arguments]    ${first_name}  ${last_name}
  ${row}    ${index}=    Find Row By Name    ${first_name}  ${last_name}
  Click Element    xpath=//*[@id="delete-record-${index}"]

# Verifica si existe una fila con todos los datos exactamente iguales
Verify Row Exists
  # Verifica que exista una fila con los datos exactos proporcionados
  [Arguments]    ${first_name}  ${last_name}  ${age}  ${email}  ${salary}  ${department}
  ${rows}=       Get WebElements       ${TABLE_ROWS}
  ${index}=      Set Variable    1
  FOR    ${row}    IN    @{rows}
    ${cells}=    Get WebElements       xpath=(//div[@class='rt-tbody']//div[@role='row'])[${index}]//div[@role='gridcell']
    ${fn}=       Get Text    ${cells}[0]
    ${ln}=       Get Text    ${cells}[1]
    ${a}=        Get Text    ${cells}[2]
    ${e}=        Get Text    ${cells}[3]
    ${s}=        Get Text    ${cells}[4]
    ${d}=        Get Text    ${cells}[5] 
    Run Keyword If    '${fn}' == '${first_name}' and '${ln}' == '${last_name}' and '${a}' == '${age}' and '${e}' == '${email}' and '${s}' == '${salary}' and '${d}' == '${department}'    Return From Keyword
    ${index}=    Evaluate    ${index} + 1
  END
  Fail    Fila no encontrada con los datos esperados

Verify Row Does Not Exist
  # Verifica que una fila no exista en la tabla por nombre y apellido
  [Arguments]    ${first_name}  ${last_name}
  ${rows}=       Get WebElements       ${TABLE_ROWS}
  ${index}=      Set Variable    1
  FOR    ${row}    IN    @{rows}
    ${cells}=    Get WebElements    xpath=(//div[@class='rt-tbody']//div[@role='row'])[${index}]//div[@role='gridcell']
    ${fn}=       Get Text    ${cells}[0]
    ${ln}=       Get Text    ${cells}[1]
    ${fn}=       Strip String    ${fn}
    ${ln}=       Strip String    ${ln}
    ${first_name}=    Strip String    ${first_name}
    ${last_name}=     Strip String    ${last_name}
    Run Keyword If    '${fn}' == '${first_name}' and '${ln}' == '${last_name}'    Fail    La fila aún existe
    ${index}=    Evaluate    ${index} + 1
  END   

Search Table
  # Realiza una búsqueda en la tabla y verifica que el término esté en alguna celda
  [Arguments]    ${search_term}
  Input Text     ${SEARCH_BOX}         ${search_term}
  ${rows}=       Get WebElements       ${TABLE_ROWS}
  ${index}=      Set Variable    1
  Sleep          3s
  FOR    ${row}    IN    @{rows}
    ${cells}=    Get WebElements       xpath=(//div[@class='rt-tbody']//div[@role='row'])[${index}]//div[@role='gridcell']
    ${fn}=       Get Text    ${cells}[0]
    ${ln}=       Get Text    ${cells}[1]
    ${a}=        Get Text    ${cells}[2]
    ${e}=        Get Text    ${cells}[3]
    ${s}=        Get Text    ${cells}[4]
    ${d}=        Get Text    ${cells}[5]
    Run Keyword If     '${search_term}' == '${fn}' or '${search_term}' == '${ln}' or '${search_term}' == '${a}' or '${search_term}' == '${e}' or '${search_term}' == '${s}' or '${search_term}' == '${d}'   Return From Keyword  
    ${index}=    Evaluate    ${index} + 1
  END
  Fail    No se encontro ninguna fila

Interact With WebTables
  # Ejecuta acciones en la tabla según los parámetros y verifica resultados
  [Arguments]    ${action}    ${parameters_str}    ${expected_str}    ${caso}
  ${params}=    Run Keyword If    isinstance($parameters_str, list)    Evaluate    ','.join($parameters_str)    ELSE    Set Variable    ${parameters_str}
  ${expected}=    Run Keyword If    isinstance($expected_str, list)    Evaluate    ','.join($expected_str)    ELSE    Set Variable    ${expected_str}
  ${params}=    Split String    ${params}    ,
  ${expected}=    Split String    ${expected}    ,
  Run Keyword If    '${action}' == 'add'    Add New Row    ${params}[0]    ${params}[1]    ${params}[2]    ${params}[3]    ${params}[4]    ${params}[5]
  ...    ELSE IF    '${action}' == 'edit'    Edit Row    ${params}[0]    ${params}[1]    ${params}[2]    ${params}[3]    ${params}[4]    ${params}[5]    ${params}[6]    ${params}[7]
  ...    ELSE IF    '${action}' == 'delete'    Delete Row    ${params}[0]    ${params}[1]
  ...    ELSE IF    '${action}' == 'search'    Search Table    ${params}[0] 
  Take Screenshot    filename=${SCREENSHOT_DIR}/WebTable_${Caso}.png
  Run Keyword If    '${action}' == 'add' or '${action}' == 'edit'    Verify Row Exists    ${expected}[0]    ${expected}[1]    ${expected}[2]    ${expected}[3]    ${expected}[4]    ${expected}[5]
  ...    ELSE IF    '${action}' == 'delete' and '${expected}[0]' == 'none'    Verify Row Does Not Exist    ${params}[0]    ${params}[1]