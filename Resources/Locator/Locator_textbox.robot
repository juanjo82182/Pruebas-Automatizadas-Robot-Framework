*** Variables ***
# URL de la página de text box
${PAGE_URL}         https://demoqa.com/text-box
# Directorio para capturas de pantalla
${SCREENSHOT_DIR}   ../../Results/Screenshots/TextBox
# Locadores para los campos de entrada
${INPUT_FULL_NAME}           xpath=//*[@id="userName"]
${INPUT_EMAIL}               xpath=//*[@id="userEmail"]
${INPUT_CURRENT_ADDRESS}     xpath=//*[@id="currentAddress-wrapper"]/div[2]//*[@id="currentAddress"]
${INPUT_PERMANENT_ADDRESS}   xpath=//*[@id="permanentAddress-wrapper"]/div[2]//*[@id="permanentAddress"]
${SUBMIT}                    xpath=//*[@id="submit"]
# Locadores para los resultados
${RESULT_NAME}                xpath=//*[@id="output"]/div/p[@id="name"]
${RESULT_EMAIL}               xpath=//*[@id="output"]/div/p[@id="email"]
${RESULT_CURRENT_ADDRESS}     xpath=//*[@id="output"]/div/p[@id="currentAddress"]
${RESULT_PERMANENT_ADDRESS}   xpath=//*[@id="output"]/div/p[@id="permanentAddress"]

*** Keywords ***
# Abre el navegador y maximiza la ventana
Open Browser To Radio Text Box Page
    Open Browser    ${PAGE_URL}    Chrome
    Maximize Browser Window
    # Elimina el anuncio inferior 
    Execute JavaScript    document.getElementById("fixedban").remove();
    
