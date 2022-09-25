Task 5
*** Settings ***

Library  SeleniumLibrary
Resource    ../Resource/login.robot

*** Variables ***
${symbol_select_btn}    //div[@class="cq-symbol-select-btn"]
${synthetic_indices_tab}    //*[text()="Synthetic Indices"]
${volatility_50_index}    //div[@class="sc-mcd__item sc-mcd__item--R_50 "] 
${selected_symbol}    //div[@class="cq-symbol" and contains(.,"Volatility 50 Index")]
${contract_dropdown_btn}     //div[@data-testid="dt_contract_dropdown"]
${list_all_contract_tab}  dc_all_link
${multipliers_contract}    dt_contract_multiplier_item
${min_stake_amount}    1
${max_stake_amount}    2000
${input_box_for_amount}    //*[@id="dt_amount_input"]
${multiplier_dropdown_btn}    //*[@class="dc-dropdown__container"]
${list_all_multiplier}    //*[@class="dc-list dc-list--left"]
${x20}    //*[@id="20"]
${x40}    //*[@id="40"]
${x60}    //*[@id="60"]
${x100}    //*[@id="100"]
${x200}    //*[@id="200"]
${buy_up_btn_disabled}    //*[@id="dt_purchase_multup_button" and @disabled]
${buy_up_btn}    dt_purchase_multup_button
${close_contract_btn}    //*[text()="Close"]//parent::button
${take_profit}
${input_box_for_tk_profit}    //*[@id="dc_take_profit_input"]
${select_take_profit}    //*[text()="Take profit"]//parent::label
${select_stop_lost}    //*[text()="Stop loss"]//parent::label
${select_deal_cancellation}    //*[text()="Deal cancellation"]//parent::label

${stake_option}    //*[text()="Stake"]
${payout_option}    //*[text()="Payout"]
${TP_plus_btn}    dc_take_profit_input_add
${TP_minus_btn}    dc_take_profit_input_sub
${duration_dropdown_btn}    //span[@name="cancellation_duration"]//parent::div
${5min}    //*[@value="5m"]
${10min}    //*[@value="10m"]
${15min}    //*[@value="15m"]
${30min}    //*[@value="30m"]
${60min}    //*[@value="60m"]


*** Keywords ***
Select Volatility 50 Index
    Click Element    ${symbol_select_btn}
    Wait Until Page Contains Element   ${synthetic_indices_tab}    10   
    
    Click Element    ${synthetic_indices_tab}
    Wait Until Page Contains Element    ${volatility_50_index}    10
    
    Click Element    ${volatility_50_index}
    Wait Until Page Contains Element    ${selected_symbol}    10
Select Multipliers Contract
    #select contract type
    Click Element    ${contract_dropdown_btn}
    Wait Until Page Contains Element  ${list_all_contract_tab}  10
    Click Element    ${list_all_contract_tab}
    Wait Until Page Contains Element     ${multipliers_contract}   10
    Click Element    ${multipliers_contract}
    Wait For Page To Complete Loading
Set Minimum Stake 1 USD
    #set stake
    Press Keys    ${input_box_for_amount}    CTRL+A+DELETE
    Input Text    ${input_box_for_amount}    ${min_stake_amount}
Set Maximum Stake 2000 USD
    #set stake
    Press Keys    ${input_box_for_amount}    CTRL+A+DELETE
    Input Text    ${input_box_for_amount}    ${max_stake_amount}
Set Invalid Stake 2001 USD
    #set stake
    Press Keys    ${input_box_for_amount}    CTRL+A+DELETE
    Input Text    ${input_box_for_amount}    2001
Set Invalid Stake 0 USD
    #set stake
    Press Keys    ${input_box_for_amount}    CTRL+A+DELETE
    Input Text    ${input_box_for_amount}    0
Show List Of Multipliers
    Click Element    ${multiplier_dropdown_btn}
    Wait Until Page Contains Element    ${list_all_multiplier}
Set Multiplier x20
    Show List Of Multipliers
    Click Element    ${x20}
Set Multiplier x40
    Show List Of Multipliers
    Click Element    ${x40}
Set Multiplier x60
    Show List Of Multipliers
    Click Element    ${x60}
Set Multiplier x100
    Show List Of Multipliers
    Click Element    ${x100}
Set Multiplier x200
    Show List Of Multipliers
    Click Element    ${x200}
Buy Up
    Wait Until Page Does Not Contain Element    ${buy_up_btn_disabled}    30
    Click Element    ${buy_up_btn}
Close Contract
    Wait Until Page Contains Element    ${close_contract_btn}
    Click Element    ${close_contract_btn}
Invalid Buy Up
    Wait Until Page Contains Element    ${buy_up_btn_disabled}    30
Check Whether Take Profit Is Selected
    ${is_TP_selected}=    Run Keyword And Return Status    Page Should Contain Element    //*[@name="has_take_profit" and @checked]
    RETURN    ${is_TP_selected}
Check Whether Stop Lost Is Selected
    ${is_SL_selected}=    Run Keyword And Return Status    Page Should Contain Element    //*[@name="has_stop_loss" and @checked]
    RETURN    ${is_SL_selected}
Check Whether Deal Cancellation Is Selected
    ${is_DC_selected}=    Run Keyword And Return Status    Page Should Contain Element    //*[@name="has_cancellation" and @checked]
    RETURN    ${is_DC_selected}
Set Take Profit Minimum Amount
    ${status}=    Check Whether Take Profit Is Selected
    IF    ${status} is False
        Click Element    ${select_take_profit}
    END
    Press Keys    ${input_box_for_tk_profit}    CTRL+A+DELETE
    Input Text    ${input_box_for_tk_profit}     0.1   
Only Select Take Profit
    ${status_TP}=    Check Whether Take Profit Is Selected
    ${status_ST}=    Check Whether Stop Lost Is Selected
    IF    ${status_TP} is False
        Click Element    ${select_take_profit}
    END
    IF    ${status_ST} is True
        Click Element    ${select_stop_lost}
    END

Only Select Stop Lost
    ${status_ST}=    Check Whether Stop Lost Is Selected
    ${status_TP}=    Check Whether Take Profit Is Selected
    IF    ${status_ST} is False
        Click Element    ${select_stop_lost}
    END
    IF    ${status_TP} is True
        Click Element    ${select_take_profit}
    END

Set Take Profit Invalid Amount (Zero)
    Only Select Take Profit
    Press Keys    ${input_box_for_tk_profit}    CTRL+A+DELETE
    Input Text    ${input_box_for_tk_profit}     0
Check Current Multiplier Take Profit Rate
     ${is_x20_selected}=    Run Keyword And Return Status    Page Should Contain Element    //*[@name="multiplier" and text()="x20"]
     ${is_x40_selected}=    Run Keyword And Return Status    Page Should Contain Element    //*[@name="multiplier" and text()="x40"]
     ${is_x60_selected}=    Run Keyword And Return Status    Page Should Contain Element    //*[@name="multiplier" and text()="x60"]
     ${is_x100_selected}=    Run Keyword And Return Status    Page Should Contain Element    //*[@name="multiplier" and text()="x100"]
     ${is_x200_selected}=    Run Keyword And Return Status    Page Should Contain Element    //*[@name="multiplier" and text()="x200"]
     IF  ${${is_x20_selected}} is True
         ${TP_multiplier}=    Set Variable    ${18}
        RETURN    ${TP_multiplier}
     END
     IF  ${${is_x40_selected}} is True
         ${TP_multiplier}=    Set Variable    ${36}
        RETURN    ${TP_multiplier}
     END
     IF  ${${is_x60_selected}} is True or ${${is_x100_selected}} is True or ${${is_x200_selected}} is True
         ${TP_multiplier}=    Set Variable    ${50}
        RETURN    ${TP_multiplier}
     END
Set Take Profit Maximum Amount
    Only Select Take Profit
    ${take_profit}=    Convert To Number    ${min_stake_amount}
    Check Current Multiplier Take Profit Rate
    ${TP_multiplier}=    Check Current Multiplier Take Profit Rate
    ${max_take_profit}=    Evaluate    ${take_profit}*${TP_multiplier}
    Press Keys    ${input_box_for_tk_profit}    CTRL+A+DELETE
    Input Text    ${input_box_for_tk_profit}     ${max_take_profit}

Set Take Profit Invalid Amount (Greater Than min Stake*TP Multiplier)
    Only Select Take Profit
    ${take_profit}=    Convert To Number    ${min_stake_amount}
    ${TP_multiplier}=    Check Current Multiplier Take Profit Rate
    ${max_take_profit}=    Evaluate    ${take_profit}*${TP_multiplier}+1
    Press Keys    ${input_box_for_tk_profit}    CTRL+A+DELETE
    Input Text    ${input_box_for_tk_profit}     ${max_take_profit}
Set Take Profit Invalid Amount (Greater than max stake*TP Multiplier)
    Only Select Take Profit
    ${take_profit}=    Convert To Number    ${max_stake_amount}
    ${TP_multiplier}=    Check Current Multiplier Take Profit Rate
    ${max_take_profit}=    Evaluate    ${take_profit}*${TP_multiplier}+1
    Press Keys    ${input_box_for_tk_profit}    CTRL+A+DELETE
    Input Text    ${input_box_for_tk_profit}     ${max_take_profit}
####

*** Test Cases ***
Login To Deriv
    Login To Deriv
Check Real Account
    Check Real Account
Switch To Demo Account
    Switch To Demo Account
Select Volatility 50 Index
    Select Volatility 50 Index
Select Multipliers Contract
    Select Multipliers Contract
Check Whether Only Has Stake Option and No Payout Option
    Page Should Contain Element    ${stake_option}
    Page Should Not Contain Element    ${payout_option}
Check Whether Multiplier Value Have x20 x40 x60 x100 x200
    Show List Of Multipliers
    Page Should Contain Element    ${x20}
    Page Should Contain Element    ${x40}
    Page Should Contain Element    ${x60}
    Page Should Contain Element    ${x100}
    Page Should Contain Element    ${x200}
Buy Mulitpliers Up Contract (Stake:1 USD)
    Set Minimum Stake 1 USD
    Set Multiplier x20
    Buy Up
    Close Contract
Buy Mulitpliers Up Contract (Stake:2000 USD)
    Set Maximum Stake 2000 USD
    Set Multiplier x20
    Buy Up
    Close Contract
Buy Mulitpliers Up Contract (Stake:2001 USD)
    Set Invalid Stake 2001 USD
    Set Multiplier x20
    Invalid Buy Up
Buy Mulitpliers Up Contract (Stake:0 USD)
    Set Invalid Stake 0 USD
    Set Multiplier x20
    Invalid Buy Up
Single Click On Plus (+) Button Of Take Profit Field Should Increase The Take Profit Value By 1 USD
    Set Minimum Stake 1 USD
    Only Select Take Profit
    Wait Until Page Contains Element    ${input_box_for_tk_profit}     10
    Press Keys    ${input_box_for_tk_profit}    CTRL+A+DELETE
    Input Text    ${input_box_for_tk_profit}     10
    Click Element    ${TP_plus_btn}
    ${input_value}=   Get Element Attribute     ${input_box_for_tk_profit}     value
    Should Be Equal As Strings    ${input_value}    11
Single Click On Minus (-) Button Of Take Profit Field Should Decrease The Take Profit Value By 1 USD
    Only Select Take Profit
    Wait Until Page Contains Element    ${input_box_for_tk_profit}     10
    Press Keys    ${input_box_for_tk_profit}    CTRL+A+DELETE
    Input Text    ${input_box_for_tk_profit}     10
    Click Element    ${TP_minus_btn}
    ${input_value}=   Get Element Attribute     ${input_box_for_tk_profit}     value
    Should Be Equal As Strings    ${input_value}    9
Check Whether Deal Cancellation Duration Has These Options: 5, 10, 15, 30 And 60 Min
    Click Element    ${select_deal_cancellation}
    Wait Until Page Contains Element    ${duration_dropdown_btn}    10
    Click Element    ${duration_dropdown_btn}
    Page Should Contain Element    ${5min}
    Page Should Contain Element    ${10min}
    Page Should Contain Element    ${15min}
    Page Should Contain Element    ${30min}
    Page Should Contain Element    ${60min}
