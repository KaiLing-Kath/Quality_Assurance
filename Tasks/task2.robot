#Task 2

*** Settings ***

Library  SeleniumLibrary
Library    String
Resource    ../Resource/login.robot

*** Variables ***
${symbol_select_btn}    //div[@class="cq-symbol-select-btn"]
${synthetic_indices_tab}    //*[text()="Synthetic Indices"]
${stake_amount}    10.00
${buy_price_in_card}    //*[ text()="Buy price:"]//following-sibling::div/span
${sell_price_in_card}    //*[ text()="Sell price:"]//following-sibling::div/span
${profit_in_card}     //*[ text()="Profit/Loss:"]//following-sibling::div/span
${payout_limit_in_card}    //*[ text()="Payout limit:"]//following-sibling::div/span
${offered_payout_limit}    //*[@id="dt_purchase_call_price"]/div/span[@class="trade-container__price-info-currency"]
${volatility_10_1s_index}    //*[@class="sc-mcd__item sc-mcd__item--1HZ10V "]
${selected_symbol}    //div[@class="cq-symbol" and contains(.,"Volatility 10 (1s) Index")]
${contract_dropdown}    //div[@data-testid="dt_contract_dropdown"]
${list_all_contract_tab}    dc_all_link
${rise_fall_contract}    dt_contract_rise_fall_item
${tick}    dc_t_toggle_item
${tick_range}    //div[@class="range-slider"]
${stake}    dc_stake_toggle_item
${input_box_for_amount}    //*[@id="dt_amount_input"]
${buy_rise_btn}    dt_purchase_call_button
${buy_rise_btn_disabled}    //*[@id="dt_purchase_call_button" and @disabled]
${contract_card}    //*[@class="dc-contract-card"]
${symbol_in_card}    //*[@id="dc-contract_card_underlying_label"]
${contract_type_in_card}    //*[@class="dc-contract-type__type-label"]
${contract_won}    //*[text()="Won"]
${contract_lost}    //*[text()="Lost"]

*** Keywords ***
Check Whether 5 Ticks Is Selected
    ${status}=    Run Keyword And Return Status    Page Should Contain Element    //*[@data-value="5" and contains(@class, "active")]
    RETURN    ${status}

Is Contract Won
    ${is_contract_won}=        Run Keyword And Return Status    Page Should Contain Element    ${contract_won}
     RETURN     ${is_contract_won}

Is Contract Lost
    ${is_contract_lost}=        Run Keyword And Return Status    Page Should Contain Element    ${contract_lost}
     RETURN     ${is_contract_lost}
    
Select Volatility 10 (1s) Index
    Click Element    ${symbol_select_btn}
    Wait Until Element Is Visible   ${synthetic_indices_tab}    10   
    Click Element    ${synthetic_indices_tab}
    Wait Until Element Is Visible    ${volatility_10_1s_index}    10
    Click Element    ${Volatility_10_1s_Index}
    Wait For Page To Complete Loading 
    Page Should Contain Element    ${selected_symbol}    10

Buy rise contract
    #select contract type
    Click Element    ${contract_dropdown} 
    Wait Until Page Contains Element    ${list_all_contract_tab}    10
    Click Element    ${list_all_contract_tab} 
    Wait Until Page Contains Element     ${rise_fall_contract}    10
    Click Element    ${rise_fall_contract}
    Wait For Page To Complete Loading
    
    #set number of tick
    Click Element    ${tick}
    Wait Until Page Contains Element    ${tick_range}    30
    ${status}=  Check Whether 5 Ticks Is Selected  
    IF  ${status} is False
        Click Element    //*[@data-value=5]
    END
    
    #set stack amount
    Click Element    ${stake}
    Press Keys    ${input_box_for_amount}    CTRL+A+DELETE
    Input Text    ${input_box_for_amount}    ${stake_amount}
    
    #purchase rise contract
    Wait Until Page Does Not Contain Element    ${buy_rise_btn_disabled}    10   
    Click Element    ${buy_rise_btn}
    Wait For Page To Complete Loading
    Wait Until Page Contains Element    ${contract_card}     30

Check contract details
    #check underlying
    Element Text Should Be     ${symbol_in_card}    Volatility 10 (1s) Index

    #check contract type
    Element Text Should Be    ${contract_type_in_card}    Rise
    
    #check buy price
    Element Text Should Be    ${buy_price_in_card}     ${stake_amount}

    #check profit
    ${buy}=    Get Text    ${buy_price_in_card}
    ${buy}=    Convert To Number    ${buy}    2

    ${sell}=    Get Text    ${sell_price_in_card}
    ${sell}=    Convert To Number    ${sell}    2

    ${profit}=   Evaluate    abs(${buy}-${sell})
    ${profit}=   Evaluate    round(${profit},2)
    ${profit}=   Convert To String    ${profit}

    Element Text Should Be    ${profit_in_card}    ${profit}

    #check payout limit
    # it does not change overtime cus volatility is fixed in this index
    # with the same amout of stake 
    ${payout_limit_to_compare}=    Get Text     ${offered_payout_limit}
    ${payout_limit_to_compare}=    Evaluate    "${payout_limit_to_compare}".replace(" USD","")
    Element Text Should Be    ${payout_limit_in_card}     ${payout_limit_to_compare}

    #check sell price
    #if win it is equal to payout
    #if lose it is zero
    ${is_contract_won} =    Is Contract Won
    ${is_contract_lost} =    Is Contract Lost

    IF  ${is_contract_won} is True
        ${payout_limit_in_card_text}=     Get Text    ${payout_limit_in_card}
        Element Text Should Be    ${sell_price_in_card}    ${payout_limit_in_card_text}
    ELSE IF  ${is_contract_lost} is True
        Element Text Should Be    ${sell_price_in_card}    0
    END

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