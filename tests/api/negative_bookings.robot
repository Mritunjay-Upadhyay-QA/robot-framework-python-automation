*** Settings ***
Library     RequestsLibrary

Resource    ${CURDIR}/../../resources/api/booking_api.resource

Test Tags        regression    api    negative
Test Template    Missing Booking Should Return Not Found


*** Test Cases ***
Unknown Booking Id One
    999999999991

Unknown Booking Id Two
    999999999992


*** Keywords ***
Missing Booking Should Return Not Found
    [Documentation]    Verifies that an unknown booking ID returns HTTP 404.
    [Arguments]    ${booking_id}

    ${response}=    Get Booking By Id
    ...    ${booking_id}
    ...    expected_status=404

    Status Should Be    404    ${response}
