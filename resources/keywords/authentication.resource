*** Settings ***
Resource    ../common/config.resource
Resource    ../pages/login_page.resource
Resource    ../variables/users.resource


*** Keywords ***
Open Products Page As Standard User
    [Documentation]    Opens the configured environment and authenticates as the standard test user.

    Open Login Page
    Login With Credentials    ${STANDARD_USERNAME}    ${STANDARD_PASSWORD}
    Verify Successful Login