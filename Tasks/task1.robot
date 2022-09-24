#Task 1

*** Settings ***

Library  SeleniumLibrary
Resource    ../Resource/login.robot

***Variables***
${virtual_acc_info_btn}    //div[@id="dt_core_account-info_acc-info" and contains(@class,"--is-virtual")]

*** Keywords ***
Verify Virtual Account
    Wait Until Page Contains Element    ${virtual_acc_info_btn}    10


*** Test Cases ***
Login To Deriv
    Login To Deriv
Check Real Account
    Check Real Account
Switch To Demo Account
    Switch To Demo Account
Verify Virtual Account
    Verify Virtual Account