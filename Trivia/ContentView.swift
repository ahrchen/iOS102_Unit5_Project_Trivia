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
    
    @State private var categories: [Category] = []
    
    let difficulties = ["Easy", "Medium", "Hard"]
    let difficultiesAPI = ["easy", "medium", "hard"]
    
    let types = ["Multiple Choice", "True/False"]
    let typesAPI = ["multiple", "boolean"]
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Number of Questions")) {
                    TextField("Enter number of questions", text: $numberOfQuestions)
                        .keyboardType(.numberPad)
                }
                
                Section(header: Text("Category")) {
                    Picker("Select Category", selection: $categoryOfQuestions) {
                        ForEach(0..<categories.count, id: \.self) { index in
                            Text(categories[index].name).tag(index)
                        }
                    }
                    .pickerStyle(.menu)
                }
                
                Section(header: Text("Difficulty")) {
                    Picker("Select Difficulty", selection: $difficultyOfQuestion) {
                        ForEach(0..<difficulties.count, id: \.self) { index in
                            Text(difficulties[index]).tag(index)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Type")) {
                    Picker("Select Type", selection: $typeOfQuestion) {
                        ForEach(0..<types.count, id: \.self) { index in
                            Text(types[index]).tag(index)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section {
                    Button {
                        Task {
                            await startQuiz()
                        }
                    } label: {
                        Text("Start")
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                }
            }
            .padding()
            .navigationBarTitle("Quiz Settings")
        }
        .onAppear {
            Task {
                await fetchCategories()
            }
        }
    }
    
    private func fetchCategories() async {
        let url = URL(string: "https://opentdb.com/api_category.php")!
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let categoriesResponse = try JSONDecoder().decode(TriviaCategoriesResponse.self, from: data)
            
            let categories = categoriesResponse.triviaCategories
            
            self.categories = categories
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func startQuiz() async {
        // Action to start the quiz
        let url = URL(string:"https://opentdb.com/api.php?amount=\(numberOfQuestions)&category=\(categories[categoryOfQuestions].id)&difficulty=\(difficultiesAPI[difficultyOfQuestion])&type=\(typesAPI[typeOfQuestion])")!
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let triviaResponse = try JSONDecoder().decode(TriviaResponse.self, from: data)
            
            let triviaResults = triviaResponse.results
            if triviaResponse.responseCode == 0 {
                print(triviaResults)
            } else {
                print("Trivia Response \(triviaResponse.responseCode)")
            }
        } catch {
            print(error.localizedDescription)

        }
    }
}

#Preview {
    ContentView()
}
