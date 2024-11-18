//
//  CalculatorModel 2.swift
//  CalacSwiftUI
//
//  Created by Mohamed Selim on 18/11/2024.
//


import Foundation

class CalculatorModel: ObservableObject {
    @Published var displayValue: String = "0"
    private var currentOperation: String? = nil
    private var firstValue: Double? = nil
    private var isTypingNumber = false
    
    // وظائف العمليات الحسابية
    func didTap(button: String) {
        switch button {
        case "AC":
            resetCalculator()
        case "+/-":
            toggleSign()
        case "%":
            applyPercentage()
        case ".":
            addDecimalPoint()
        case "÷", "×", "-", "+":
            setOperation(button)
        case "=":
            calculateResult()
        default:
            appendDigit(button)
        }
    }
    
    // إعادة تعيين الآلة الحاسبة
    private func resetCalculator() {
        displayValue = "0"
        currentOperation = nil
        firstValue = nil
        isTypingNumber = false
    }
    
    // تغيير الإشارة
    private func toggleSign() {
        if let value = Double(displayValue) {
            displayValue = String(value * -1)
        }
    }
    
    // تحويل إلى نسبة مئوية
    private func applyPercentage() {
        if let value = Double(displayValue) {
            displayValue = String(value / 100)
        }
    }
    
    // إضافة نقطة عشرية
    private func addDecimalPoint() {
        if !displayValue.contains(".") {
            displayValue += "."
        }
    }
    
    // تعيين العملية الحسابية
    private func setOperation(_ operation: String) {
        currentOperation = operation
        firstValue = Double(displayValue)
        isTypingNumber = false
    }
    
    // حساب النتيجة
    private func calculateResult() {
        if let operation = currentOperation, let firstValue = firstValue, let secondValue = Double(displayValue) {
            switch operation {
            case "÷":
                displayValue = secondValue == 0 ? "Error" : String(firstValue / secondValue)
            case "×":
                displayValue = String(firstValue * secondValue)
            case "-":
                displayValue = String(firstValue - secondValue)
            case "+":
                displayValue = String(firstValue + secondValue)
            default:
                break
            }
            currentOperation = nil
            self.firstValue = nil
        }
    }
    
    // إضافة رقم إلى العرض
    private func appendDigit(_ digit: String) {
        if isTypingNumber {
            displayValue += digit
        } else {
            displayValue = digit
            isTypingNumber = true
        }
    }
}
