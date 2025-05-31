*** Variables ***
# URL de la página de  Formulario
${FORM_URL}         https://demoqa.com/automation-practice-form
# Directorio para capturas de pantalla
${SCREENSHOT_DIR}   ../../Results/Screenshots/Formulario
# Form Fields
${FIRST_NAMES}            xpath=//*[@id="firstName"]
${LAST_NAMES}             xpath=//*[@id="lastName"]
${EMAILS}                 xpath=//*[@id="userEmail"]
${MOBILE_NUMBERS}         xpath=//*[@id="userNumber"]
${DATE_OF_BIRTHS}         xpath=//*[@id="dateOfBirthInput"]
${SUBJECTS_INPUT}        xpath=//*[@id="subjectsContainer"]
${CURRENT_ADDRESS}       xpath=//*[@id="currentAddress"]
${UPLOAD_PICTURE}        xpath=//*[@id="uploadPicture"]
${SUBMIT_BUTTON}         xpath=//*[@id="submit"]
${CLOSE_MODAL}           xpath=//*[@id="closeLargeModal"]

# Gender Radio Buttons (clickable labels)
${GENDER_MALES}           xpath=//*[@id="genterWrapper"]/div[2]/div[1]/label
${GENDER_FEMALES}         xpath=//*[@id="genterWrapper"]/div[2]/div[2]/label
${GENDER_OTHERS}          xpath=//*[@id="genterWrapper"]/div[2]/div[3]/label

# Hobbies Checkboxes (clickable labels)
${HOBBY_SPORTS}          xpath=//*[@id="hobbiesWrapper"]/div[2]/div[1]/label
${HOBBY_READING}         xpath=//*[@id="hobbiesWrapper"]/div[2]/div[2]/label
${HOBBY_MUSIC}           xpath=//*[@id="hobbiesWrapper"]/div[2]/div[3]/label

# State and City Dropdowns
${STATE_DROPDOWN}        xpath=//div[@id='state']
${CITY_DROPDOWN}         xpath=//div[@id='city']

# Confirmation Modal
${MODAL_TABLE}           xpath=//div[@class='table-responsive']//table
${MODAL_ROW}             xpath=/html/body/div[4]/div/div/div[2]/div/table/tbody/tr

*** Keywords ***
Open Browser To Form
    Open Browser    ${FORM_URL}    Chrome
    Maximize Browser Window
    # Elimina el anuncio inferior 
    Execute JavaScript    document.getElementById("fixedban").remove();
    Execute JavaScript    window.scrollTo(0, 400)
