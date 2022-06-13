//
//  ContentView.swift
//  SwiftUICustomTextField
//
//  Created by Amir Hatami on 2022-06-05.
//

import SwiftUI

struct ContentView: View {
    @State var firstName : String = ""
    @State var lastName : String = ""
    @State var age : String = ""
    @State var job : String = ""
    @FocusState private var focusedField: Fields?
    
    var body: some View {
        VStack {
            CustomTextField(
                id: "firstName",
                label: "First Name",
                value: $firstName,
                textColor : Color.yellow,
                width: 300,
                height: 60,
                focusedField: $focusedField,
                thisField: .firstName,
                characterLimit: 30,
                keyboardType: .asciiCapable)
            CustomTextField(
                id: "lastName",
                label: "Last Name",
                value: $lastName,
                textColor : Color.yellow,
                width: 300,
                height: 60,
                focusedField: $focusedField,
                thisField: .lastName,
                characterLimit: 30,
                keyboardType: .asciiCapable)
            CustomTextField(
                id: "age",
                label: "Age",
                value: $age,
                textColor : Color.white,
                width: 300,
                height: 60,
                focusedField: $focusedField,
                thisField: .age,
                characterLimit: 30,
                keyboardType: .numberPad)
            CustomTextField(
                id: "job",
                label: "Job",
                value: $job,
                width: 300,
                height: 60,
                focusedField: $focusedField,
                thisField: .job,
                characterLimit: 30,
                keyboardType: .asciiCapable)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
