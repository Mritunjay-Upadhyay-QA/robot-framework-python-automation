*** Settings ***
Resource    ${CURDIR}/../../resources/api/auth_api.resource


*** Test Cases ***
Valid Credentials Return Auth Token
    [Tags]    smoke    regression    api    positive    auth

    ${token}=    Create Auth Token

    Should Not Be Empty    ${token}
