//
//  CustomerTest.swift
//  AtoneCon
//
//  Created by Pham Ngoc Hanh on 8/18/17.
//  Copyright © 2017 AsianTech Inc. All rights reserved.
//

import XCTest
import ObjectMapper
@testable import AtoneCon

class CustomerTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testInitCustomer() {
        // Given
        var customer = AtoneCon.Customer(name: "接続テスト")
        customer.nameKana = "セツゾクテスト"
        customer.companyName = "（株）ネットプロテクションズ"
        customer.department = "セールスグループ"
        customer.zipCode = "1234567"
        customer.address = "東京都中央区銀座１－１０ー６　銀座ファーストビル４階"
        customer.tel = "080-1234-1234"
        customer.email = "np@netprotections.co.jp"
        customer.totalPurchaseAmount = 20_000
        customer.totalPurchaseCount = 2

        // Then
        XCTAssertEqual(customer.name, "接続テスト")
        XCTAssertNil(customer.familyName)
        XCTAssertNil(customer.givenName)
        XCTAssertEqual(customer.nameKana, "セツゾクテスト")
        XCTAssertNil(customer.familyNameKana)
        XCTAssertNil(customer.givenNameKana)
        XCTAssertNil(customer.phoneNumber)
        XCTAssertNil(customer.birthday)
        XCTAssertNil(customer.sexDivision)
        XCTAssertEqual(customer.companyName, "（株）ネットプロテクションズ")
        XCTAssertEqual(customer.department, "セールスグループ")
        XCTAssertEqual(customer.zipCode, "1234567")
        XCTAssertEqual(customer.address, "東京都中央区銀座１－１０ー６　銀座ファーストビル４階")
        XCTAssertEqual(customer.tel, "080-1234-1234")
        XCTAssertEqual(customer.email, "np@netprotections.co.jp")
        XCTAssertEqual(customer.totalPurchaseAmount, 20_000)
        XCTAssertEqual(customer.totalPurchaseCount, 2)
    }

    func testInitObjetMapper() {
        // When
        let map = Map(mappingType: .fromJSON, JSON: [:], toObject: false, context: nil, shouldIncludeNilValues: true)
        guard let customer: AtoneCon.Customer = AtoneCon.Customer(map: map) else { return }

        // Then

        XCTAssertEqual(customer.name, "")
        XCTAssertNil(customer.familyName)
        XCTAssertNil(customer.givenName)
        XCTAssertNil(customer.nameKana)
        XCTAssertNil(customer.familyNameKana)
        XCTAssertNil(customer.givenNameKana)
        XCTAssertNil(customer.phoneNumber)
        XCTAssertNil(customer.birthday)
        XCTAssertNil(customer.sexDivision)
        XCTAssertNil(customer.companyName)
        XCTAssertNil(customer.department)
        XCTAssertNil(customer.zipCode)
        XCTAssertNil(customer.address)
        XCTAssertNil(customer.tel)
        XCTAssertNil(customer.email)
        XCTAssertNil(customer.totalPurchaseCount)
        XCTAssertNil(customer.totalPurchaseAmount)
    }

    func testMapping() {
        // When
        var customer = AtoneCon.Customer(name: "hanh")
        customer.department = "AsianTech"
        customer.email = "hanh.pham@asiantech.vn"
        customer.phoneNumber = "01202423340"

        let json = "{\"customer_name\":\"hanh\"," +
                    "\"department\":\"AsianTech\"," +
                    "\"email\":\"hanh.pham@asiantech.vn\"," +
                    "\"phone_number\":\"01202423340\"}"

        // Then
        XCTAssertNotNil(customer.toJSONString())
        if let jsonString = customer.toJSONString() {
            XCTAssertEqual(jsonString, json)
        }
    }
}
