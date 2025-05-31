*** Keywords ***
# Interactúa con los checkboxes: expande nodos, selecciona checkboxes y verifica resultados
Interact With Checkboxes
    [Arguments]    ${Expand_Nodes}    ${Checkboxes}    ${Esperado_Resultados}    ${Caso}
    # Expande los nodos especificados si no están vacíos
    Run Keyword If    '${Expand_Nodes}' != ''    Expand Checkbox Nodes    ${Expand_Nodes}
    # Selecciona los checkboxes especificados si no están vacíos
    Run Keyword If    '${Checkboxes}' != ''    Select Checkboxes    ${Checkboxes}
    # Captura de pantalla después de interactuar con los checkboxes
    Take Screenshot    filename=${SCREENSHOT_DIR}/CheckBox_${Caso}.png
    Execute JavaScript    window.scrollTo(0, 400)
    # Verifica los resultados esperados
    Verify Checkbox Results    ${Esperado_Resultados}

# Expande los nodos especificados en la lista, respetando la jerarquía
Expand Checkbox Nodes
    [Arguments]    ${Nodes}
    # Siempre expande 'home' primero
    Click Element    ${EXPAND_HOME}
    # Divide la lista de nodos en elementos individuales
    @{node_list}=    Split String    ${Nodes}    ,
    # Itera sobre cada nodo y lo expande si es necesario
    FOR    ${node}    IN    @{node_list}
        # Normaliza el nombre del nodo para coincidir con el locator
        ${node_clean}=    Evaluate    $node.strip().lower().replace(' ', '')
        # Determina los nodos padres necesarios según la jerarquía
        ${parent_nodes}=    Get Parent Nodes    ${node_clean}
        # Expande los nodos padres en orden
        FOR    ${parent}    IN    @{parent_nodes}
            ${parent_locator}=    Set Variable    ${EXPAND_${parent.upper()}}
            # Expande el nodo padre si está presente
            Run Keyword If    '${parent_locator}' != '${EMPTY}'    Click Element    ${parent_locator}
        END
        # Construye el locator del nodo actual
        ${node_locator}=    Set Variable    ${EXPAND_${node_clean.upper()}}
        # Expande el nodo actual si está definido
        Run Keyword If    '${node_locator}' != '${EMPTY}'    Click Element    ${node_locator}
    END
    

# Determina los nodos padres necesarios para un nodo dado
Get Parent Nodes
    [Arguments]    ${node}
    # Define la jerarquía de nodos padres según el nodo objetivo
    ${parents}=    Run Keyword If    '${node}' in ('workspace', 'office')    Create List      documents   
    ...    ELSE IF    '${node}' in ('notes', 'commands')    Create List        desktop
    ...    ELSE IF    '${node}' in ('react', 'angular', 'veu')    Create List       documents    workspace
    ...    ELSE IF    '${node}' in ('public', 'private', 'classified', 'general')    Create List       documents    office
    ...    ELSE IF    '${node}' in ('wordfile', 'excelfile')    Create List       downloads
    ...    ELSE    Create List
    RETURN     ${parents}

# Selecciona los checkboxes especificados en la lista
Select Checkboxes
    [Arguments]    ${Checkboxes}
    # Divide la lista de checkboxes en elementos individuales
    @{checkbox_list}=    Split String    ${Checkboxes}    ,
    # Itera sobre cada checkbox y lo selecciona
    FOR    ${checkbox}    IN    @{checkbox_list}
        # Normaliza el nombre del checkbox para coincidir con el locator
        ${checkbox_clean}=    Evaluate    $checkbox.strip().lower().replace(' ', '').replace('.doc', '')
        # Construye el locator dinámicamente
        ${checkbox_locator}=    Set Variable    ${CHECKBOX_${checkbox_clean.upper()}}
        # Selecciona el checkbox
        Click Element    ${checkbox_locator}
    END

# Verifica los resultados mostrados en la página
Verify Checkbox Results
    [Arguments]    ${Esperado_Resultados}
    ${formatted_expected}=    Evaluate    'You have selected :\\n' + '\\n'.join('${Esperado_Resultados}'.split())
    # Si no se esperan resultados, verifica que el contenedor de resultados no esté visible
    Run Keyword If    '${Esperado_Resultados}' == 'none'
    ...    Element Should Not Be Visible    ${RESULT_CONTAINER}
    # Si hay resultados esperados, verifica que se muestren correctamente
    Run Keyword If    '${Esperado_Resultados}' != 'none'
    ...    Wait Until Element Contains    ${RESULT_CONTAINER}    ${formatted_expected}     timeout=15s 
