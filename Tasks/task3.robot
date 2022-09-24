#Task 3

*** Settings ***

Library  SeleniumLibrary
Resource    ../Resource/login.robot

*** Variables ***
${duration}    4
${payout}    15.50
${payout_limit}     //*[ @class="dc-contract-card-item__header" and text()="Payout limit:"]//following-sibling::div[1]
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
${payout_tab}    dc_payout_toggle_item
${input_box_for_amount}    //*[@id="dt_amount_input"]
${buy_lower_btn_disabled}    //*[@id="dt_purchase_put_button" and @disabled]
${buy_lower_btn}    dt_purchase_put_button
${contract_card}    //*[@class="data-list__item"]
${symbol_in_card}    //*[@id="dc-contract_card_underlying_label"]
${contract_type_in_card}    //*[@class="dc-contract-type__type-label"]

*** Keywords ***
Select AUD/USD

    Click Element    ${symbol_select_btn}
    Wait Until Page Contains Element    ${Forex_tab}   10   
    
    Click Element    ${Forex_tab}  
    Wait Until Page Contains Element    ${aud_usd}    10
    
    Click Element    ${aud_usd}
    Wait For Page To Complete Loading
    Wait Until Page Contains Element    ${selected_symbol}     10
Buy lower contract
    #select contract type
    Click Element    ${contract_dropdown_btn}
    Wait Until Page Contains Element  ${list_all_contract_tab}  10
    Click Element    ${list_all_contract_tab}
    Wait Until Page Contains Element     ${high_low_contract}   10
    Click Element    ${high_low_contract}
    Wait For Page To Complete Loading

    #set duration
    Click Element    ${duration_tab}
    Wait Until Page Contains Element    ${duration_datepicker}    10
    Press Keys    ${input_box_for_duration}    CTRL+A+DELETE
    Input Text    ${input_box_for_duration}    ${duration}

    #set payout amount
    Click Element    ${payout_tab}
    Press Keys    ${input_box_for_amount}    CTRL+A+DELETE
    Input Text    ${input_box_for_amount}    ${payout}

    #purchase lower contract
    Wait Until Page Does Not Contain Element    ${buy_lower_btn_disabled}    10   
    Click Element    ${buy_lower_btn}
    Wait For Page To Complete Loading
    Wait Until Page Contains Element    ${contract_card}     30

Check contract details
    #check underlying
    Element Text Should Be    ${symbol_in_card}    AUD/USD
    #check contract type
    Element Text Should Be    ${contract_type_in_card}    Lower
    #check payout limit
    Element Text Should Be    ${payout_limit}     ${payout} 

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
Check contract details
    Check contract details
