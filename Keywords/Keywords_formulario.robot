*** Keywords ***
# Llena los campos de nombre, apellido, email y número de móvil
Fill Personal Details
  [Arguments]    ${first_name}    ${last_name}    ${email}    ${mobile}
  Input Text    ${FIRST_NAMES}      ${first_name}
  Input Text    ${LAST_NAMES}       ${last_name}
  Input Text    ${EMAILS}           ${email}
  Input Text    ${MOBILE_NUMBERS}   ${mobile}

# Selecciona el género usando la etiqueta correspondiente
Select Gender
  [Arguments]    ${gender}
  Run Keyword If    '${gender}' == 'Male'      Click Element    ${GENDER_MALES}
  ...    ELSE IF    '${gender}' == 'Female'    Click Element    ${GENDER_FEMALES}
  ...    ELSE IF    '${gender}' == 'Other'     Click Element    ${GENDER_OTHERS}
  ...    ELSE       Fail    Género inválido: ${gender}

Set Date Of Birth By Picker
    [Arguments]    ${day}    ${month}    ${year}

    Run Keyword If    '${day}' == '' and '${month}' == '' and '${year}' == ''     Return From Keyword
    Click Element    ${DATE_OF_BIRTHS}

    # Seleccionar año
    Select From List By Value    xpath=//select[contains(@class,'react-datepicker__year-select')]    ${year}

    # Seleccionar mes (0-11)
    Select From List By Value    xpath=//select[contains(@class,'react-datepicker__month-select')]    ${month}

    # Seleccionar día (1-31)
    Click Element    xpath=//div[contains(@class,'react-datepicker__day') and not(contains(@class, 'react-datepicker__day--outside-month')) and text()='${day}']


# Añade uno o más asignaturas usando el campo de autocompletado
Add Subjects
    [Arguments]    ${subjects}
    Run Keyword If    '${subjects}' == ''    Return From Keyword
    ${subject_list}=    Split String    ${subjects}    ,
    FOR    ${subject}    IN    @{subject_list}
        ${subject}=    Strip String    ${subject}
        Click Element           xpath=//input[@id="subjectsInput"]
        Sleep                  0.5s
        Press Keys             xpath=//input[@id="subjectsInput"]    ${subject}
        Sleep                  1s    # Esperar a que aparezcan sugerencias
        Press Keys             xpath=//input[@id="subjectsInput"]    ARROW_DOWN
        Press Keys             xpath=//input[@id="subjectsInput"]    ENTER
        Wait Until Element Is Visible    xpath=//div[contains(@class, 'subjects-auto-complete__multi-value__label') and text()='${subject}']    timeout=5s
    END

# Selecciona uno o más hobbies usando las etiquetas
Select Hobbies
  [Arguments]    ${hobbies}
  Execute JavaScript    window.scrollTo(0, 650)
  Run Keyword If    '${hobbies}' == ''    Return From Keyword
  ${hobby_list}=    Split String    ${hobbies}    ,
  FOR    ${hobby}    IN    @{hobby_list}
    ${hobby}=    Strip String    ${hobby}
    Run Keyword If    '${hobby}' == 'Sports'    Click Element    ${HOBBY_SPORTS}
    ...    ELSE IF    '${hobby}' == 'Reading'   Click Element    ${HOBBY_READING}
    ...    ELSE IF    '${hobby}' == 'Music'     Click Element    ${HOBBY_MUSIC}
    ...    ELSE       Fail    Hobby inválido: ${hobby}
  END

# Sube un archivo de imagen
Upload Picture
  [Arguments]    ${file_path}
  Run Keyword If    '${file_path}' == ''    Return From Keyword
  Choose File    ${UPLOAD_PICTURE}    ${file_path}

# Llena el campo de dirección
Fill Address
  [Arguments]    ${address}
  Input Text    ${CURRENT_ADDRESS}    ${address}  

# Selecciona estado y ciudad desde los desplegables
Select State And City
  [Arguments]    ${state}    ${city}

  Run Keyword If    '${state}' == ''    Return From Keyword
  Click Element    ${STATE_DROPDOWN}
  Sleep    0.5s
  ${state_option}=    Set Variable    xpath=//div[contains(@class,'-option') and text()='${state}']
  Wait Until Element Is Visible    ${state_option}    timeout=5s
  Click Element    ${state_option}

  Click Element    ${CITY_DROPDOWN}
  Sleep    0.5s
  ${city_option}=    Set Variable    xpath=//div[contains(@class,'-option') and text()='${city}']
  Wait Until Element Is Visible    ${city_option}    timeout=5s
  Click Element    ${city_option}


Submit Form
  # Envía el formulario
  Click Element    ${SUBMIT_BUTTON}
  Wait Until Element Is Visible    ${MODAL_TABLE}    timeout=10s

# Verifica los datos en la tabla de confirmación
Verify Form Submission
  [Arguments]    ${esperado_student_name}    ${esperado_email}    ${esperado_gender}    ${esperado_mobile}    ${esperado_date_of_birth}    ${esperado_subjects}    ${esperado_hobbies}    ${esperado_picture}    ${esperado_address}    ${esperado_state_and_city}

  ${name}=          Get Text    xpath=(//div[@class='table-responsive']//table//tbody/tr)[1]/td[2]
  ${email}=         Get Text    xpath=(//div[@class='table-responsive']//table//tbody/tr)[2]/td[2]
  ${gender}=        Get Text    xpath=(//div[@class='table-responsive']//table//tbody/tr)[3]/td[2]
  ${mobile}=        Get Text    xpath=(//div[@class='table-responsive']//table//tbody/tr)[4]/td[2]
  ${dob}=           Get Text    xpath=(//div[@class='table-responsive']//table//tbody/tr)[5]/td[2]
  ${subjects}=      Get Text    xpath=(//div[@class='table-responsive']//table//tbody/tr)[6]/td[2]
  ${hobbies}=       Get Text    xpath=(//div[@class='table-responsive']//table//tbody/tr)[7]/td[2]
  ${picture}=       Get Text    xpath=(//div[@class='table-responsive']//table//tbody/tr)[8]/td[2]
  ${address}=       Get Text    xpath=(//div[@class='table-responsive']//table//tbody/tr)[9]/td[2]
  ${state_city}=    Get Text    xpath=(//div[@class='table-responsive']//table//tbody/tr)[10]/td[2]

  Should Be Equal As Strings    ${name}         ${esperado_student_name}     Error en Student Name
  Should Be Equal As Strings    ${email}        ${esperado_email}            Error en Student Email
  Should Be Equal As Strings    ${gender}       ${esperado_gender}           Error en Gender
  Should Be Equal As Strings    ${mobile}       ${esperado_mobile}           Error en Mobile
  Should Be Equal As Strings    ${dob}          ${esperado_date_of_birth}    Error en Date of Birth
  Should Be Equal As Strings    ${subjects}     ${esperado_subjects}         Error en Subjects
  Should Be Equal As Strings    ${hobbies}      ${esperado_hobbies}          Error en Hobbies
  Should Be Equal As Strings    ${picture}      ${esperado_picture}          Error en Picture
  Should Be Equal As Strings    ${address}      ${esperado_address}          Error en Address
  Should Be Equal As Strings    ${state_city}   ${esperado_state_and_city}   Error en State and City

  Click Element    ${CLOSE_MODAL}