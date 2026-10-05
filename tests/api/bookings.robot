*** Settings ***
Library     Collections

Resource    ${CURDIR}/../../resources/api/booking_api.resource


*** Test Cases ***
User Can Retrieve Booking Ids
    [Tags]    smoke    regression    api    positive

    ${response}=    Get All Booking Ids

    Status Should Be    200    ${response}

    ${bookings}=    Set Variable    ${response.json()}

    Should Not Be Empty    ${bookings}

    ${first_booking}=    Get From List    ${bookings}    0

    Dictionary Should Contain Key    ${first_booking}    bookingid