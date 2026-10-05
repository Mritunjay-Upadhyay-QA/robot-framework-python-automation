*** Settings ***
Library     RequestsLibrary
Resource    ../common/config.resource


*** Keywords ***
Get All Booking Ids
    [Documentation]    Retrieves all booking IDs from Restful Booker.

    ${response}=    GET
    ...    ${API_BASE_URL}/booking
    ...    expected_status=200

    RETURN    ${response}