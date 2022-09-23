*** Settings ***

Library  SeleniumLibrary
Resource    login.robot

*** Variables ***
${stack}    10.00
${buy_price}    //*[ @class="dc-contract-card-item__header" and text()="Buy price:"]//following-sibling::div[1]
${sell_price}    //*[ @class="dc-contract-card-item__header" and text()="Sell price:"]//following-sibling::div[1]
${profit}     //*[ @class="dc-contract-card-item__header" and text()="Profit/Loss:"]//following-sibling::div[1]

*** Keywords ***
Select Volatility 10 (1s) Index
    Click Element    //div[@class="cq-symbol-select-btn"]
    Wait Until Page Contains Element   //*[text()="Synthetic Indices"]    10   
    
    Click Element    //*[text()="Synthetic Indices"]
    Wait Until Page Contains Element    //div[@class="sc-mcd__item sc-mcd__item--1HZ10V "]    10
    
    Click Element    //div[@class="sc-mcd__item sc-mcd__item--1HZ10V "]
    Wait Until Page Contains Element    //div[@class="cq-symbol" and contains(.,"Volatility 10 (1s) Index")]    10
    

Buy rise contract
    #select contract type
    Click Element    //div[@data-testid="dt_contract_dropdown"]
    Wait Until Page Contains Element    dc_all_link    10
    
    Click Element    dc_all_link
    Wait Until Page Contains Element     dt_contract_rise_fall_item    10
    
    Click Element    dt_contract_rise_fall_item
    Wait Until Page Contains Element    dc_t_toggle_item    10
    
    #set number of tick
    Click Element    dc_t_toggle_item
    Wait Until Page Contains Element    //div[@class="range-slider"]    30

    ${status}=    Run Keyword And Return Status    Page Should Contain Element    //*[@data-value="5" and contains(@class, "active")]
    IF  ${status} is False
        Click Element    //*[@data-value=5]
    END
    
    #set stack amount
    Click Element    dc_stake_toggle_item
    Wait Until Page Contains Element    //*[@id="dt_amount_input"]    10
    
    Press Keys    //*[@id="dt_amount_input"]    CTRL+A+DELETE
    Input Text    //*[@id="dt_amount_input"]    ${stack}
    Wait Until Page Contains Element    dt_purchase_call_button    30
   
    Click Element    dt_purchase_call_button
    Wait Until Page Contains Element    //*[@class="dc-contract-card"]     30
sssssss
Check contract details
    #check underlying
    Element Text Should Be    //*[@id="dc-contract_card_underlying_label"]     Volatility 10 (1s) Index
    #check contract type
    Element Text Should Be    //*[@class="dc-contract-type__type-label"]    Rise
    #check buy price
    Element Text Should Be    ${buy_price}     ${stack} 
    #check profit
    ${buy}=    Get Text    ${buy_price}
    ${buy}=    Convert To Number    ${buy}    2

    ${sell}=    Get Text    ${sell_price}
    ${sell}=    Convert To Number    ${sell}    2

    ${diff}=   Evaluate    abs(${buy}-${sell})
    ${diff}=   Evaluate    round(${diff},2)
    Element Text Should Be    ${profit}    ${diff}

*** Test Cases ***
Login To Deriv
    Login To Deriv
Check Real Account
    Check Real Account
Switch To Demo Account
    Switch To Demo Account
Select Volatility 10 (1s) Index
    Select Volatility 10 (1s) Index
Buy rise contract
    Buy rise contract
Check contract details
    Check contract details