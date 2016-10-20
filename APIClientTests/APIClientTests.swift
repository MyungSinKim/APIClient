//
//  APIClientTests.swift
//  APIClientTests
//
//  Created by Eugene Andreyev on 7/8/16.
//  Copyright © 2016 Eugene Andreyev. All rights reserved.
//

import XCTest
@testable import APIClient
import BoltsSwift


struct StarRepositoryRequest: SerializeableAPIRequest {
    
    let method: APIRequestMethod = .put
    let path: String
    
    let parser = EmptyParser()
    
    init(name: String) {
        path = "user/starred/" + name
    }
}

class APIClientTests: XCTestCase {
    
    func testAuthRequest() {
        let client = APIClient(requestExecutor: AlamofireRequestExecutor(baseURL: URL(string: "https://api.github.com")!))
        let request = StarRepositoryRequest(name: "serejahh/UnboxedAlamofire")
        
        let exp = expectation(description: "task")
        
        client.execute(request: request).continueWith { task in
            dump(task)
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
}
