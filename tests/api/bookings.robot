*** Settings ***
Library     RequestsLibrary
Library     Collections
Library     libraries.custom.test_data_library.TestDataLibrary
Library     libraries.custom.api_validation_library.ApiValidationLibrary

Resource    ${CURDIR}/../../resources/api/auth_api.resource
Resource    ${CURDIR}/../../resources/api/booking_api.resource


*** Test Cases ***
User Can Retrieve Booking Ids
    [Tags]    smoke    regression    api    positive

    ${response}=    Get All Booking Ids

    Status Should Be    200    ${response}
    Response Time Should Be Below    ${response}    5000

    ${bookings}=    Set Variable    ${response.json()}
    Should Not Be Empty    ${bookings}

    ${first_booking}=    Get From List    ${bookings}    0
    Dictionary Should Contain Key    ${first_booking}    bookingid


User Can Create And Retrieve Booking
    [Tags]    smoke    regression    api    positive

    ${token}=      Create Auth Token
    ${payload}=    Generate Booking Payload

    ${create_response}=    Create Booking    ${payload}

    Status Should Be    200    ${create_response}
    Response Time Should Be Below    ${create_response}    5000

    ${create_body}=    Set Variable    ${create_response.json()}
    Dictionary Should Contain Key    ${create_body}    bookingid
    Dictionary Should Contain Key    ${create_body}    booking

    ${booking_id}=    Get From Dictionary    ${create_body}    bookingid
    ${created}=       Get From Dictionary    ${create_body}    booking

    Validate Booking Schema    ${created}

    TRY
        ${get_response}=    Get Booking By Id    ${booking_id}

        Status Should Be    200    ${get_response}

        ${booking}=    Set Variable    ${get_response.json()}
        Validate Booking Schema    ${booking}

        Should Be Equal    ${booking}[firstname]    ${payload}[firstname]
        Should Be Equal    ${booking}[lastname]     ${payload}[lastname]
        Should Be Equal As Integers
        ...    ${booking}[totalprice]
        ...    ${payload}[totalprice]
    FINALLY
        Delete Booking
        ...    ${booking_id}
        ...    ${token}
        ...    expected_status=any
    END


User Can Complete Booking Crud Lifecycle
    [Tags]    regression    api    positive    e2e

    ${token}=      Create Auth Token
    ${payload}=    Generate Booking Payload

    ${create_response}=    Create Booking    ${payload}
    Status Should Be    200    ${create_response}

    ${create_body}=    Set Variable    ${create_response.json()}
    ${booking_id}=     Get From Dictionary    ${create_body}    bookingid
    ${deleted}=        Set Variable    ${False}

    TRY
        ${get_response}=    Get Booking By Id    ${booking_id}
        Status Should Be    200    ${get_response}

        ${update_payload}=    Generate Updated Booking Payload

        ${update_response}=    Update Booking
        ...    ${booking_id}
        ...    ${update_payload}
        ...    ${token}

        Status Should Be    200    ${update_response}

        ${updated}=    Set Variable    ${update_response.json()}
        Validate Booking Schema    ${updated}

        Should Be Equal
        ...    ${updated}[lastname]
        ...    ${update_payload}[lastname]

        ${patch_payload}=    Generate Booking Patch

        ${patch_response}=    Partially Update Booking
        ...    ${booking_id}
        ...    ${patch_payload}
        ...    ${token}

        Status Should Be    200    ${patch_response}

        ${patched}=    Set Variable    ${patch_response.json()}

        Should Be Equal
        ...    ${patched}[firstname]
        ...    ${patch_payload}[firstname]

        Should Be Equal
        ...    ${patched}[additionalneeds]
        ...    ${patch_payload}[additionalneeds]

        ${delete_response}=    Delete Booking
        ...    ${booking_id}
        ...    ${token}

        Status Should Be    201    ${delete_response}
        ${deleted}=    Set Variable    ${True}

        ${not_found_response}=    Get Booking By Id
        ...    ${booking_id}
        ...    expected_status=404

        Status Should Be    404    ${not_found_response}
    FINALLY
        IF    not ${deleted}
            Delete Booking
            ...    ${booking_id}
            ...    ${token}
            ...    expected_status=any
        END
    END
