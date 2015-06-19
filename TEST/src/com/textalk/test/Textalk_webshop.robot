*** Settings ***
Suite Teardown    Close Browser
Test Teardown
Library           Selenium2Library
Library           OperatingSystem
Library           String
Library           Collections
Library           OperatingSystem
Library           String

*** Variables ***
${REMOTE_URL}     http://prassana4:x51rXBGQM7ZMC3Xm5S7p@hub.browserstack.com/wd/hub
${DESIRED_CAPABILITIES}    name:Testing RobotFramework,browser:Chrome, browser_version: 35.0, os: Windows, os_version: 7, resolution: 1024x768 , browserstack.debug:true

*** Test Cases ***
LOGIN_Webshop
    Open Browser    http://shop.textalk.se/    chrome    \    remote_url=${REMOTE_URL}    desired_capabilities=${DESIRED_CAPABILITIES}
    log    webpage opened
    Maximize Browser Window
    Click Element    xpath=.//*[@id='menu-item-9308']/a    #login
    Wait Until Element Is Visible    loginform_username    5
    Input Text    loginform_username    krutofv    #username
    Input Text    name=password    12345    #password
    Click Element    css=input.button    #login button
    Title Should Be    Textalk Webshop
    Click Element    xpath=.//*[@id='logout']

LOGIN_DIVERSITY
    Open Browser    http://qatest.shop.textalk.se/    chrome    \    #remote_url=${REMOTE_URL}    desired_capabilities=${DESIRED_CAPABILITIES}
    log    webpage opened
    Maximize Browser Window
    Goto Login Dialog    #GotologinDialog used as link & button in different area
    Enter UserName    testwebshop
    Enter Password    12345
    Click LoginButton
    Title Should Be    Demobutik.com
    GotoArticle    In hac habitasse
    Select Articlenr    kv_5614681
    Write A Text    Demo Text
    IncreaseQuantity
    AddToCart
    Proceed To Checkout
    Checkout

*** Keywords ***
Scroll Page To Location
    [Arguments]    ${x_location}    ${y_location}
    Execute JavaScript    window.scrollTo(${x_location},${y_location})

Enter UserName
    [Arguments]    ${username}
    Input Text    inputUsername    ${username}

Enter Password
    [Arguments]    ${password}
    Input Text    inputPassword    ${password}

Click LoginButton
    Click Element    xpath=(//button[@ng-click='login()'])
    Comment    Set Selenium Implicit Wait    5
    Sleep    5

Goto Login Dialog
    Click Link    Logga in

GotoArticle
    [Arguments]    ${articleName}
    Click Element    //h5/a[contains(text(),'${articleName}')]    #View Article //div/div[4]/div/div[2]/div

Select Articlenr
    [Arguments]    ${subArticleNumber}
    Wait Until Element Is Visible    //div[3]/div[3]/div    3
    Click Element    //div[@class='variant-article-nr ng-binding ng-scope' and .//text()='kv_56812']    #sub Article list

Write A Text
    [Arguments]    ${writeText}
    Input Text    1198023    ${writeText}    #Customer choice text

IncreaseQuantity
    Click Element    xpath=(//button[@ng-click='inc()'])    #increase item quantity

DecreaseQuantity
    Click Element    xpath=(//button[@ng-click='dec()'])    #decrease item quantity

AddToCart
    Click Element    xpath=(//button[@ng-click='buy(articleChoices)'])    #Addto cart

Proceed To Checkout
    Wait Until Element Is Visible    xpath=(//a[@class='btn btn-primary ng-binding'])    3
    Click Element    xpath=(//a[@class='btn btn-primary ng-binding'])    #Proceed to checkout

Checkout
    Wait Until Element Is Visible    xpath=(//button[@class='btn btn-primary btn-block ladda-button'])    3
    Click Element    xpath=(//button[@class='btn btn-primary btn-block ladda-button'])    #checkout now
