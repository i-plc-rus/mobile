//
//  VerificationServiceTests.swift
//
//
//  Created by anbushmanov on 02.11.2024.
//

import XCTest
@testable import NotificationModule

final class VerificationServiceTests: XCTestCase {
    
    private var verificationService: IVerificationService!
    
    override func setUp() {
        super.setUp()
        
        verificationService = VerificationService()
    }
    
    override func tearDown() {
        verificationService = nil
        
        super.tearDown()
    }
}

// MARK: - Phone number tests

extension VerificationServiceTests {
    func test_phone_number_type_1() {
        XCTAssertTrue(verificationService.isValidPhoneNumber("+79217776655"))
    }
    
    func test_phone_number_type_2() {
        XCTAssertTrue(verificationService.isValidPhoneNumber("79217776655"))
    }
    
    func test_phone_number_type_3() {
        XCTAssertFalse(verificationService.isValidPhoneNumber("+89217776655"))
    }
    
    func test_phone_number_type_4() {
        XCTAssertTrue(verificationService.isValidPhoneNumber("89217776655"))
    }
    
    func test_phone_number_type_5() {
        XCTAssertFalse(verificationService.isValidPhoneNumber("+7 921 777 66 55"))
    }
    
    func test_phone_number_type_6() {
        XCTAssertTrue(verificationService.isValidPhoneNumber("+7 (921) 777 66 55"))
    }
    
    func test_phone_number_type_7() {
        XCTAssertTrue(verificationService.isValidPhoneNumber("+7 (921) 777 66 55"))
    }
    
    func test_phone_number_type_8() {
        XCTAssertFalse(verificationService.isValidPhoneNumber("+1 (921) 777 66 55"))
    }
    
    func test_invalid_phone_number() {
        XCTAssertFalse(verificationService.isValidPhoneNumber("99999"))
    }
    
    func test_empty_phone_number() {
        XCTAssertFalse(verificationService.isValidPhoneNumber(""))
    }
    
    func test_space_phone_number() {
        XCTAssertFalse(verificationService.isValidPhoneNumber(" "))
    }
    
    func test_letter_phone_number() {
        XCTAssertFalse(verificationService.isValidPhoneNumber("+7aaa9992233"))
    }
}

// MARK: - Email tests

extension VerificationServiceTests {
    func test_valid_email_com() {
        XCTAssertTrue(verificationService.isValidEmail("test@test.com"))
    }
    
    func test_valid_email_ru() {
        XCTAssertTrue(verificationService.isValidEmail("test@test.com"))
    }
    
    func test_invalid_email_without_prefix_1() {
        XCTAssertFalse(verificationService.isValidEmail("@test.com"))
    }
    
    func test_invalid_email_without_prefix_2() {
        XCTAssertFalse(verificationService.isValidEmail("@test.ru"))
    }
    
    func test_invalid_email_with_space_prefix() {
        XCTAssertFalse(verificationService.isValidEmail(" @test.ru"))
    }
    
    func test_invalid_email_only_at() {
        XCTAssertFalse(verificationService.isValidEmail("@"))
    }
    
    func test_invalid_email_without_at_() {
        XCTAssertFalse(verificationService.isValidEmail("testtest.ru"))
    }
    
    func test_invalid_email_random_string() {
        XCTAssertFalse(verificationService.isValidEmail("asdasdsad"))
    }
    
    func test_invalid_long_email() {
        XCTAssertFalse(verificationService.isValidEmail("testesttesttesttesttesttesttesttesttesttesttesttesttest@testtesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttest.com"))
    }
}
