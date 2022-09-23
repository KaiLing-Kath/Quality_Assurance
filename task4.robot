*** Settings ***

Library  SeleniumLibrary
Resource    login.robot

*** Variables ***
${duration}    4
${payout}    10
${error_barrier}    -0.1
${buy_price}    //*[ @class="dc-contract-card-item__header" and text()="Buy price:"]//following-sibling::div[1]

*** Keywords ***
Select AUD/USD
    Click Element    //div[@class="cq-symbol-select-btn"]
    Wait Until Page Contains Element   //*[text()="Forex"]    10   
    
    Click Element    //*[text()="Forex"]  
    Wait Until Page Contains Element    //div[@class="sc-mcd__item sc-mcd__item--frxAUDUSD "]    10
    
    Click Element    //div[@class="sc-mcd__item sc-mcd__item--frxAUDUSD "]
    Wait Until Page Contains Element    //div[@class="cq-symbol" and contains(.,"AUD/USD")]    10
Buy lower contract
    #select contract type
    Click Element    //div[@data-testid="dt_contract_dropdown"]
    Wait Until Page Contains Element    dc_all_link    10
    
    Click Element    dc_all_link
    Wait Until Page Contains Element     dt_contract_high_low_item   10
    
    Click Element    dt_contract_high_low_item
    Wait Until Page Contains Element    dc_duration_toggle_item    10

    #set duration
    Click Element    dc_duration_toggle_item
    Wait Until Page Contains Element    dt_advanced_duration_datepicker    10

    Press Keys    //*[@class="dc-input__field"]    CTRL+A+DELETE
    Input Text    //*[@class="dc-input__field"]    ${duration}

    #set barrier that could generate error 
    #Error message: Contracts more than 24 hours in duration would need an absolute barrier
    Press Keys    //*[@name="barrier_1"]    CTRL+A+DELETE
    Input Text    //*[@name="barrier_1"]    ${error_barrier}

    #set payout
    Click Element    dc_payout_toggle_item
    Wait Until Page Contains Element    //*[@id="dt_amount_input"]    10
    
    Press Keys    //*[@id="dt_amount_input"]    CTRL+A+DELETE
    Input Text    //*[@id="dt_amount_input"]    ${payout}

    #Check to ensure the Lower button is not clickable and error message is appeared
    Wait Until Page Contains Element    //*[@id="dt_purchase_put_button" and contains(@class,"--disabled btn-purchase--2")]    10 
    Page Should Contain Element    //*[@data-tooltip="Contracts more than 24 hours in duration would need an absolute barrier."]
    Page Should Contain Element    //*[@class="dc-popover__bubble dc-popover__bubble--error" and contains(.,"absolute barrier")]

*** Test Cases ***

Login To Deriv
    Login To Deriv
Check Real Account
    Check Real Account
Switch To Demo Account
    Switch To Demo Account
Select AUD/USD
    Select AUD/USD
Buy lower contract
    Buy lower contract

