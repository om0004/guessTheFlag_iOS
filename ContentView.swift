//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by om on 28/03/21.
//

import SwiftUI
struct ContentView: View
{
    @State private var flags =  ["France","Estonia","Germany","Ireland","Italy","Monaco","Nigeria","Poland","Russia","Spain","UK","US"].shuffled()
    @State private var correctAnswer=Int.random(in:0...2)
    @State private var alertCheck=false
    @State private var alertTitle=""
    @State private var alertMessage=""
    @State private var score:Int=0
    @State private var rotationAmount:Double=0
    @State private var checkCorrect=false
    @State private var flagNumber=4
    @State private var checkOpacity=false
    @State private var wrongAnswer=4
    var body: some View
    {
        ZStack()
        {
            LinearGradient(gradient:Gradient(colors:[Color.blue,Color.black]), startPoint:.top, endPoint:.bottom)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing:30)
            {
                VStack()
                {
                    Text("Tap the flag!")
                        .foregroundColor(.white)
                    Text(flags[correctAnswer])
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                }
                ForEach(0..<3)
                {
                    number in
                    Button(action:{checkAnswer(number)})
                    {
                        Image(flags[number])
                            .renderingMode(.original)
                            .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/, radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                            .border(Color.black,width:4)
                            .rotation3DEffect(number==flagNumber ? .degrees(rotationAmount) :.zero,axis: (x: 0.0, y: 1.0, z: 1.0))
                           .opacity(checkOpacity && number != flagNumber ? 0.25 : 1)
                            .rotation3DEffect(number==wrongAnswer ? .degrees(30) :.zero,axis: (x: 0.0, y: 1.0, z: 1.0))
                            .background(number==wrongAnswer ? Color.red : Color.blue.opacity(0))
                    }
                }
            }
    }
        .font(.largeTitle)
        .alert(isPresented:$alertCheck,content:
            {
                Alert(title:Text("\(alertTitle)"), message:Text("Your score is \(score)"), dismissButton:.default(Text("ok"))
                {
                    newGame()
                })
            })
}
    func checkAnswer(_ number:Int)
    {
        if number == correctAnswer
        {
            withAnimation()
            {
            self.flagNumber=number
            checkOpacity=true
            self.checkCorrect=true
            self.rotationAmount+=360
            alertTitle="Correct"
            score+=1
            }
        }
        else
        {
            withAnimation()
            {
            wrongAnswer=number
            checkCorrect=false
            //rotationAmount=0
            alertTitle="Incorrect"
            }
        }
        alertCheck=true
    }
    func newGame()
    {
        flags.shuffle()
        correctAnswer=Int.random(in:0...2)
        self.rotationAmount=0
        checkCorrect=false
        flagNumber=4
        checkOpacity=false
        wrongAnswer=4
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

 
