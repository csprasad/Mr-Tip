//
//  tip_calculatorTests.swift
//  tip-calculatorTests
//
//  Created by CS Prasad on 27/10/23.
//

import XCTest
import Combine
@testable import tip_calculator

final class tip_calculatorTests: XCTestCase {

    // sut -> System Under Test
    private var sut: CalculatorVM!
    private var cancellables: Set<AnyCancellable>!
    private var logoViewTapSubject: PassthroughSubject<Void, Never>!
    private var audioPlayerService: MockAudioPlayerService!
    
    override func setUp() {
        audioPlayerService = .init()
        sut = .init(audioPlayerService: audioPlayerService)
        logoViewTapSubject = .init()
        cancellables = .init()
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        cancellables = nil
        audioPlayerService = nil
        logoViewTapSubject = nil
    }
    
    func testResultWithoutTipFor1Person() {
        //give
        let bill: Double = 100.0
        let tip: Tip = .none
        let split: Int = 1
        
        let input = buildInput(bill: bill,
                               tip: tip,
                               split: split)
        
        //when
        let output = sut.transform(input: input)
        
        //then
        output.updateViewPublisher.sink { result in
            XCTAssertEqual(result.amountPerPerson, 100)
            XCTAssertEqual(result.totalBill, 100)
            XCTAssertEqual(result.totalTip, 0)
        }.store(in: &cancellables)
    }
    
    func testResultwithoutTip2Person() {
        //give
        let bill: Double = 100.0
        let tip: Tip = .none
        let split: Int = 2
        
        let input = buildInput(bill: bill,
                               tip: tip,
                               split: split)
        
        //when
        let output = sut.transform(input: input)
        
        //then
        output.updateViewPublisher.sink { result in
            XCTAssertEqual(result.amountPerPerson, 50)
            XCTAssertEqual(result.totalBill, 100)
            XCTAssertEqual(result.totalTip, 0)
        }.store(in: &cancellables)
    }
    
    func testResultWith10PercentFor2Person() {
        //give
        let bill: Double = 100.0
        let tip: Tip = .tenPercent
        let split: Int = 2
        
        let input = buildInput(bill: bill,
                               tip: tip,
                               split: split)
        
        //when
        let output = sut.transform(input: input)
        
        //then
        output.updateViewPublisher.sink { result in
            XCTAssertEqual(result.amountPerPerson, 55)
            XCTAssertEqual(result.totalBill, 110)
            XCTAssertEqual(result.totalTip, 10)
        }.store(in: &cancellables)
    }
    
    func testResultWithCustomTipFor4Person() {
        //give
        let bill: Double = 100.0
        let tip: Tip = .custom(value: 200)
        let split: Int = 2
        
        let input = buildInput(bill: bill,
                               tip: tip,
                               split: split)
        
        //when
        let output = sut.transform(input: input)
        
        //then
        output.updateViewPublisher.sink { result in
            XCTAssertEqual(result.amountPerPerson, 150)
            XCTAssertEqual(result.totalBill, 300)
            XCTAssertEqual(result.totalTip, 200)
        }.store(in: &cancellables)
    }
    
    func testSoundPlayedAndCalculatorRestOnLogoViewTap() {
        //given
        let input = buildInput(bill: 100, tip: .tenPercent, split: 2)
        let output = sut.transform(input: input)
        let expectation1 = XCTestExpectation(description: "reset calculator called")
        let expectation2 = audioPlayerService.expectation
        //then
        output.resetCalculatorPublisher.sink { _ in
            expectation1.fulfill()
        }.store(in: &cancellables)
        
        //when
        logoViewTapSubject.send()
        wait(for: [expectation1, expectation2], timeout: 1.0)
    }
    
    private func buildInput(bill: Double, tip: Tip, split: Int) -> CalculatorVM.Input {
        return .init(billPublisher: Just(bill).eraseToAnyPublisher(),
                     tipPublisher: Just(tip).eraseToAnyPublisher(),
                     splitPublisher: Just(split).eraseToAnyPublisher(),
                     logoViewTapPublisher: logoViewTapSubject.eraseToAnyPublisher())
    }
}


class MockAudioPlayerService: AudioPlayerService {
    var expectation = XCTestExpectation(description: "playSound is called")
    func playSound() {
        expectation.fulfill()
    }
}
