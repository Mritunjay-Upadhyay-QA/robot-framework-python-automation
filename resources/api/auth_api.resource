*** Settings ***
Library     RequestsLibrary
Library     Collections

Resource    ../common/config.resource


*** Keywords ***
Create Auth Token
    [Documentation]    Creates an authentication token for protected booking operations.

    Should Not Be Empty    ${API_USERNAME}    API_USERNAME must be provided.
    Should Not Be Empty    ${API_PASSWORD}    API_PASSWORD must be provided.

    &{payload}=    Create Dictionary
    ...    username=${API_USERNAME}
    ...    password=${API_PASSWORD}

    ${response}=    POST
    ...    ${API_BASE_URL}/auth
    ...    json=${payload}
    ...    expected_status=200

    ${body}=    Set Variable    ${response.json()}
    Dictionary Should Contain Key    ${body}    token

    ${token}=    Get From Dictionary    ${body}    token
    Should Not Be Empty    ${token}

    RETURN    ${token}
