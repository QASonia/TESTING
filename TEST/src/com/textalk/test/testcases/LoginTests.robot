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
Resource          ../pageresource/ArticlePage.txt
Resource          ../setup/GenericTestAficionado.txt
Resource          ../setup/Assertions.txt    # DiversityWebClientTests/src/com/textalk/test/setup/Assertions.txt
Resource          ../pageresource/HomePage.txt
Library           ../setup/CSVLibrary.py
Library           OperatingSystem
Library           String

*** Variables ***

*** Test Cases ***
UI Login With Valid Credentials
    [Documentation]    Tests to verify whether the user can be able to login to the accounts successfully.
    [Tags]    C401
    ReadJsonFile    ${FILE_PATH_VALID_LOGIN}
    : FOR    ${case}    IN    @{cases}
    \    json.Dumps    ${case["data_C401"]}
    \    Open Login Dialog
    \    Login Customer    ${case["username"]}    ${case["password"]}
    \    verifyLogin
    \    Logout Customer

UI Login with Invalid Credentials
    [Documentation]    Tests to verify whether the user gets proper error response message during logging into the system.
    [Tags]    C402
    ReadJsonFile    ${FILE_PATH_INVALID_LOGIN}
    Open Login Dialog
    : FOR    ${case}    IN    @{cases}
    \    json.dumps    ${case["data_C402"]}
    \    log    Testing Functionality: ${case["testCaseName"]}
    \    setLoginUsername    ${case["username"]}
    \    setLoginPassword    ${case["password"]}
    \    clickLoginButton
    \    verifyLoginFailure    ${case["response_message"]}

Validate Login Using Browser Back Button
    [Documentation]    Tests to verify whether the user gets proper error response message during logging into the system.
    [Tags]    C403
    ${data}    Load Test Data From Csv File    ${SMOKETESTS_CSV_FILE_PATH}    C403    userName    password
    log    ${data}
    Open Login Dialog
    Login Customer    ${data[0]}    ${data[1]}
    go To    http://qatest.shop.textalk.se/sv/
    Go Back
    go To    http://qatest.shop.textalk.se/en/
    verifyLogin

Check LoginPage Retains
    [Documentation]    Tests to verify the session retains after clicking the 'cancel' button from logout dialog.
    [Tags]    C404
    ${data}    Load Test Data From Csv File    ${SMOKETESTS_CSV_FILE_PATH}    C405    userName    password    responseMessage
    log    ${data}
    Open Login Dialog
    Login Customer    ${data[0]}    ${data[1]}
    Open Logout Dialog
    Close Logout Dialog
    verifyLogin
