*** Settings ***

Library  SeleniumLibrary
Resource    login.robot

*** Variables ***
${duration}    4
${payout}    15.50
${payout_limit}     //*[ @class="dc-contract-card-item__header" and text()="Payout limit:"]//following-sibling::div[1]

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

    #set payout
    Click Element    dc_payout_toggle_item
    Wait Until Page Contains Element    //*[@id="dt_amount_input"]    10

    Press Keys    //*[@id="dt_amount_input"]    CTRL+A+DELETE
    Input Text    //*[@id="dt_amount_input"]    ${payout}

    #purchase lower contract
    Wait Until Page Contains Element    dt_purchase_put_button    30
    Click Element    dt_purchase_put_button

    #check whether contract details is generated
    Wait Until Page Contains Element    //*[@class="data-list__item"]     30

Check contract details
    #check underlying
    Element Text Should Be    //*[@id="dc-contract_card_underlying_label"]     AUD/USD
    #check contract type
    Element Text Should Be    //*[@class="dc-contract-type__type-label"]    Lower
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
