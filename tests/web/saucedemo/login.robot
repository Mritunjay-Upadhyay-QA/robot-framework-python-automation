*** Settings ***
Resource    ../../../resources/pages/login_page.resource

Test Setup       Open Login Page
Test Teardown    Close Test Browser


*** Variables ***
${VALID_USERNAME}        standard_user
${VALID_PASSWORD}        secret_sauce

${LOCKED_USERNAME}       locked_out_user

${INVALID_USERNAME}      invalid_user
${INVALID_PASSWORD}      invalid_password

${LOCKED_ERROR}          Epic sadface: Sorry, this user has been locked out.
${INVALID_ERROR}         Epic sadface: Username and password do not match any user in this service


*** Test Cases ***
Valid User Can Login
    [Tags]    smoke    web    positive

    Login With Credentials    ${VALID_USERNAME}    ${VALID_PASSWORD}
    Verify Successful Login


Invalid User Cannot Login
    [Tags]    regression    web    negative

    Login With Credentials    ${INVALID_USERNAME}    ${INVALID_PASSWORD}
    Verify Login Error    ${INVALID_ERROR}


Locked User Cannot Login
    [Tags]    regression    web    negative

    Login With Credentials    ${LOCKED_USERNAME}    ${VALID_PASSWORD}
    Verify Login Error    ${LOCKED_ERROR}