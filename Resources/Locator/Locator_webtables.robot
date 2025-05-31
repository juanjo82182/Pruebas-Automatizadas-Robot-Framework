*** Variables ***
# URL de la página de web tables
${PAGE_URL}         https://demoqa.com/webtables
# Directorio para capturas de pantalla
${SCREENSHOT_DIR}   ../../Results/Screenshots/WebTables
# Localizadores para botones y campos del formulario
${ADD_BUTTON}           xpath=//*[@id="addNewRecordButton"]
${SEARCH_BOX}           xpath=//*[@id="searchBox"]
${INPUT_FIRST_NAME}     xpath= //*[@id="firstName"]
${INPUT_LAST_NAME}      xpath=//*[@id="lastName"]
${INPUT_EMAIL}          xpath=//*[@id="userEmail"]
${INPUT_AGE}            xpath=//*[@id="age"]
${INPUT_SALARY}         xpath=//*[@id="salary"]
${INPUT_DEPARTMENT}     xpath=//*[@id="department"]
${SUBMIT_BUTTON}        xpath=//*[@id="submit"]
# Localizador para las filas de la tabla
${TABLE}                xpath=//div[@class='ReactTable']
${TABLE_HEADERS}        xpath=//*[@id="app"]/div/div/div/div[2]/div[2]/div[3]/div[1]/div[1]
${TABLE_ROWS}           xpath=//div[@class='rt-tbody']//div[@role='row']
${TABLE_CELLS}          xpath=//div[@role='gridcell']

*** Keywords ***
# Abre el navegador y maximiza la ventana
Open Browser To web table Page
    Open Browser    ${PAGE_URL}    Chrome
    Maximize Browser Window
    # Elimina el anuncio inferior 
    Execute JavaScript    document.getElementById("fixedban").remove();
    Execute JavaScript    window.scrollTo(0, 300)
