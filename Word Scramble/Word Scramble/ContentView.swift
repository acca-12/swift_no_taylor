//
//  ContentView.swift
//  Word Scramble
//
//  Created by Alfonso Acosta on 2024-09-20.
//

import SwiftUI

struct ContentView: View {

    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    @State private var playerScore = 0


    
    func startGame(){
        if let fileURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: fileURL, encoding: .utf8) {
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "silkworm"
                playerScore = 0
                usedWords = [String]()
                return
            }
        }
        //unwrapping optionals
        fatalError("Could not load start.txt from bundle.") //causes app to die
    }
    
    func trivial(_ word: String) -> Bool{
        return !(word == rootWord || word.count < 3)
    }
    
    func exists(_ word: String) -> Bool {
        return !usedWords.contains(word)
    }
    
    func isPossible(_ word: String) -> Bool {
        var tempWord = rootWord
        for letter in word{
            if let pos = tempWord.firstIndex(of: letter){
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        return true
    }
    
    func isReal(_ word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    func wordError(title: String, message: String){
        errorTitle = title
        errorMessage = message
        showingError = true
    }
    
    func addPlayerScore(_ answer: String) {
        playerScore += answer.count
    }
    
    
    func addNewWord(){
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard answer.count > 0 else { return }
        
        guard trivial(answer) else {
            wordError(title: "Trivial", message: "Word is too trvial. avoid root and words with length less than 3")
            return
        }
        
        guard exists(answer) else {
            wordError(title: "Word used already", message: "Be more original")
            return
        }
        
        guard isPossible(answer) else {
            wordError(title: "Word not possible", message: "Can't spell this word from \(rootWord) !")
            return
        }
        
        guard isReal(answer) else {
            wordError(title: "Word not recognized", message: "Does not exist")
            return
        }
        
        addPlayerScore(answer)
        
        withAnimation{
            usedWords.insert(answer, at: 0)
        }
        newWord = ""
    }
    var body: some View {
        NavigationStack{
            
            VStack{
                List{
                    Section{
                        TextField("Enter your word", text: $newWord)
                            .textInputAutocapitalization(.never)
                    }
                    
                    
                    Section {
                        ForEach(usedWords, id: \.self){ word in
                            HStack{
                                Image(systemName: "\(word.count).circle")
                                Text(word)
                            }
                        }
                    }
                }
                Spacer()
                Spacer()
                Spacer()
                Text("\(playerScore)")
            }
            .navigationTitle(rootWord)
            .onSubmit(addNewWord) //onSubmit requires a function no params and returns nothing
            .onAppear(perform: startGame)
            .toolbar{
                Button("New root", action: startGame)
            }
            .alert(errorTitle, isPresented: $showingError){
                Button("OK") {}
            } message: {
                Text(errorMessage)
            }
            
        }
            
    }
}

#Preview {
    ContentView()
}
