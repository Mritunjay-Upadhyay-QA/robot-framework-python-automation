*** Settings ***
Library    Browser


*** Variables ***
${CHECKOUT_TITLE}            css=[data-test="title"]

${FIRST_NAME_INPUT}          css=[data-test="firstName"]
${LAST_NAME_INPUT}           css=[data-test="lastName"]
${POSTAL_CODE_INPUT}         css=[data-test="postalCode"]

${CONTINUE_BUTTON}           css=[data-test="continue"]
${CHECKOUT_ERROR}            css=[data-test="error"]

${OVERVIEW_ITEM_NAME}        css=.inventory_item_name
${OVERVIEW_ITEM_PRICE}       css=.inventory_item_price
${ITEM_TOTAL}                css=.summary_subtotal_label
${TOTAL_PRICE}               css=.summary_total_label

${FINISH_BUTTON}             css=[data-test="finish"]

${COMPLETE_HEADER}           css=.complete-header
${BACK_TO_PRODUCTS_BUTTON}   css=[data-test="back-to-products"]


*** Keywords ***
Verify Checkout Information Page
    [Documentation]    Verifies checkout step one is displayed.

    Get Url    *=    checkout-step-one.html
    Get Text    ${CHECKOUT_TITLE}    ==    Checkout: Your Information


Enter Checkout Information
    [Documentation]    Enters customer information in the checkout form.
    [Arguments]    ${first_name}    ${last_name}    ${postal_code}

    Fill Text    ${FIRST_NAME_INPUT}    ${first_name}
    Fill Text    ${LAST_NAME_INPUT}    ${last_name}
    Fill Text    ${POSTAL_CODE_INPUT}    ${postal_code}


Continue Checkout
    [Documentation]    Submits the checkout information form.

    Click    ${CONTINUE_BUTTON}


Verify Checkout Error
    [Documentation]    Verifies the expected checkout validation error.
    [Arguments]    ${expected_error}

    Get Text    ${CHECKOUT_ERROR}    ==    ${expected_error}


Verify Checkout Overview
    [Documentation]    Verifies checkout step two and the selected backpack.

    Get Url    *=    checkout-step-two.html
    Get Text    ${CHECKOUT_TITLE}    ==    Checkout: Overview
    Get Text    ${OVERVIEW_ITEM_NAME}    ==    Sauce Labs Backpack
    Get Text    ${OVERVIEW_ITEM_PRICE}    ==    $29.99
    Get Text    ${ITEM_TOTAL}    *=    $29.99


Finish Checkout
    [Documentation]    Completes the current order.

    Click    ${FINISH_BUTTON}


Verify Checkout Completed
    [Documentation]    Verifies the successful order confirmation page.

    Get Url    *=    checkout-complete.html
    Get Text    ${COMPLETE_HEADER}    ==    Thank you for your order!