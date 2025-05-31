*** Variables ***
# URL de la página de checkboxes
${PAGE_URL}         https://demoqa.com/checkbox
# Directorio para capturas de pantalla
${SCREENSHOT_DIR}   ../../Results/Screenshots/CheckBox
# Locator para el contenedor de resultados
${RESULT_CONTAINER}  xpath=//*[@id="result"]
# Locators para botones de expansión de nodos
${EXPAND_HOME}        xpath=//*[@id="tree-node"]/ol/li/span/button
${EXPAND_DESKTOP}     xpath=//*[@id="tree-node"]/ol/li/ol/li[1]/span/button
${EXPAND_DOCUMENTS}   xpath=//*[@id="tree-node"]/ol/li/ol/li[2]/span/button  
${EXPAND_DOWNLOADS}   xpath=//*[@id="tree-node"]/ol/li/ol/li[3]/span/button  
${EXPAND_WORKSPACE}   xpath=//*[@id="tree-node"]/ol/li/ol/li[2]/ol/li[1]/span/button
${EXPAND_OFFICE}      xpath=//*[@id="tree-node"]/ol/li/ol/li[2]/ol/li[2]/span/button
# Locators para checkboxes específicos
${CHECKBOX_HOME}        xpath=//*[@id="tree-node"]/ol/li/span/label
${CHECKBOX_DESKTOP}     xpath=//*[@id="tree-node"]/ol/li/ol/li[1]/span/label
${CHECKBOX_DOCUMENTS}   xpath=//*[@id="tree-node"]/ol/li/ol/li[2]/span/label
${CHECKBOX_DOWNLOADS}   xpath=//*[@id="tree-node"]/ol/li/ol/li[3]/span/label
${CHECKBOX_WORKSPACE}   xpath=//*[@id="tree-node"]/ol/li/ol/li[2]/ol/li[1]/span/label
${CHECKBOX_OFFICE}      xpath=//*[@id="tree-node"]/ol/li/ol/li[2]/ol/li[2]/span/label
${CHECKBOX_NOTES}       xpath=//*[@id="tree-node"]/ol/li/ol/li[1]/ol/li[1]/span/label
${CHECKBOX_COMMANDS}    xpath=//*[@id="tree-node"]/ol/li/ol/li[1]/ol/li[2]/span/label
${CHECKBOX_REACT}       xpath=//*[@id="tree-node"]/ol/li/ol/li[2]/ol/li[1]/ol/li[1]/span/label
${CHECKBOX_ANGULAR}     xpath=//*[@id="tree-node"]/ol/li/ol/li[2]/ol/li[1]/ol/li[2]/span/label
${CHECKBOX_VUE}         xpath=//*[@id="tree-node"]/ol/li/ol/li[2]/ol/li[1]/ol/li[3]/span/label
${CHECKBOX_PUBLIC}      xpath=//*[@id="tree-node"]/ol/li/ol/li[2]/ol/li[2]/ol/li[1]/span/label
${CHECKBOX_PRIVATE}     xpath=//*[@id="tree-node"]/ol/li/ol/li[2]/ol/li[2]/ol/li[2]/span/label
${CHECKBOX_CLASSIFIED}  xpath=//*[@id="tree-node"]/ol/li/ol/li[2]/ol/li[2]/ol/li[3]/span/label
${CHECKBOX_GENERAL}     xpath=//*[@id="tree-node"]/ol/li/ol/li[2]/ol/li[2]/ol/li[4]/span/label
${CHECKBOX_WORD_FILE}   xpath=//*[@id="tree-node"]/ol/li/ol/li[3]/ol/li[1]/span/label
${CHECKBOX_EXCEL_FILE}  xpath=//*[@id="tree-node"]/ol/li/ol/li[3]/ol/li[2]/span/label

*** Keywords ***
# Keyword para abrir el navegador y preparar la página
Open Browser To Checkbox Page
    # Abre el navegador Chrome y navega a la URL
    Open Browser    ${PAGE_URL}    Chrome
    # Maximiza la ventana del navegador
    Maximize Browser Window
    # Elimina el anuncio inferior para evitar obstrucciones
    Execute JavaScript    document.getElementById("fixedban").remove();
    Execute JavaScript    window.scrollTo(0, 300)