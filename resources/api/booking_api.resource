*** Settings ***
Library     RequestsLibrary
Library     Collections

Resource    ../common/config.resource


*** Keywords ***
Get All Booking Ids
    [Documentation]    Retrieves all booking IDs.
    [Arguments]    ${expected_status}=200

    ${response}=    GET
    ...    ${API_BASE_URL}/booking
    ...    expected_status=${expected_status}

    RETURN    ${response}


Get Booking By Id
    [Documentation]    Retrieves a booking by ID.
    [Arguments]    ${booking_id}    ${expected_status}=200

    ${response}=    GET
    ...    ${API_BASE_URL}/booking/${booking_id}
    ...    expected_status=${expected_status}

    RETURN    ${response}


Create Booking
    [Documentation]    Creates a new booking.
    [Arguments]    ${payload}    ${expected_status}=200

    &{headers}=    Create Dictionary
    ...    Content-Type=application/json
    ...    Accept=application/json

    ${response}=    POST
    ...    ${API_BASE_URL}/booking
    ...    headers=${headers}
    ...    json=${payload}
    ...    expected_status=${expected_status}

    RETURN    ${response}


Update Booking
    [Documentation]    Fully updates an existing booking.
    [Arguments]    ${booking_id}    ${payload}    ${token}    ${expected_status}=200

    &{headers}=    Create Dictionary
    ...    Content-Type=application/json
    ...    Accept=application/json
    ...    Cookie=token=${token}

    ${response}=    PUT
    ...    ${API_BASE_URL}/booking/${booking_id}
    ...    headers=${headers}
    ...    json=${payload}
    ...    expected_status=${expected_status}

    RETURN    ${response}


Partially Update Booking
    [Documentation]    Partially updates an existing booking.
    [Arguments]    ${booking_id}    ${payload}    ${token}    ${expected_status}=200

    &{headers}=    Create Dictionary
    ...    Content-Type=application/json
    ...    Accept=application/json
    ...    Cookie=token=${token}

    ${response}=    PATCH
    ...    ${API_BASE_URL}/booking/${booking_id}
    ...    headers=${headers}
    ...    json=${payload}
    ...    expected_status=${expected_status}

    RETURN    ${response}


Delete Booking
    [Documentation]    Deletes an existing booking.
    [Arguments]    ${booking_id}    ${token}    ${expected_status}=201

    &{headers}=    Create Dictionary
    ...    Cookie=token=${token}

    ${response}=    DELETE
    ...    ${API_BASE_URL}/booking/${booking_id}
    ...    headers=${headers}
    ...    expected_status=${expected_status}

    RETURN    ${response}
