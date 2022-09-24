*** Settings ***

Library    SeleniumLibrary

*** Variables ***
${email}    kai.ling+2@besquare.com.my
${password}    abcD1234 
${input_box_for_email}    //input[@type='email'] 
${input_box_for_password}   //input[@type='password'] 

${loading_interface}    //*[@aria-label="Loading interface..."]   
${app_deriv_com}    https://app.deriv.com/

${login_btn}    dt_login_button
${login_btn_submit_info}     //button[@type='submit' and text()="Log in"]   
${acc_info_btn}    dt_core_account-info_acc-info
${real_acc_id}    //div[@class="acc-switcher__loginid-text" and contains(.,"CR")]

${demo_acc_switcher_tab}    dt_core_account-switcher_demo-tab
${virtual_acc_name}    //*[@class="acc-switcher__id" ]/span[text()="Demo"]
${virtual_acc}    //*[@class="acc-switcher__accounts"]

*** Keywords ***
Wait For Page To Complete Loading
    Wait Until Page Does Not Contain Element   ${loading_interface}    50

Login To Deriv

    Open Browser    ${app_deriv_com}   chrome
    Maximize Browser Window
    Set Selenium Speed    1
    Wait For Page To Complete Loading 
    Click Element    ${login_btn}
    Wait For Page To Complete Loading 
    Input Text    ${input_box_for_email}     ${email}
    Input Text    ${input_box_for_password}    ${password}
    Click Element    ${login_btn_submit_info}   
    Wait For Page To Complete Loading 
Check Real Account
    Click Element    ${acc_info_btn}
    Wait Until Page Contains Element    ${real_acc_id}    10

Switch To Demo Account
    Click Element    ${demo_acc_switcher_tab}
    Wait Until Page Contains Element    ${virtual_acc_name}   10
    Click Element    ${virtual_acc}    
    Wait For Page To Complete Loading 
    
   
