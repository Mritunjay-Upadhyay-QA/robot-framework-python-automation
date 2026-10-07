*** Settings ***
Library     Browser
Resource    ../common/config.resource


*** Variables ***
${USERNAME_INPUT}           css=[data-test="username"]
${PASSWORD_INPUT}           css=[data-test="password"]
${LOGIN_BUTTON}             css=[data-test="login-button"]
${LOGIN_ERROR}              css=[data-test="error"]
${PRODUCTS_PAGE_TITLE}      css=.title


*** Keywords ***
Open Login Page
    [Documentation]    Opens the configured SauceDemo environment.
    New Browser    ${BROWSER}    headless=${HEADLESS}
    New Page    ${BASE_URL}


Login With Credentials
    [Documentation]    Attempts login using the supplied username and password.
    [Arguments]    ${username}    ${password}

    Fill Text    ${USERNAME_INPUT}    ${username}
    Fill Text    ${PASSWORD_INPUT}    ${password}
    Click    ${LOGIN_BUTTON}


Verify Successful Login
    [Documentation]    Verifies that login successfully navigated to the Products page.

    Get Url    *=    inventory.html
    Get Text    ${PRODUCTS_PAGE_TITLE}    ==    Products


Verify Login Error
    [Documentation]    Verifies the expected login error.
    [Arguments]    ${expected_error}

    Get Text    ${LOGIN_ERROR}    ==    ${expected_error}


Close Test Browser
    [Documentation]    Closes the browser after test execution.
    Close Browser