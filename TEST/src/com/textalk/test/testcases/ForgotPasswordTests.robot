*** Settings ***
Suite Setup
Suite Teardown
Test Setup        openQaTestShopPage
Test Teardown     Close Browser
Test Timeout
Library           HttpLibrary.HTTP
Library           json
Library           Selenium 2 Library
Library           simplejson
Resource          ../pageresource/LoginDialog.txt
Resource          ../setup/GenericTestAficionado.txt
Library           ../setup/CSVLibrary.py
Resource          ../setup/Assertions.txt
Library           OperatingSystem
Library           String

*** Variables ***
${FORGOT_PASSWORD_LINK_RESPONSE}    Forgot your password? No problem. Enter in your username or email below and we will send you a reset code.

*** Test Cases ***
Forgot Password Link Check
    [Tags]    C412
    Open Login Dialog
    clickForgotYourPassword
    ${FailureMsg}    Get Text    xpath=(//form/div[1]/div/div[1]/div/p)
    log    Alert Response From UI: ${FailureMsg}
    Should Be Equal As Strings    ${FailureMsg}    ${FORGOT_PASSWORD_LINK_RESPONSE}

Reset Password With Bad Reset Code
    [Tags]    C414
    ${data}    Load Test Data From Csv File    ${SMOKETESTS_CSV_FILE_PATH}    C414    userName    resetCode    newPassword
    ...    retypeNewPassword    responseMessage
    Open Login Dialog
    clickForgotYourPassword
    setLoginUsername    ${data[0]}
    clickSendResetCode
    setResetcode    ${data[1]}
    setNewPassword    ${data[2]}
    setRetypePassword    ${data[3]}
    clickSendResetCode
    verifyLoginFailure    ${data[4]}
