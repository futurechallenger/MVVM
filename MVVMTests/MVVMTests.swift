//
//  MVVMTests.swift
//  MVVMTests
//
//  Created by Bruce Lee on 9/12/14.
//  Copyright (c) 2014 Dynamic Cell. All rights reserved.
//

import UIKit
import XCTest
import CoreData

class MVVMTests: XCTestCase {
    
    var calendar: NSCalendar?
    var locale: NSLocale?
//    let expectation = expectationWithDescription(description: "")
    
    override func setUp() {
        super.setUp()

        self.calendar = NSCalendar(identifier: NSGregorianCalendar)
        self.locale = NSLocale(localeIdentifier: "en_US")
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        XCTAssert(true, "Pass")
    }
    
    func testAsynchronousURLConnection(){
        let URL = NSURL(string: "http://www.baidu.com/")!
        let expectation = expectationWithDescription("GET \(URL)")
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(URL, completionHandler: {(data, response, error) in
            expectation.fulfill()   // 告诉expectation满足测试了
            
            XCTAssertNotNil(data, "返回数据不应该为空")
            XCTAssertNil(error, "error应该为nil")
            
            if response != nil {
                var httpResponse: NSHTTPURLResponse = response as NSHTTPURLResponse
                XCTAssertEqual(httpResponse.URL!.absoluteString!, URL.absoluteString!, "HTTPResponse的URL应该和请求URL一致")
                XCTAssertEqual(httpResponse.statusCode, 200, "HTTPResponse状态码应该是200")
                XCTAssertEqual(httpResponse.MIMEType!, "text/html", "HTTPResponse内容应该是text/html")
            }
            else{
                XCTFail("返回内容不是NSHTTPURLResponse类型")
            }
        })
        
        task.resume()
        
        waitForExpectationsWithTimeout(task.originalRequest.timeoutInterval, handler: {error in
            task.cancel()
        })
    }
    
    func testFetchRequestWithMockedManagedObjectContext() {
        class MockNSManagedObjectContext: NSManagedObjectContext {
            private override func executeFetchRequest(request: NSFetchRequest, error: NSErrorPointer) -> [AnyObject]? {
                return [["name": "张三", "email": "zhangsan@apple.com"]]
            }
        }
        
        let mockContext = MockNSManagedObjectContext()
        let fetchRequest = NSFetchRequest(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "email ENDSWITH[cd] %@", "apple.com")
        fetchRequest.resultType = NSFetchRequestResultType.DictionaryResultType
        
        var error: NSError?
        let results = mockContext.executeFetchRequest(fetchRequest, error: &error)
        
        XCTAssertNil(error, "error应该为nil")
        XCTAssertEqual(results!.count, 1, "fetch request应该只返回一个结构")
        
        let result = results![0] as [String: String]
        XCTAssertEqual(result["name"]! as String, "张三", "name应该是张三")
        XCTAssertEqual(result["email"]! as String, "zhangsan@apple.com", "email应该是zhangsan@apple.com")
    }
    
    func testPerformanceExample() {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .LongStyle
        dateFormatter.timeStyle = .ShortStyle
        
        let date = NSDate()
        
        self.measureBlock() {
            let string = dateFormatter.stringFromDate(date)
        }
    }
    
}
