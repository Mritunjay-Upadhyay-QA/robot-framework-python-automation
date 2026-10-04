*** Settings ***
Library    Browser


*** Variables ***
${PRODUCTS_PAGE_TITLE}       css=[data-test="title"]
${INVENTORY_ITEMS}           css=.inventory_item
${SORT_DROPDOWN}             css=[data-test="product-sort-container"]

${FIRST_PRODUCT_NAME}        css=.inventory_item:first-child .inventory_item_name
${FIRST_PRODUCT_PRICE}       css=.inventory_item:first-child .inventory_item_price

${BACKPACK_ADD_BUTTON}       css=[data-test="add-to-cart-sauce-labs-backpack"]
${BACKPACK_REMOVE_BUTTON}    css=[data-test="remove-sauce-labs-backpack"]

${CART_BADGE}                css=.shopping_cart_badge


*** Keywords ***
Verify Products Page Contains Expected Inventory
    [Documentation]    Verifies the Products page and expected number of inventory items.

    Get Text    ${PRODUCTS_PAGE_TITLE}    ==    Products
    Get Element Count    ${INVENTORY_ITEMS}    ==    6


Sort Products By
    [Documentation]    Changes the product sorting using the supplied SauceDemo sort value.
    [Arguments]    ${sort_value}

    Select Options By    ${SORT_DROPDOWN}    value    ${sort_value}


Verify First Product Name
    [Documentation]    Verifies the first product displayed after sorting.
    [Arguments]    ${expected_name}

    Get Text    ${FIRST_PRODUCT_NAME}    ==    ${expected_name}


Verify First Product Price
    [Documentation]    Verifies the price of the first displayed product.
    [Arguments]    ${expected_price}

    Get Text    ${FIRST_PRODUCT_PRICE}    ==    ${expected_price}


Add Backpack To Cart
    [Documentation]    Adds Sauce Labs Backpack to the shopping cart.

    Click    ${BACKPACK_ADD_BUTTON}


Remove Backpack From Cart
    [Documentation]    Removes Sauce Labs Backpack from the shopping cart.

    Click    ${BACKPACK_REMOVE_BUTTON}


Verify Cart Badge Count
    [Documentation]    Verifies the number displayed on the cart badge.
    [Arguments]    ${expected_count}

    Get Text    ${CART_BADGE}    ==    ${expected_count}


Verify Cart Badge Is Not Displayed
    [Documentation]    Verifies the cart badge disappears when the cart becomes empty.

    Get Element Count    ${CART_BADGE}    ==    0