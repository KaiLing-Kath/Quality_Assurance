#Project 2: Automation on account closing

*** Settings ***

Library  SeleniumLibrary
Resource    ../Resource/login.robot

*** Variables ***

${acct_setting_icon}    //*[@class="account-settings-toggle"]
${personal_details_tab_active}    //*[@id="dc_personal-details_link" and contains(@class,"--active")]
${personal_details_content}    //*[@class="account-form account-form__personal-details"]
${closs_acc_tab}    //*[@id="/account/closing-account"]
${closs_acc_tab_content}    //*[@class="closing-account"]
${link}    //*[text()="Security and privacy policy"]
${cancel_btn}    //*[text()="Cancel"]//parent::button
${close_my_account_btn}    //*[text()="Close my account"]//parent::button
${pdf_url}    https://deriv.com/tnc/security-and-privacy.pdf
${closing_acc_reason_list}    //*[@class="closing-account-reasons"]
${checked_box}    //*[@class="dc-checkbox closing-account-reasons__checkbox"]//child::span[contains(@class,"--active")]
${back_btn}    //*[text()="Back"]//parent::button
${Continue_btn_disabled}    //button[@disabled]/span[text()="Continue"]
${continue_btn}    //*[text()="Continue"]//parent::button
${close_acc_confirmation_popup}    //*[@class="account-closure-warning-modal"]
${reason_1}    //*[text()="I have other financial priorities."]//parent::label
${reason_2}    //*[text()="I want to stop myself from trading."]//parent::label
${go_back_btn}    //*[text()="Go Back"]//parent::button 
${close_acc_btn}    //*[text()="Close account"]//parent::button 
${reactivate_page}    //*[@class="reactivate-account"]

*** Keywords ***
Is Any Box Checked    
   ${is_any_box_checked}=    Run Keyword And Return Status    Page Should Contain Element    ${checked_box}
    RETURN     ${is_any_box_checked}
Test Case 2
#Test if account setting clickable 
    Click Element    ${acct_setting_icon} 
    Wait For Page To Complete Loading
    Page Should Contain Element    ${personal_details_tab_active}
    Page Should Contain Element    ${personal_details_content} 
Test Case 3
#Test if the “Close your account ” tab is clickable and whether it redirect to “Close account” page 
    Click Element     ${closs_acc_tab}
    Wait For Page To Complete Loading
    Page Should Contain Element    ${closs_acc_tab_content}
Test Case 4
#Test if the “Security and privacy policy” link is clickable and whether it open related document in a new browser 
    Click Element    ${link}
    ${windowhandles}=     Get Window Handles
    Switch Window    ${windowhandles}[1]
    ${current_url}=   Get Location
    Should Be Equal As Strings    ${current_url}    ${pdf_url}
    close window
    Switch Window    ${windowhandles}[0]

Test Case 5
    #Test if “Cancel” button is clickable and whether it will redirect to Deriv main page
    Click Element    ${cancel_btn}
    Wait For Page To Complete Loading
    ${current_url}=   Get Location
    Should Be Equal As Strings    ${current_url}    ${app_deriv_com} 
    #To redirect back to back "Close account page"
    Test Case 2
    Test Case 3

Test Case 6
#Test if “Close my account” button is clickable and whether it will redirect to “Please tell us why you’re leaving” page
    Click Element    ${close_my_account_btn}   
    Wait For Page To Complete Loading
    Page Should Contain Element    ${closing_acc_reason_list}

Test Case 7
#Test if the “Back” button is clickable and whether it redirected back to “Close account” page 
    Click Element    ${back_btn} 
    Wait For Page To Complete Loading
    Page Should Contain Element    ${closs_acc_tab_content}

Test Case 8
#Test if none of the box is checked,  is the “Continue button clickable”
    Click Element    ${close_my_account_btn} 
    Wait For Page To Complete Loading
    ${is_any_box_checked}=    Is Any Box Checked  
    IF  ${is_any_box_checked} is False
        Page Should Contain Element    ${Continue_btn_disabled}
    END

Test Case 9
#Test if any of the box is checked, is the “Continue” button clickable
    ${is_any_box_checked}=    Is Any Box Checked  
    Click Element    ${reason_1}   
    Click Element    ${reason_2}
    IF  ${is_any_box_checked} is True
        Page Should Not Contain Element    ${Continue_btn_disabled}
    END

Test Case 10
#Test if after “Continue” button is clicked, is there any popup window 
    Click Element    ${continue_btn}
    Wait For Page To Complete Loading
    Page Should Contain Element    ${close_acc_confirmation_popup}

Test Case 11
#Test if after “Go Back” button is clicked, redirected back to “Please tell us why you’re leaving” page
    Click Element    ${go_back_btn}
    Wait For Page To Complete Loading
    Page Should Contain Element    ${closing_acc_reason_list}

Test Case 12
#Test if after “Close account” button is clicked, is account closed
    Click Element    ${continue_btn}
    Wait For Page To Complete Loading
    Click Element    ${close_acc_btn}
    Login To Deriv
    Wait For Page To Complete Loading
    Page Should Contain Element    ${reactivate_page} 
    #Click Element    btnGrant

*** Test Cases ***
Test case 1
    Login To Deriv
    Check Real Account
Test Case 2
    Test case 2
Test Case 3
    Test case 3
Test Case 4
    Test Case 4
Test Case 5
    Test Case 5
Test Case 6
    Test Case 6
Test Case 7
    Test Case 7
Test Case 8
    Test Case 8
Test Case 9
    Test Case 9
Test Case 10
    Test Case 10
Test Case 11
    Test Case 11
Test Case 12
    Test Case 12