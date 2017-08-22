//
//  AtoneConTests.swift
//  AtoneConTests
//
//  Created by Pham Ngoc Hanh on 6/28/17.
//  Copyright © 2017 AsianTech Inc. All rights reserved.
//

import XCTest
@testable import AtoneCon

class AtoneConTests: XCTestCase {

    func testConfig() {
        // When
        let option = AtoneCon.Options(publicKey: "abcxyz")
        AtoneCon.shared.config(option)

        // Then 
        XCTAssertEqual(AtoneCon.shared.option?.publicKey, "abcxyz")
    }

    func testResetAuthenToken() {
        // When 
        Session.shared.credential = Session.Credential(value: "aaabbbccc")
        AtoneCon.shared.resetAuthenToken()

        // Then 
        XCTAssertEqual(Session.shared.credential.value, "")
    }
}
