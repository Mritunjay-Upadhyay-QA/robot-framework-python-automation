*** Settings ***
Resource    ../../../resources/pages/login_page.resource
Resource    ../../../resources/pages/products_page.resource
Resource    ../../../resources/keywords/authentication.resource

Test Setup       Open Products Page As Standard User
Test Teardown    Close Test Browser


*** Test Cases ***
Products Page Displays Expected Inventory
    [Tags]    smoke    web    positive    products

    Verify Products Page Contains Expected Inventory


Products Can Be Sorted Name A To Z
    [Tags]    regression    web    positive    products    sorting

    Sort Products By    az
    Verify First Product Name    Sauce Labs Backpack


Products Can Be Sorted Name Z To A
    [Tags]    regression    web    positive    products    sorting

    Sort Products By    za
    Verify First Product Name    Test.allTheThings() T-Shirt (Red)


Products Can Be Sorted Price Low To High
    [Tags]    regression    web    positive    products    sorting

    Sort Products By    lohi
    Verify First Product Name    Sauce Labs Onesie
    Verify First Product Price    $7.99


Products Can Be Sorted Price High To Low
    [Tags]    regression    web    positive    products    sorting

    Sort Products By    hilo
    Verify First Product Name    Sauce Labs Fleece Jacket
    Verify First Product Price    $49.99


User Can Add And Remove Backpack From Cart
    [Tags]    smoke    regression    web    positive    products    cart

    Add Backpack To Cart
    Verify Cart Badge Count    1

    Remove Backpack From Cart
    Verify Cart Badge Is Not Displayed