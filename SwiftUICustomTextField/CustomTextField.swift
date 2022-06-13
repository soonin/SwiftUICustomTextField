//
//  CustomTextField.swift
//  SwiftUICustomTextField
//
//  Created by Amir Hatami on 2022-06-12.
//

import SwiftUI

struct CustomTextField: View {
    let id : String
    let label : String
    let value : Binding<String>
    let text : String
    let textFont : Font
    let textColor : Color
    let bgColor : Color
    let underlineColor : Color
    let width : CGFloat
    let height : CGFloat
    var focusedField : FocusState<Fields?>.Binding
    let thisField : Fields
    let characterLimit : Int
    let keyboardType : UIKeyboardType
    
    init(
        id : String,
        label : String = "",
        value : Binding<String>,
        text : String = "",
        textFont : Font = .system(size: 20.0),
        textColor : Color = Color.black,
        bgColor : Color = Color.blue,
        underlineColor : Color = Color.yellow,
        width : CGFloat = 400,
        height : CGFloat = 60,
        focusedField : FocusState<Fields?>.Binding,
        thisField : Fields = .firstName,
        characterLimit : Int = 10,
        keyboardType : UIKeyboardType = .asciiCapable
    ) {
        self.id = id
        self.label = label
        self.value = value
        self.text = text
        self.textFont = textFont
        self.textColor = textColor
        self.bgColor = bgColor
        self.underlineColor = underlineColor
        self.width = width
        self.height = height
        self.focusedField = focusedField
        self.thisField = thisField
        self.characterLimit = characterLimit
        self.keyboardType = keyboardType
    }
    
    
    var body: some View {
        VStack(spacing : 5){
            Text(label)
                .font(textFont)
                .foregroundColor(textColor)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 12)
            TextField("", text: value)
                .focused(focusedField, equals: thisField)
                .keyboardType(keyboardType)
                .onReceive(value.wrappedValue.publisher.collect()) {
                    let str = String($0.prefix(characterLimit))
                    if value.wrappedValue != str {
                        value.wrappedValue = str
                    }
                }
                .onSubmit {
                    focusNextField()
                }
                .submitLabel(.next)
                .border(.clear)
                .font(textFont)
                .textInputAutocapitalization(.characters)
                .disableAutocorrection(true)
                .textCase(.uppercase)
                .keyboardType(keyboardType)
                .ignoresSafeArea(.keyboard)
                .padding(.leading, 12)
                .padding(.trailing, 12)
            Rectangle()
                .frame(height: 1)
                .foregroundColor(underlineColor)
                .frame(maxWidth: .infinity)
        }
        .padding(.top, 6)
        .frame(width: width, height: height, alignment: .leading)
        .background(bgColor)
    }
}




enum Fields : Int, CaseIterable {
    case firstName
    case lastName
    case age
    case job
}


extension CustomTextField {
    private func focusPreviousField() {
        focusedField.wrappedValue = focusedField.wrappedValue.map{
            Fields(rawValue: $0.rawValue - 1) ?? .job
        }
    }
    private func focusNextField() {
        focusedField.wrappedValue = focusedField.wrappedValue.map{
            Fields(rawValue: $0.rawValue + 1) ?? .firstName
        }
    }
    
    private func canFocusPreviousField() -> Bool {
        guard let currentFocusedField = focusedField.wrappedValue else {
            return false
        }
        return currentFocusedField.rawValue > 0
    }
    private func canFocusNextField() -> Bool {
        guard let CurrentFocusedField = focusedField.wrappedValue else {
            return false
        }
        return CurrentFocusedField.rawValue < Fields.allCases.count - 1
    }
}

