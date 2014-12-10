//
//  ViewController.swift
//  MVVM
//
//  Created by Bruce Lee on 9/12/14.
//  Copyright (c) 2014 Dynamic Cell. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var model: Person!
    var viewModel: PersonViewModel!
    var nameLabel: UILabel!
    var birthDateLabel: UILabel!
    
    @IBOutlet weak var operationButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.nameLabel.text = self.viewModel.nameText
//        self.birthDateLabel.text = self.viewModel.birthDateText
    }
    
    @IBAction func startAction(button: UIButton){
//        var group = dispatch_group_create()
//        dispatch_group_async(group, dispatch_get_global_queue(0, 0), {
//            println("first queue")
//        })
//        dispatch_group_async(group, dispatch_get_global_queue(0, 0), {
//            println("second queue")
//        })
//        dispatch_group_async(group, dispatch_get_global_queue(0, 0), {
//            println("third queue")
//        })
//        
//        dispatch_group_notify(group, dispatch_get_main_queue(), {
//            println("main queue")
//        })
        
        var semaphore = dispatch_semaphore_create(0)
        var condition = 1000
        
        dispatch_async(dispatch_get_global_queue(0, 0), {
            var localCondition = condition
            while localCondition-- > 0 {
                if dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER) == 0{
                    println("consume resource")
                }
            }
        })
        
        dispatch_async(dispatch_get_global_queue(0, 0), {
            var localCondition = 10
            while localCondition-- > 0{
                dispatch_semaphore_signal(semaphore)
                println("create resource")
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

