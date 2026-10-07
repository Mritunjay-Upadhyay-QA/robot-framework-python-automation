*** Settings ***
Library     libraries.custom.test_data_library.TestDataLibrary

Resource    ${CURDIR}/../../../resources/pages/login_page.resource
Resource    ${CURDIR}/../../../resources/pages/products_page.resource
Resource    ${CURDIR}/../../../resources/pages/cart_page.resource
Resource    ${CURDIR}/../../../resources/pages/checkout_page.resource
Resource    ${CURDIR}/../../../resources/keywords/authentication.resource
Resource    ${CURDIR}/../../../resources/variables/checkout_data.resource

Test Setup       Open Products Page As Standard User
Test Teardown    Close Test Browser


*** Test Cases ***
User Can Open Checkout Information Page
    [Tags]    smoke    regression    web    positive    checkout

    Add Backpack To Cart
    Open Shopping Cart
    Start Checkout
    Verify Checkout Information Page


Checkout Requires First Name
    [Tags]    regression    web    negative    checkout

    Add Backpack To Cart
    Open Shopping Cart
    Start Checkout
    Continue Checkout

    Verify Checkout Error    ${FIRST_NAME_ERROR}


Checkout Requires Last Name
    [Tags]    regression    web    negative    checkout

    ${customer}=    Generate Checkout Customer

    Add Backpack To Cart
    Open Shopping Cart
    Start Checkout

    Fill Text    ${FIRST_NAME_INPUT}    ${customer}[first_name]
    Continue Checkout

    Verify Checkout Error    ${LAST_NAME_ERROR}


Checkout Requires Postal Code
    [Tags]    regression    web    negative    checkout

    ${customer}=    Generate Checkout Customer

    Add Backpack To Cart
    Open Shopping Cart
    Start Checkout

    Fill Text    ${FIRST_NAME_INPUT}    ${customer}[first_name]
    Fill Text    ${LAST_NAME_INPUT}    ${customer}[last_name]
    Continue Checkout

    Verify Checkout Error    ${POSTAL_CODE_ERROR}


Valid Information Opens Checkout Overview
    [Tags]    smoke    regression    web    positive    checkout

    ${customer}=    Generate Checkout Customer

    Add Backpack To Cart
    Open Shopping Cart
    Start Checkout

    Enter Checkout Information
    ...    ${customer}[first_name]
    ...    ${customer}[last_name]
    ...    ${customer}[postal_code]

    Continue Checkout
    Verify Checkout Overview


User Can Complete Purchase
    [Tags]    smoke    regression    web    positive    checkout    e2e

    ${customer}=    Generate Checkout Customer

    Add Backpack To Cart
    Verify Cart Badge Count    1

    Open Shopping Cart
    Verify Backpack Is In Cart

    Start Checkout
    Verify Checkout Information Page

    Enter Checkout Information
    ...    ${customer}[first_name]
    ...    ${customer}[last_name]
    ...    ${customer}[postal_code]

    Continue Checkout
    Verify Checkout Overview

    Finish Checkout
    Verify Checkout Completed