*** Settings ***
Suite Setup
Suite Teardown
Test Setup        openQaTestShopPage
Test Teardown     Close Browser
Test Timeout
Library           String
Library           HttpLibrary.HTTP
Library           Selenium 2 Library
Resource          ../pageresource/LoginDialog.txt
Resource          ../pageresource/ArticlePage.txt
Resource          ../pageresource/CartPage.txt
Resource          ../pageresource/CashPage.txt
Resource          ../pageresource/HomePage.txt
Resource          ../pageresource/KlarnaFrame.txt
Resource          ../setup/GenericTestAficionado.txt
Resource          ../setup/Assertions.txt    # DiversityWebClientTests/src/com/textalk/test/setup/Assertions.txt
Library           json
Library           ../setup/CSVLibrary.py

*** Variables ***

*** Test Cases ***
Approved KCO-SWEDEN
    [Tags]    C416s
    ${data}    Load Test Data From Csv File    ${SMOKETESTS_CSV_FILE_PATH}    C416as    promotionItemArticleName    productSize    productColor
    ...    countryName    deliveryMethod    paymentMethod    kEmail    kPostCode    kPersonalNumber
    ...    responseMessage
    log    ${data}
    HomePage.GotoPromotionItem    ${data[0]}
    ArticlePage.selectProductSize    ${data[1]}
    selectProductColor    ${data[2]}
    AddToCart
    Proceed To Checkout
    CartPage.selectCountry    ${data[3]}
    checkout
    CashPage.selectDeliveryMethod    ${data[4]}
    selectPaymentMethod    ${data[5]}
    CashPage.goToKlarnaFrame
    setKEmail    ${data[6]}
    clickKContinue
    setKPostCode    ${data[7]}
    clickKContinue
    setKPersonalNumber    ${data[8]}
    clickKContinue
    Sleep    5
    KPlaceOrder
    verifyKCO_SWEDEN    ${data[9]}

Approved KCO-FINLAND
    [Tags]    C416f
    ${data}    Load Test Data From Csv File    ${SMOKETESTS_CSV_FILE_PATH}    C416af    promotionItemArticleName    productSize    productColor
    ...    countryName    deliveryMethod    paymentMethod    kEmail    kPostCode    responseMessage
    log    ${data}
    HomePage.GotoPromotionItem    ${data[0]}
    ArticlePage.selectProductSize    ${data[1]}
    selectProductColor    ${data[2]}
    AddToCart
    Proceed To Checkout
    CartPage.selectCountry    ${data[3]}
    checkout
    CashPage.selectDeliveryMethod    ${data[4]}
    selectPaymentMethod    ${data[5]}
    CashPage.goToKlarnaFrame
    setKEmail    ${data[6]}
    clickKContinue
    setKPostCode    ${data[7]}
    clickKContinue
    Comment    Sleep    3
    KPlaceOrder
    verifyKCO_FINLAND    ${data[8]}

Approved KCO-NORWAY
    [Tags]    C416n
    ${data}    Load Test Data From Csv File    ${SMOKETESTS_CSV_FILE_PATH}    C416an    promotionItemArticleName    productSize    productColor
    ...    countryName    deliveryMethod    paymentMethod    kEmail    kPostCode    responseMessage
    log    ${data}
    HomePage.GotoPromotionItem    ${data[0]}
    ArticlePage.selectProductSize    ${data[1]}
    selectProductColor    ${data[2]}
    AddToCart
    Proceed To Checkout
    CartPage.selectCountry    ${data[3]}
    checkout
    CashPage.selectDeliveryMethod    ${data[4]}
    selectPaymentMethod    ${data[5]}
    CashPage.goToKlarnaFrame
    setKEmail    ${data[6]}
    clickKContinue
    setKPostCode    ${data[7]}
    clickKContinue
    Comment    Sleep    3
    KPlaceOrder
    verifyKCO_NORWAY    ${data[8]}

Denied KCO-SWEDEN
    [Tags]    C416s
    ${data}    Load Test Data From Csv File    ${SMOKETESTS_CSV_FILE_PATH}    C416ds    promotionItemArticleName    productSize    productColor
    ...    countryName    deliveryMethod    paymentMethod    kEmail    kPostCode    kFirstName
    ...    kLastName    kAddress    kcity    kPhoneNumber    kPersonalNumber    responseMessage
    log    ${data}
    HomePage.GotoPromotionItem    ${data[0]}
    ArticlePage.selectProductSize    ${data[1]}
    selectProductColor    ${data[2]}
    AddToCart
    Proceed To Checkout
    CartPage.selectCountry    ${data[3]}
    checkout
    CashPage.selectDeliveryMethod    ${data[4]}
    selectPaymentMethod    ${data[5]}
    CashPage.goToKlarnaFrame
    setKEmail    ${data[6]}
    clickKContinue
    setKPostCode    ${data[7]}
    clickKContinue
    Comment    setKFirstName    ${data[8]}
    Comment    setKLastName    ${data[9]}
    Comment    setKAddress    ${data[10]}
    Comment    setKCity    ${data[11]}
    Comment    setKPhoneNumber    ${data[12]}
    Comment    clickKContinueOnBilling
    setKPersonalNumber    ${data[13]}
    clickKContinue
    Sleep    5s    Wait for a reply
    KPlaceOrder

Denied KCO-FINLAND
    [Tags]    C416f
    ${data}    Load Test Data From Csv File    ${SMOKETESTS_CSV_FILE_PATH}    C416f    promotionItemArticleName    productSize    productColor
    ...    countryName    deliveryMethod    paymentMethod    kEmail    kPostCode    kFirstName
    ...    kLastName    kAddress    kPhoneNumber    kPersonalNumber    responseMessage
    log    ${data}
    HomePage.GotoPromotionItem    ${data[0]}
    ArticlePage.selectProductSize    ${data[1]}
    selectProductColor    ${data[2]}
    AddToCart
    Proceed To Checkout
    CartPage.selectCountry    ${data[3]}
    checkout
    CashPage.selectDeliveryMethod    ${data[4]}
    selectPaymentMethod    ${data[5]}
    CashPage.goToKlarnaFrame
    setKEmail    ${data[6]}
    clickKContinue
    setKPostCode    ${data[7]}
    clickKContinue
    setKPersonalNumber    ${data[8]}
    clickKContinue
    setKFirstName    ${data[9]}
    setKLastName    ${data[10]}
    setKAddress    ${data[11]}
    setKPhoneNumber    ${data[12]}
    clickKContinueOnBilling
    KPlaceOrder

Denied KCO-NORWAY
    [Tags]    C416g
    ${data}    Load Test Data From Csv File    ${SMOKETESTS_CSV_FILE_PATH}    C416n    promotionItemArticleName    productSize    productColor
    ...    countryName    deliveryMethod    paymentMethod    kEmail    kPostCode    kFirstName
    ...    kLastName    kCareOfName    kAddress    kPhoneNumber    kPersonalNumber    responseMessage
    log    ${data}
    HomePage.GotoPromotionItem    ${data[0]}
    ArticlePage.selectProductSize    ${data[1]}
    selectProductColor    ${data[2]}
    AddToCart
    Proceed To Checkout
    CartPage.selectCountry    ${data[3]}
    checkout
    CashPage.selectDeliveryMethod    ${data[4]}
    selectPaymentMethod    ${data[5]}
    CashPage.goToKlarnaFrame
    setKEmail    ${data[6]}
    clickKContinue
    setKPostCode    ${data[7]}
    clickKContinue
    noPersonalNumber
    setKFirstName    ${data[8]}
    setKLastName    ${data[9]}
    setKCareOfName    ${data[10]}
    setKAddress    ${data[11]}
    setKCity    ${data[12]}
    setKPhoneNumber    ${data[13]}
    clickKContinueOnBilling
    KPlaceOrder

KCO PAYMENT VISIBLE FOR AVAILABLE COUNTRIES
    [Tags]    C417
    HomePage.GotoDemoFavourites    Nam eu nulla
    ArticlePage.AddToCart
    ArticlePage.Proceed To Checkout
    CartPage.selectCountry    India
    CartPage.checkout
    paymentMethodIsNotVisible    Klarna Checkout
    Go Back
    CartPage.selectCountry    Australia
    CartPage.checkout
    paymentMethodIsNotVisible    Klarna Checkout
    Go Back
    CartPage.selectCountry    China
    CartPage.checkout
    paymentMethodIsNotVisible    Klarna Checkout
    Go Back
    CartPage.selectCountry    Sweden
    CartPage.checkout
    paymentMethodIsVisible    Klarna Checkout

KCO PAYMENT NOT SHOWN FOR QUANTITY WITH DECIMAL VALUE
    [Tags]    C419
    HomePage.GotoDemoFavourites    Baby Cap
    ArticlePage.IncreaseQuantity
    ArticlePage.AddToCart
    ArticlePage.Proceed To Checkout
    CartPage.selectCountry    Sweden
    CartPage.checkout
    paymentMethodIsNotVisible    Klarna Checkout

DUMMY
    [Tags]    C417
    ${data}    Load Test Data From Csv File    ../DiversityWebClientTests/src/com/textalk/test/data/web1.csv    C416an    responseMessage
    Open Login Dialog
    setLoginUsername    ${data[0]}
    setLoginPassword    ${data[0]}
