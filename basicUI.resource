*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${text_input}            xpath://input[@class='new-todo']
${select_all_toggle}     xpath://input[@class='toggle-all']
${select_toggle}         xpath://input[@class='toggle']
${delete_btn}            xpath://button[@class='destroy']
${clear_btn}             xpath://button[@class='clear-completed']
${saved_todo}            xpath://label[@data-testid='todo-item-label']


*** Keywords ***
Add New To-do    
    [Arguments]    ${value}
    Input Text    ${text_input}    ${value}
    Press Keys    ${None}    ENTER

Edit To-do
    [Arguments]    ${old_value}    ${new_value}
    Double Click Element    ${saved_todo}    
    Press Keys    ${None}    CTRL+A+BACKSPACE
    Press Keys    ${None}    ${new_value} 
    Press Keys    ${None}    ENTER

Delete To-do
    Mouse Over    ${saved_todo}
    Click Element    ${delete_btn}

Select To-do
    Click Element   ${select_toggle}

Select All Todos
    Click Element    ${select_all_toggle}

Clear All Todos
    Click Button    ${clear_btn}