//
//  ContentView.swift
//  Trivia
//
//  Created by Raymond Chen on 7/30/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var numberOfQuestions: String = "10"
        @State private var categoryOfQuestions: Int = 0
        @State private var difficultyOfQuestion: Int = 0
        @State private var typeOfQuestion: Int = 0

    let categories = ["General Knowledge", "Science", "Math", "History", "Geography", "Literature", "Sports", "Music", "Art", "Technology"]
        let difficulties = ["Easy", "Medium", "Hard"]
        let types = ["Multiple Choice", "True/False"]

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Number of Questions")) {
                    TextField("Enter number of questions", text: $numberOfQuestions)
                        .keyboardType(.numberPad)
                }
                
                Section(header: Text("Category")) {
                    Picker("Select Category", selection: $categoryOfQuestions) {
                        ForEach(0..<categories.count) { index in
                            Text(categories[index]).tag(index)
                        }
                    }
                    .pickerStyle(.menu)
                }
                
                Section(header: Text("Difficulty")) {
                    Picker("Select Difficulty", selection: $difficultyOfQuestion) {
                        ForEach(0..<difficulties.count) { index in
                            Text(difficulties[index]).tag(index)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Type")) {
                    Picker("Select Type", selection: $typeOfQuestion) {
                        ForEach(0..<types.count) { index in
                            Text(types[index]).tag(index)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section {
                    Button(action: startQuiz) {
                        Text("Start")
                            .frame(maxWidth: .infinity, alignment: .center)
                }
                                }
            }
            .padding()
            .navigationBarTitle("Quiz Settings")
        }
        
    }
    
    private func startQuiz() {
            // Action to start the quiz
            print("Quiz Started with \(numberOfQuestions) questions in category \(categories[categoryOfQuestions]), difficulty \(difficulties[difficultyOfQuestion]), and type \(types[typeOfQuestion]).")
        }
}

#Preview {
    ContentView()
}
