//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by om on 31/01/21.
//

import SwiftUI

struct ContentView: View
{
    @State private var Countries=["Estonia","France","Germany","Ireland","Italy","Monaco","Nigeria","Poland","Russia","Spain","UK","US"].shuffled()
    @State private var correctAnswer=Int.random(in:0...2)
    @State private var showingScore=false
    @State private var scoreTitle=""
    @State private var Score:Int=0
    var body: some View
    {
        ZStack()
        {
            LinearGradient(gradient:Gradient(colors: [.blue,.black]), startPoint:.top, endPoint:.bottom).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack(spacing:30)
            {
                VStack()
                {
                Text("Tap the flag!").foregroundColor(.white)
                Text(Countries[correctAnswer])
                //.foregroundColor(.white)
                    .font(.largeTitle)
                    .fontWeight(.black)
                }
                ForEach(0..<3)
                {
                    number in
                    Button(action:{flagTapped(number)})
                    {
                        Image(Countries[number])
                        .renderingMode(.original)
                        .clipShape(Capsule())
                        .overlay(Capsule().stroke(Color.black,lineWidth:1))
                        .shadow(color:/*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/,radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    }
                    .alert(isPresented:$showingScore)
                    {
                        Alert(title:Text(scoreTitle), message:Text("Your score is:\(Score)"),dismissButton:.default(Text("ok"))
                                {
                                   askQuestion()
                                })
                    }
                }
            }
        }
    }
    func flagTapped(_ number:Int)
    {
        if number==correctAnswer
        {
            scoreTitle="Correct"
            Score+=1
        }
        else
        {
            scoreTitle="Wrong"
        }
        showingScore=true
    }
    func askQuestion()
    {
        Countries.shuffle()
        correctAnswer=Int.random(in:0...2)
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
