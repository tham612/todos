*** Settings ***
Library    SeleniumLibrary
Resource    infrastructure/browser.resource
Resource    infrastructure/basicUI.resource

Suite Setup    Open Todos Page
Suite Teardown    Close Todos Page
Test Teardown    Clear Cache


*** Variables ***
${all_page}        xpath://a[normalize-space()='All']
${active_page}     xpath://a[normalize-space()='Active']
${complete_page}   xpath://a[normalize-space()='Completed']
${todo_count}      xpath://span[@class="todo-count"]

*** Test Cases ***
Scenario 1: User adds, edits and removes a to-do
    Add New To-do    test-todo-1
    Verify To-do State    Active    ${active_page}    test-todo-1
    Edit To-do    test-todo-1    new-test-todo-1
    Verify To-do State    Active     ${active_page}    new-test-todo-1
    Wait Until Keyword Succeeds
        ...    3x    500ms    Delete To-do
    Verify To-do State    Delete
    
Scenario 2: User adds and sets a to-do to complete
    Add New To-do    test-todo-1
    Verify To-do State    Active    ${active_page}    test-todo-1
    Select To-do
    Verify To-do State    Complete    ${complete_page}    test-todo-1

Scenario 3: User sets a completed to-do to active 
    Add New To-do    test-todo-1
    Select To-do
    Click Element    ${complete_page}
    Select To-do
    Verify To-do State    Active     ${active_page}    test-todo-1

Scenario 4: User adds todos and sets all todos to complete
    Add New To-do    test-todo-1
    Add New To-do    test-todo-2
    Add New To-do    test-todo-3
    Select All Todos
    Verify To-do State    Complete    ${complete_page}    test-todo-1
    Verify To-do State    Complete    ${complete_page}    test-todo-2
    Verify To-do State    Complete    ${complete_page}    test-todo-3
    Clear All Todos
    Verify To-do State    Clear


*** Keywords ***
Verify To-do State  
    [Arguments]    ${state}    ${element}=${None}    ${value}=${None}
    IF    "${state}" == "Active" or "${state}" == "Complete"
        Click Element  ${element}
        ${status}=    Run Keyword And Return Status    Wait Until Page Contains Element    xpath://label[@data-testid='todo-item-label' and contains(normalize-space(), '${value}')]
        IF    "${status}" == "False"
            Fail    The to-do is not saved/updated/completed!
        END
    ELSE
        Run Keyword And Warn On Failure    Page Should Not Contain Element    ${saved_todo}
    END

Clear Cache
    ${status}=    Run Keyword And Return Status    Wait Until Page Contains Element    ${todo_count}
    IF    "${status}" == "True"
        Click Element    ${all_page}
        Wait Until Keyword Succeeds
        ...    3x    500ms    Delete To-do
    END

         
    