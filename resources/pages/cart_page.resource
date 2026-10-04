*** Settings ***
Library    Browser


*** Variables ***
${CART_PAGE_TITLE}           css=[data-test="title"]
${CART_ITEMS}                css=.cart_item
${CART_ITEM_NAME}            css=.inventory_item_name
${CART_ITEM_PRICE}           css=.inventory_item_price

${BACKPACK_REMOVE_CART}      css=[data-test="remove-sauce-labs-backpack"]

${CONTINUE_SHOPPING_BUTTON}  css=[data-test="continue-shopping"]
${CHECKOUT_BUTTON}           css=[data-test="checkout"]


*** Keywords ***
Verify Cart Page Is Displayed
    [Documentation]    Verifies that the shopping cart page is displayed.

    Get Url    *=    cart.html
    Get Text    ${CART_PAGE_TITLE}    ==    Your Cart


Verify Backpack Is In Cart
    [Documentation]    Verifies the backpack name and price in the cart.

    Get Element Count    ${CART_ITEMS}    ==    1
    Get Text    ${CART_ITEM_NAME}    ==    Sauce Labs Backpack
    Get Text    ${CART_ITEM_PRICE}    ==    $29.99


Remove Backpack From Cart Page
    [Documentation]    Removes Sauce Labs Backpack directly from the cart.

    Click    ${BACKPACK_REMOVE_CART}


Verify Cart Is Empty
    [Documentation]    Verifies there are no remaining cart items.

    Get Element Count    ${CART_ITEMS}    ==    0


Continue Shopping
    [Documentation]    Returns from the cart to the Products page.

    Click    ${CONTINUE_SHOPPING_BUTTON}


Start Checkout
    [Documentation]    Opens the checkout information page.

    Click    ${CHECKOUT_BUTTON}