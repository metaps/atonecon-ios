//
//  SessionTest.swift
//  AtoneCon
//
//  Created by Pham Ngoc Hanh on 8/18/17.
//  Copyright © 2017 AsianTech Inc. All rights reserved.
//

import XCTest
@testable import AtoneCon

class SessionTest: XCTestCase {

    func testInitCredential() {
        // When
        let credential = Session.Credential(value: "tk_23adh123bvnjKhds")

        // Then
        XCTAssertEqual(credential.value, "tk_23adh123bvnjKhds")
    }

    func testloadCredential() {
        // When credential hasn't value
        Session.shared.credential = Session.Credential(value: nil)
        Session.shared.loadCredential()

        // Then
        XCTAssertEqual(Session.shared.credential.isValid, false)

        // When credential has value
        Session.shared.credential = Session.Credential(value: "tk_23adh123bvnjKhds")
        Session.shared.loadCredential()

        // Then
        XCTAssertEqual(Session.shared.credential.isValid, true)
        XCTAssertEqual(Session.shared.credential.value, "tk_23adh123bvnjKhds")
    }

    func testClearCredential() {
        // When load credential has value
        Session.shared.credential = Session.Credential(value: "tk_23adh123bvnjKhds")
        Session.shared.clearCredential()

        // Then
        XCTAssertEqual(Session.shared.credential.value, "")
    }
}
