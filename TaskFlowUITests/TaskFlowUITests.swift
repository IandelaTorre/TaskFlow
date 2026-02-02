//
//  TaskFlowUITests.swift
//  TaskFlowUITests
//
//  Created by Ian Axel Perez de la Torre on 17/11/25.
//

import XCTest

final class TaskFlowUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
    }

    @MainActor
    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
        print(app.navigationBars.debugDescription)
    }
    
    @MainActor
    func testCreateTask() throws {
        // Login
        let app = XCUIApplication()
        app.activate()
        
        let emailLogin = app.textFields["login_tf_email"]
        XCTAssertTrue(emailLogin.exists)
        emailLogin.tap()
        emailLogin.typeText("ui.test.1770005204@mailinator.com")
        
        let passwordLogin = app.secureTextFields["login_tf_password"]
        XCTAssertTrue(passwordLogin.exists)
        passwordLogin.tap()
        passwordLogin.typeText("NewPass123.")
        
        let loginButton = app.buttons["login_btn_submit"]
        XCTAssertTrue(loginButton.exists)
        loginButton.tap()
        
        XCTAssertTrue(app.staticTexts["home_lbl_user_name"].waitForExistence(timeout: 10))

        let navBar = app.navigationBars["Mis tareas"]
        XCTAssertTrue(navBar.exists)
        let addButton = navBar.buttons.firstMatch

        XCTAssertTrue(addButton.exists, "No se encontró el botón de Agregar")
        addButton.tap()
        
        XCTAssertTrue(app.staticTexts["addt_lbl_title"].waitForExistence(timeout: 10))
        
        let assignToTf = app.textFields["addt_tf_assign_to"]
        XCTAssertTrue(assignToTf.exists)
        assignToTf.tap()
        assignToTf.typeText("TES-vpsn5")
        
        let taskDescription = app.textViews["addt_tv_task_description"]
        XCTAssertTrue(taskDescription.exists)
        taskDescription.tap()
        taskDescription.typeText("Prueba de la descripcion de una tarea que es importante para ver que todo este funcionando correctamente. ")
        
        let taskTitle = app.textFields["addt_tf_task_title"]
        XCTAssertTrue(taskTitle.exists)
        taskTitle.tap()
        taskTitle.typeText("Prueba: \(Int(Date().timeIntervalSince1970))")
        taskTitle.typeText("\r")
        
        let createTask = app.buttons["addt_btn_submit"]
        XCTAssertTrue(createTask.exists)
        createTask.tap()
        
        XCTAssertTrue(app.staticTexts["home_lbl_user_name"].waitForExistence(timeout: 10))

        //Sign out
        XCTAssertTrue(app.staticTexts["home_lbl_user_name"].waitForExistence(timeout: 10))
        
        let signOutButton = app.buttons["home_btn_sign_out"]
        XCTAssertTrue(signOutButton.exists)
        signOutButton.tap()
        
        XCTAssertTrue(app.staticTexts["login_lbl_welcome"].waitForExistence(timeout: 10))
    }
    
    @MainActor
    func testLogin() throws {
        let app = XCUIApplication()
        app.activate()
        
        let emailLogin = app.textFields["login_tf_email"]
        XCTAssertTrue(emailLogin.exists)
        emailLogin.tap()
        emailLogin.typeText("ui.test.1770005204@mailinator.com")
        
        let passwordLogin = app.secureTextFields["login_tf_password"]
        XCTAssertTrue(passwordLogin.exists)
        passwordLogin.tap()
        passwordLogin.typeText("NewPass123.")
        
        let loginButton = app.buttons["login_btn_submit"]
        XCTAssertTrue(loginButton.exists)
        loginButton.tap()
        
        XCTAssertTrue(app.staticTexts["home_lbl_user_name"].waitForExistence(timeout: 10))
        
        let signOutButton = app.buttons["home_btn_sign_out"]
        XCTAssertTrue(signOutButton.exists)
        signOutButton.tap()
        
        XCTAssertTrue(app.staticTexts["login_lbl_welcome"].waitForExistence(timeout: 10))
    }
    
    @MainActor
    func testRecoveryPassword() throws {
        let app = XCUIApplication()
        app.activate()
        
        let navRecoveryPassword = app.buttons["login_btn_rp_nav"]
        XCTAssertTrue(navRecoveryPassword.exists)
        navRecoveryPassword.tap()
        
        let emailRP = app.textFields["rp_tf_email"]
        XCTAssertTrue(emailRP.exists)
        emailRP.tap()
        emailRP.typeText("ui.test.1770005204@mailinator.com")
        
        let codeRP = app.textFields["rp_tf_code"]
        XCTAssertTrue(codeRP.exists)
        codeRP.tap()
        codeRP.typeText("123456")
        
        let passwordRP = app.secureTextFields["rp_tf_password"]
        XCTAssertTrue(passwordRP.exists)
        passwordRP.tap()
        passwordRP.typeText("NewPass123.")
        
        let ReEnterpasswordRP = app.secureTextFields["rp_tf_re_password"]
        XCTAssertTrue(ReEnterpasswordRP.exists)
        ReEnterpasswordRP.tap()
        ReEnterpasswordRP.typeText("NewPass123.")
        ReEnterpasswordRP.typeText("\r")
        
        let recoveryPasswordButton = app.buttons["rp_btn_submit"]
        XCTAssertTrue(recoveryPasswordButton.exists)
        recoveryPasswordButton.tap()
        
        XCTAssertTrue(app.staticTexts["login_lbl_welcome"].waitForExistence(timeout: 10))
    }
    
    @MainActor
    func testCreateAccount() throws {
        let app = XCUIApplication()
        app.activate()
        
        let email = "ui.test.\(Int(Date().timeIntervalSince1970))@mailinator.com"
        
        let navCreateAccount = app.buttons["login_btn_signup_nav"]
        XCTAssertTrue(navCreateAccount.exists)
        navCreateAccount.tap()
        
        let nameTf = app.textFields["signup_tf_names"]
        XCTAssertTrue(nameTf.exists)
        nameTf.tap()
        nameTf.typeText("Test")
        
        let lastNameTf = app.textFields["signup_tf_last_name"]
        XCTAssertTrue(lastNameTf.exists)
        lastNameTf.tap()
        lastNameTf.typeText("UI")
        
        let emailTf = app.textFields["signup_tf_email"]
        XCTAssertTrue(emailTf.exists)
        emailTf.tap()
        emailTf.typeText(email)
        
        let passwordTf = app.secureTextFields["signup_tf_password"]
        XCTAssertTrue(passwordTf.exists)
        passwordTf.tap()
        passwordTf.typeText("Admin123.")
        
        let createAccountButton = app.buttons["signup_btn_submit"]
        XCTAssertTrue(createAccountButton.exists)
        createAccountButton.tap()
        
        XCTAssertTrue(app.staticTexts["login_lbl_welcome"].waitForExistence(timeout: 10))
    }

    @MainActor
    func testLaunchPerformance() throws {
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
}
