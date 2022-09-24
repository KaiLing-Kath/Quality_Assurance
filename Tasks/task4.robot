#Task 4

*** Settings ***

Library  SeleniumLibrary
Resource    ../Resource/login.robot

*** Variables ***
${duration}    4
${payout}    10
${error_barrier}    -0.1
${buy_price}    //*[ @class="dc-contract-card-item__header" and text()="Buy price:"]//following-sibling::div[1]
${symbol_select_btn}    //div[@class="cq-symbol-select-btn"]  
${forex_tab}    //*[text()="Forex"]
${aud_usd}    //div[@class="sc-mcd__item sc-mcd__item--frxAUDUSD "]
${selected_symbol}    //div[@class="cq-symbol" and contains(.,"AUD/USD")]
${contract_dropdown_btn}     //div[@data-testid="dt_contract_dropdown"]
${list_all_contract_tab}  dc_all_link
${high_low_contract}    dt_contract_high_low_item
${duration_tab}    dc_duration_toggle_item
${duration_datepicker}    dt_advanced_duration_datepicker
${input_box_for_duration}    //*[@class="dc-input__field"]
${input_box_for_barrier}    //*[@name="barrier_1"]
${payout_tab}    dc_payout_toggle_item
${input_box_for_amount}    //*[@id="dt_amount_input"]
${buy_lower_btn_disabled}    //*[@id="dt_purchase_put_button" and @disabled]
${error_msg_1}    //*[@data-tooltip="Contracts more than 24 hours in duration would need an absolute barrier."]
${error_msg_2}    //*[@class="dc-popover__bubble dc-popover__bubble--error" and contains(.,"absolute barrier")]
*** Keywords ***
Select AUD/USD
    Click Element    ${symbol_select_btn}
    Wait Until Page Contains Element   ${forex_tab}    10   
    
    Click Element    ${forex_tab}  
    Wait Until Page Contains Element    ${aud_usd}    10
    
    Click Element    ${aud_usd}
    Wait Until Page Contains Element    ${selected_symbol}    10
Buy lower contract
    #select contract type
    Click Element    ${contract_dropdown_btn}
    Wait Until Page Contains Element    ${list_all_contract_tab}    10
    
    Click Element    ${list_all_contract_tab}
    Wait Until Page Contains Element     ${high_low_contract}   10
    
    Click Element    ${high_low_contract}
    Wait Until Page Contains Element    ${duration_tab}    10

    #set duration
    Click Element    ${duration_tab}
    Wait Until Page Contains Element    ${duration_datepicker}   10
    Press Keys    ${input_box_for_duration}    CTRL+A+DELETE
    Input Text    ${input_box_for_duration}    ${duration}

    #set barrier that could generate error 
    #Error message: Contracts more than 24 hours in duration would need an absolute barrier
    Press Keys    ${input_box_for_barrier}    CTRL+A+DELETE
    Input Text    ${input_box_for_barrier}    ${error_barrier}

    #set payout amount
    Click Element    ${payout_tab}
    Press Keys    ${input_box_for_amount}    CTRL+A+DELETE
    Input Text    ${input_box_for_amount}    ${payout}

    #Check to ensure the Lower button is not clickable and error message is appeared
    Wait Until Page Contains Element    ${buy_lower_btn_disabled}    10 
    #error message appears next to input box for barrier
    Page Should Contain Element    ${error_msg_1}
    #error message appears next to purchase button
    Page Should Contain Element    ${error_msg_2}

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

