*** Settings ***
Resource    ../../../resources/pages/login_page.resource
Resource    ../../../resources/pages/products_page.resource
Resource    ../../../resources/pages/cart_page.resource
Resource    ../../../resources/keywords/authentication.resource

Test Setup       Open Products Page As Standard User
Test Teardown    Close Test Browser


*** Test Cases ***
User Can Open Shopping Cart
    [Tags]    smoke    regression    web    positive    cart

    Open Shopping Cart
    Verify Cart Page Is Displayed


Added Product Appears In Cart
    [Tags]    smoke    regression    web    positive    cart

    Add Backpack To Cart
    Open Shopping Cart

    Verify Cart Page Is Displayed
    Verify Backpack Is In Cart


User Can Remove Product From Cart
    [Tags]    regression    web    positive    cart

    Add Backpack To Cart
    Open Shopping Cart

    Verify Backpack Is In Cart
    Remove Backpack From Cart Page
    Verify Cart Is Empty


User Can Continue Shopping From Cart
    [Tags]    regression    web    positive    cart

    Open Shopping Cart
    Verify Cart Page Is Displayed

    Continue Shopping

    Get Url    *=    inventory.html