*** Settings ***
Resource    ../../../resources/common/config.resource
Resource    ../../../resources/pages/login_page.resource
Resource    ../../../resources/variables/users.resource

Test Setup       Open Login Page
Test Teardown    Close Test Browser


*** Test Cases ***
Valid User Can Login
    [Tags]    smoke    web    positive    login

    Login With Credentials    ${STANDARD_USERNAME}    ${STANDARD_PASSWORD}
    Verify Successful Login


Invalid User Cannot Login
    [Tags]    regression    web    negative    login

    Login With Credentials    ${INVALID_USERNAME}    ${INVALID_PASSWORD}
    Verify Login Error    ${INVALID_ERROR}


Locked User Cannot Login
    [Tags]    regression    web    negative    login

    Login With Credentials    ${LOCKED_USERNAME}    ${STANDARD_PASSWORD}
    Verify Login Error    ${LOCKED_ERROR}