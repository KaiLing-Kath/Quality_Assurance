#Project 1: Automation on API token page

*** Settings ***

Library  SeleniumLibrary
Resource    ../Resource/login.robot

*** Variables ***

${acct_setting_icon}    //*[@class="account-settings-toggle"]
${personal_details_tab_active}    //*[@id="dc_personal-details_link" and contains(@class,"--active")]
${personal_details_content}    //*[@class="account-form account-form__personal-details"]
${api_token_tab}     //*[@id="dc_api-token_link"]
${api_token_tab_active}    //*[@id="dc_api-token_link"and contains(@class,"--active")]
${api_token_content}    //*[@class="da-api-token__timeline"]
${checked_box}    //*[@class="da-api-token__checkbox-wrapper"]//child::div [contains(@class,"--active")]
${empty_box}    //*[@name="token_name" and @value=""]
${token_name_input_box}    //input[@name="token_name"]
${Create_btn_disabled}    //button[@disabled]/span[text()="Create"]
${Create_btn_enabled}    //span[text()="Create"]//parent::button
${valid_token_name_1}    kath
${valid_token_name_2}    kathleen
${created_token_name}    //tr/td[1]//child::span[@class="dc-text" and contains(.,"kathleen")]   
${invalid_token_name_<min}    k
${invalid_token_name>max}    asdasdhsakkjhasfhsdfoshfosdfhidsuhgdhgifdughofdhgufdhgodfs
${token_name_length_error}    //*[@class="dc-input__label"]//following-sibling::div[contains(@class,"--error") and contains(.,"characters")]
${empty_token_name_error}    //*[text()="Please enter a token name."]
${token_list}    //tr[@class="da-api-token__table-cell-row"]

${checkbox_read}    //*[@class="dc-checkbox__input" and @name="read"]//parent::label
${checkbox_trade}    //*[@class="dc-checkbox__input" and @name="trade"]//parent::label
${checkbox_payments}    //*[@class="dc-checkbox__input" and @name="payments"]//parent::label
${checkbox_trading_information}    //*[@class="dc-checkbox__input" and @name="trading_information"]//parent::label
${checkbox_admin}    //*[@class="dc-checkbox__input" and @name="admin"]//parent::label

${scope_read}    //div[@class="da-api-token__table-scopes-cell-block"]//child::div[text()="Read"]
${scope_trade}    //div[@class="da-api-token__table-scopes-cell-block"]//child::div[text()="Trade"]
${scope_payments}    //div[@class="da-api-token__table-scopes-cell-block"]//child::div[text()="Payments"]
${scope_trading_information}    //div[@class="da-api-token__table-scopes-cell-block"]//child::div[text()="Trading information"]
${scope_admin}    //div[@class="da-api-token__table-scopes-cell-block"]//child::div[text()="Admin"]

${copy_icon}    //*[@data-testid="dt_copy_token_icon"]
${popup_for_copy}    //*[@class="dc-modal-body"]//child::p[contains(.,"Be careful")] 
${ok_btn_in_copy_popup}    //span[text()="OK"]//parent::button
${token_copied_msg}    //*[text()="Token copied!"]

${hidden_icon}    //*[@data-testid="dt_toggle_visibility_icon"]
${hidden_token}    //tr/td[2]//child::div[@class="da-api-token__pass-dot-container"]

${delete_icon}    //*[@data-testid="dt_token_delete_icon"] 
${popup_for_delete}    //*[@class="dc-modal-body"]//child::h1[text()="Delete token"]
${cancel_btn_in_delete_popup}    //span[text()="Cancel"]//parent::button
${yes_btn_in_delete_popup}    //span[text()="Yes, delete"]//parent::button

*** Keywords ***
Is Any Box Checked    
   ${is_any_box_checked}=    Run Keyword And Return Status    Page Should Contain Element    ${checked_box}
    RETURN     ${is_any_box_checked}

Is Token Name Empty
    ${is_input_empty}=        Run Keyword And Return Status    Page Should Contain Element    ${empty_box}
     RETURN     ${is_input_empty}

Select All Scopes
    Click Element        ${checkbox_read} 
    Click Element        ${checkbox_trade}   
    Click Element        ${checkbox_payments}  
    Click Element        ${checkbox_trading_information} 
    Click Element        ${checkbox_admin}  

Test Case 2
#Test if account setting clickable 
    Click Element    ${acct_setting_icon} 
    Wait For Page To Complete Loading
    Page Should Contain Element    ${personal_details_tab_active}
    Page Should Contain Element    ${personal_details_content} 
Test Case 3
#Test if the “API token” tab is clickable
    Click Element     ${api_token_tab}
    Wait For Page To Complete Loading
    Page Should Contain Element     ${api_token_tab_active}
    Page Should Contain Element     ${api_token_content}
Test Case 4
#Test if the “create” button is clickable when non of the box in step 1 checked and the token name is empty
    ${is_any_box_checked}=    Is Any Box Checked
    ${is_input_empty}=        Is Token Name Empty
    IF  ${is_any_box_checked} is False and ${is_input_empty} is True
        Page Should Contain Element    ${Create_btn_disabled}
    END

Test Case 5
#Test if the “create” button is clickable when non of the box in step 1 checked and the token name is not empty
    ${is_any_box_checked}=    Is Any Box Checked
    ${is_input_empty}=        Is Token Name Empty
    IF  ${is_any_box_checked} is False and ${is_input_empty} is False
        Page Should Contain Element    ${Create_btn_disabled}
    END

Test Case 6
    #Test if the  “create” button is clickable and whether error message is shown  when any of the box in step 1 is checked but input box in step 2 is empty 
    Click Element    ${checkbox_read}
    Input Text    ${token_name_input_box}    dummy
    Press Keys    ${token_name_input_box}    CTRL+A+DELETE
    ${is_any_box_checked}=    Is Any Box Checked
    ${is_input_empty}=        Is Token name Empty
    IF  ${is_any_box_checked} is True and ${is_input_empty} is True
        Page Should Contain Element    ${Create_btn_disabled}
        Page Should Contain Element    ${empty_token_name_error}   
    END

Test Case 7
    #Test if the  “create” button is clickable when any of the box in step 1 is checked and input box in step 2 has valid token name
    Click Element    ${checkbox_read}
    Input Text    ${token_name_input_box}    ${valid_token_name_1}
    ${is_any_box_checked}=    Is Any Box Checked
    ${is_input_empty}=        Is Token Name Empty
    IF  ${is_any_box_checked} is True and ${is_input_empty} is False
        Page Should Contain Element    ${Create_btn_enabled}
    END
Test Case 8
    #Test if the  “create” button is clickable and whether error message is shown  when any of the box in step 1 is checked and input box in step 2 has invalid token name
    Click Element    ${checkbox_read}
    Press Keys    ${token_name_input_box}    CTRL+A+DELETE
    Input Text    ${token_name_input_box}    ${invalid_token_name_<min}
    ${is_any_box_checked}=    Is Any Box Checked
    ${is_input_empty}=        Is Token Name Empty
    IF  ${is_any_box_checked} is True and ${is_input_empty} is False
        Page Should Contain Element    ${Create_btn_disabled}
        Page Should Contain Element    ${token_name_length_error} 
    END
    
    Press Keys    ${token_name_input_box}    CTRL+A+DELETE
    Input Text    ${token_name_input_box}    ${invalid_token_name>max}
    ${is_any_box_checked}=    Is Any Box Checked
    ${is_input_empty}=        Is Token Name Empty
    IF  ${is_any_box_checked} is True and ${is_input_empty} is False
        Page Should Contain Element    ${Create_btn_disabled}
        Page Should Contain Element    ${token_name_length_error} 
    END
    
Test Case 9
    #Test if the token is created
    Reload Page
    Wait For Page To Complete Loading
    Select All Scopes
    Input Text    ${token_name_input_box}    ${valid_token_name_2}
    Wait Until Page Contains Element    ${Create_btn_enabled}   30
    Click Element    ${Create_btn_enabled}
    Wait For Page To Complete Loading
    Page Should Contain Element    ${token_list}
    
Test Case 10
    #Test if the created token name is as same as the token name inputted in test case 9
    Element Text Should Be    ${created_token_name}    ${valid_token_name_2}

Test Case 11
    #Test if the created token’s scopes is same as the scope selected in test case 9
    Element Text Should Be    ${scope_read}     Read
    Element Text Should Be    ${scope_trade}     Trade
    Element Text Should Be    ${scope_payments}    Payments
    Element Text Should Be    ${scope_trading_information}     Trading information
    Element Text Should Be    ${scope_admin}     Admin

Test Case 12
    #Test if the created token’s “copy” icon is clickable
    Click Element    ${copy_icon} 
Test Case 13
    #Check whether there is any popup window after “copy” icon is clicked 
    Wait Until Page Contains Element    ${popup_for_copy}    10
Test Case 14
    #Check if after “OK” button is clicked is there any message show that token is copied
    Click Element    ${ok_btn_in_copy_popup}
    Wait Until Page Contains Element    ${token_copied_msg}    30
Test Case 15
    #Test if the created token’s “hidden” icon is clickable
    Click Element    ${hidden_icon}
Test Case 16
    #Check whether the token value is shown after “hidden” icon is clicked once 
    Wait Until Page Does Not Contain Element    ${hidden_token}    10
Test Case 17
    #Check whether the token value is hided after “hidden” icon is clicked twice  
    Click Element    ${hidden_icon}
    Wait Until Page Contains Element    ${hidden_token}    10
Test Case 18
    #Test if the created token’s “delete” icon is clickable 
    Click Element    ${delete_icon} 
Test Case 19
    #Check whether there is any popup window after “delete” icon is click 
    Wait Until Page Contains Element    ${popup_for_delete}    10
Test Case 20
    #Test if after “Cancel” button is clicked,  is the token not deleted 
    Click Element    ${cancel_btn_in_delete_popup}
    Wait For Page To Complete Loading
    Page Should Contain Element    ${created_token_name}
    
Test Case 21
    #Test if after “Yes, delete” button is clicked, is the token deleted  
    Click Element    ${delete_icon} 
    Wait Until Page Contains Element    ${popup_for_delete}    10
    Click Element    ${yes_btn_in_delete_popup} 
    Wait For Page To Complete Loading
    Page Should Not Contain Element    ${created_token_name}

*** Test Cases ***
Test case 1
    #Test if successfully login in to real account
    Login To Deriv
    Check Real Account
Test Case 2
    #Test if account setting clickable 
    Test case 2
Test Case 3
    #Test if the “API token” tab is clickable
    Test case 3

Test Case 4 To 11
    #Test for create a token
    Test Case 4
    Test Case 5
    Test Case 6
    Test Case 7
    Test Case 8
    Test Case 9
    Test Case 10
    Test Case 11

Test Case 12 To 14
    #Test "copy" icon
    Test Case 12
    Test Case 13
    Test Case 14

Test Case 15 To 17
    #Test "hidden" icon
    Test Case 15
    Test Case 16
    Test Case 17

Test Case 18 To 21
    #Test "delete" icon
    Test Case 18
    Test Case 19
    Test Case 20
    Test Case 21
 

