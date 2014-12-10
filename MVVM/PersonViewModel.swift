//
//  PersonViewModel.swift
//  MVVM
//
//  Created by Bruce Lee on 9/12/14.
//  Copyright (c) 2014 Dynamic Cell. All rights reserved.
//

import UIKit

class PersonViewModel {
    var person: Person!
    var nameText: String?
    var birthDateText: String?
    
    init(person: Person){
        self.person = person
        
        if self.person?.salutation?.utf16Count > 0{
            self.nameText = "\(self.person.salutation!) \(self.person.firstName!) \(self.person.lastName!)"
        }
        else{
            self.nameText = "\(self.person.firstName!) \(self.person.lastName!)"
        }
        
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "EEEE MMMM d, yyyy"
        self.birthDateText = dateFormatter.stringFromDate(self.person.birthDate!)
    }
}

