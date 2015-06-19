*** Settings ***
Suite Setup
Suite Teardown
Test Setup        openQaTestShopPage
Test Teardown     Close Browser
Test Timeout
Library           String
Library           HttpLibrary.HTTP
Library           json
Library           Selenium 2 Library
Library           simplejson
Library           BuiltIn
Resource          ../pageresource/LoginDialog.txt
Resource          ../setup/GenericTestAficionado.txt
Resource          ../setup/Assertions.txt    # DiversityWebClientTests/src/com/textalk/test/setup/Assertions.txt
Resource          ../pageresource/HomePage.txt
Library           ../setup/CSVLibrary.py

*** Variables ***

*** Test Cases ***
Valid_Registration
    [Documentation]    Tests to verify whether the user gets proper error response message during logging into the system.
    [Tags]    C406
    ${data}    Load Test Data From Csv File    ${SMOKETESTS_CSV_FILE_PATH}    C406    newUserName    eMail    newPassword
    ...    retypeNewPassword
    log    ${data}
    Open Login Dialog
    clickRegister
    setLoginUsername    ${data[0]}
    setEmail    ${data[1]}
    setNewPassword    ${data[2]}
    setRetypePassword    ${data[3]}
    clickCreateAccount

Invalid_Registration
    [Tags]    C407
    ReadJsonFile    ${FILE_PATH_INVALID_REGISTRATION}
    Open Login Dialog
    clickRegister
    : FOR    ${case}    IN    @{cases}
    \    json.dumps    ${case["data_C407"]}
    \    log    Testing Functionality: ${case["testCaseName"]}
    \    setLoginUsername    ${case["username"]}
    \    setEmail    ${case["email"]}
    \    setNewPassword    ${case["password"]}
    \    setRetypePassword    ${case["retypePassword"]}
    \    clickCreateAccount
    \    verifyRegistrationFailure    ${case["response_message"]}

Validate Registration Username Field
    Open Login Dialog
    clickRegister
    setLoginUsername    qwertyu
    setEmail    qwertyuiopåqwertyuiopåqwertyuiopåqwertyuiopåqwertyuiopåqwertyuiopåqwertyuiopåqwertyuiopåqwertyuioqwertyuiopåqwertyuiopåqwertyuiopåqwertyuiopåqwertyuiopåqwertyuiopåqwertyuiopåqwertyuiopåqwertyuioqw#,/,&,!påqwertyuiopåyuiopåqwertyuiopå@textalk.se
    setNewPassword    123456789%Â¤-&
    setRetypePassword    123456789%Â¤-&
    clickCreateAccount
    verifyRegistrationFailure    Please enter valid email
