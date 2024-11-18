import SwiftUI

struct CalculatorView: View {
    @ObservedObject var calculator = CalculatorModel()
    
    let buttons: [[String]] = [
        ["AC", "+/-", "%", "÷"],
        ["7", "8", "9", "×"],
        ["4", "5", "6", "-"],
        ["1", "2", "3", "+"],
        ["0", ".", "="]
    ]
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            Text(calculator.displayValue)
                .font(.system(size: 80, weight: .light))
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding()
                .background(Color.black.opacity(0.8))
                .foregroundColor(.white)
                .cornerRadius(20)
                .shadow(color: .gray.opacity(0.4), radius: 10, x: 0, y: 5)
                .padding(.horizontal, 20)
            
            ForEach(buttons, id: \.self) { row in
                HStack(spacing: 20) {
                    ForEach(row, id: \.self) { button in
                        Button(action: {
                            calculator.didTap(button: button)
                        }) {
                            Text(button)
                                .font(.system(size: 36, weight: .medium))
                                .frame(width: buttonWidth(button: button), height: buttonHeight())
                                .foregroundColor(.white)
                                .background(getButtonBackground(button: button))
                                .cornerRadius(buttonHeight() / 3)
                                .shadow(color: .gray.opacity(0.4), radius: 5, x: 0, y: 5)
                        }
                    }
                }
                .padding(.horizontal, 20)
            }
        }
        .padding(.bottom, 20)
        .background(Color(.systemGray6).edgesIgnoringSafeArea(.all))
    }
    
    func buttonWidth(button: String) -> CGFloat {
        return button == "0" ? (UIScreen.main.bounds.width - 4 * 20) / 2 : (UIScreen.main.bounds.width - 6 * 20) / 4
    }
    
    func buttonHeight() -> CGFloat {
        return (UIScreen.main.bounds.width - 6 * 20) / 4
    }
    
    func getButtonBackground(button: String) -> LinearGradient {
        if ["÷", "×", "-", "+", "="].contains(button) {
            return LinearGradient(gradient: Gradient(colors: [Color.orange, Color.red]), startPoint: .topLeading, endPoint: .bottomTrailing)
        } else if ["AC", "+/-", "%"].contains(button) {
            return LinearGradient(gradient: Gradient(colors: [Color.gray.opacity(0.8), Color.gray]), startPoint: .topLeading, endPoint: .bottomTrailing)
        }
        return LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.8), Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
}

#Preview {
    CalculatorView()
}
