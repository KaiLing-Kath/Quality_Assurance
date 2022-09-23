*** Settings ***

Library  SeleniumLibrary
Resource    login.robot

*** Keywords ***
Verify Virtual Account
    Wait Until Page Contains Element    //div[@id="dt_core_account-info_acc-info" and contains(@class,"--is-virtual")]    10


*** Test Cases ***
Login To Deriv
    Login To Deriv
Check Real Account
    Check Real Account
Switch To Demo Account
    Switch To Demo Account
Verify Virtual Account
    Verify Virtual Account