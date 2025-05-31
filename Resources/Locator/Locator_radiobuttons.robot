*** Variables ***
# URL de la página de radio buttons
${PAGE_URL}         https://demoqa.com/radio-button
# Directorio para capturas de pantalla
${SCREENSHOT_DIR}   ../../Results/Screenshots/RadioButtons
# Locador para el radio button "Yes" usando el label, más confiable para clicar
${RADIO_YES}        xpath=//*[@id="app"]/div/div/div/div[2]/div[2]/div[2]/label 
# Locador para el radio button "Impressive" usando el label
${RADIO_IMPRESSIVE}  xpath=//*[@id="app"]/div/div/div/div[2]/div[2]/div[3]/label
# Locador para el mensaje de resultado
${RESULT_MESSAGE}   xpath=//*[@id="app"]/div/div/div/div[2]/div[2]/p

*** Keywords ***
# Abre el navegador y maximiza la ventana
Open Browser To Radio Button Page
    Open Browser    ${PAGE_URL}    Chrome
    Maximize Browser Window
    # Desplaza la página para asegurar que los radio buttons sean visibles y elimina el anuncio inferior
    Execute JavaScript    document.getElementById("fixedban").remove();
    Execute JavaScript    window.scrollTo(0, 200)
   
   