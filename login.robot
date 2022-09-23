*** Settings ***

Library    SeleniumLibrary

*** Variables ***
${email}    kai.ling+2@besquare.com.my
${password}    abcD1234 
${loading_interface}    //*[@aria-label="Loading interface..."]   


*** Keywords ***
Login To Deriv

    Open Browser    https://app.deriv.com/    chrome
    Maximize Browser Window
    Set Selenium Speed    1
    ## Wait Until Page Contains Element    //div[@class='btn-purchase__text_wrapper' and contains(.,'Rise')]    30
    Wait Until Page Does Not Contain Element   ${loading_interface}    30
    Click Element    dt_login_button
    Wait Until Page Contains Element    //input[@type='email']    10
    Input Text    //input[@type='email']    ${email}
    Input Text    //input[@type='password']    ${password}
    Click Element    //button[@type='submit']    
    Wait Until Page Contains Element   dt_core_account-info_acc-info    10

Check Real Account
    Wait Until Page Does Not Contain Element   ${loading_interface}    30
    Click Element    dt_core_account-info_acc-info
    Wait Until Page Contains Element    //div[@class="acc-switcher__loginid-text" and contains(.,"CR")]    10

Switch To Demo Account
    Click Element    dt_core_account-switcher_demo-tab 
    Wait Until Page Contains Element    dt_VRTC6756714    10
    Click Element    dt_VRTC6756714
    Wait Until Page Does Not Contain Element   ${loading_interface}    50
    
   
