*** Settings ***

Library  SeleniumLibrary
Resource    login.robot

*** Variables ***
${stack}    10.00
${buy_price}    //*[ @class="dc-contract-card-item__header" and text()="Buy price:"]//following-sibling::div[1]
${sell_price}    //*[ @class="dc-contract-card-item__header" and text()="Current stake:"]//following-sibling::div[1]
${profit}     //*[ @class="dc-contract-card-item__header" and text()="Total profit/loss:"]//following-sibling::div[1]

*** Keywords ***
Select Volatility 50 Index
    Click Element    //div[@class="cq-symbol-select-btn"]
    Wait Until Page Contains Element   //*[text()="Synthetic Indices"]    10   
    
    Click Element    //*[text()="Synthetic Indices"]
    Wait Until Page Contains Element    //div[@class="sc-mcd__item sc-mcd__item--R_50 "]    10
    
    Click Element    //div[@class="sc-mcd__item sc-mcd__item--R_50 "] 
    Wait Until Page Contains Element    //div[@class="cq-symbol" and contains(.,"Volatility 50 Index")]    10
Buy Multiplies contract
    #select contract type
    Click Element    //div[@data-testid="dt_contract_dropdown"]
    Wait Until Page Contains Element    dc_all_link    10

    Click Element    dc_all_link
    Wait Until Page Contains Element     dt_contract_multiplier_item    10
    Click Element    dt_contract_multiplier_item

    #set stake 10; multiply x20; all box not checked; up
    Press Keys    //*[@id="dt_amount_input"]    CTRL+A+DELETE
    Input Text    //*[@id="dt_amount_input"]    ${stack}
    
    Click Element    dt_purchase_multup_button
    Wait Until Page Contains Element    //*[@class="dc-contract-card"]     30
    Sleep    5
    Click Element    //*[@class="dc-btn dc-btn--secondary dc-btn--sell"]
Check contract details
    #check underlying
    Element Text Should Be    //*[@id="dc-contract_card_underlying_label"]     Volatility 50 Index
    #check contract type
    Element Text Should Be    //*[@class="dc-contract-type__type-label"]    Up\nx20
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
Select Volatility 50 Index
    Select Volatility 50 Index
Buy Multiplies contract
    Buy Multiplies contract
Check contract details
    Check contract details
