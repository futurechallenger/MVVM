//
//  Person.swift
//  MVVM
//
//  Created by Bruce Lee on 9/12/14.
//  Copyright (c) 2014 Dynamic Cell. All rights reserved.
//

import UIKit

class Person {
    var salutation: String?
    var firstName: String?
    var lastName: String?
    var birthDate: NSDate?
    
    init(salutation: String?, firstName: String?, lastName: String?, birthDate: NSDate?){
        self.salutation = salutation
        self.firstName = firstName
        self.lastName = lastName
        self.birthDate = birthDate
    }
}
