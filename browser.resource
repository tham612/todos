*** Settings ***
Library    SeleniumLibrary


*** Variables ***
${url}    https://todomvc.com/examples/react/dist/#/    


*** Keywords ***
Open Todos Page    
    Open Browser    ${url}    browser=chrome
    Maximize Browser Window

Close Todos Page
    Close Browser
    
