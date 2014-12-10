//
//  ViewModelTest.swift
//  MVVM
//
//  Created by Bruce Lee on 9/12/14.
//  Copyright (c) 2014 Dynamic Cell. All rights reserved.
//

import UIKit
import XCTest

class ViewModelTest: XCTestCase {

    var person: Person!
    
    override func setUp() {
        super.setUp()
        var salutation = "Dr."
        var firstName = "first"
        var lastName = "last"
        var birthDate = NSDate(timeIntervalSince1970: 0)
        self.person = Person(salutation: salutation, firstName: firstName, lastName: lastName, birthDate: birthDate)
    }

    func testUserSalutation(){
        var viewModel = PersonViewModel(person: self.person)
        XCTAssert(viewModel.nameText! == "Dr. first last" , "use salutation available \(viewModel.nameText!)")
    }

    func testNoSalutation(){
        var localPerson = Person(salutation: nil, firstName: "first", lastName: "last", birthDate: NSDate(timeIntervalSince1970: 0))
        var viewModel = PersonViewModel(person: localPerson)
        XCTAssert(viewModel.nameText! == "first last", "should not use salutation \(viewModel.nameText!)")
    }
    
    func testBirthDateFormat(){
        var viewModel = PersonViewModel(person: self.person)
        XCTAssert(viewModel.birthDateText! == "Thursday January 1, 1970", "date \(viewModel.birthDateText!)")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
}
