//
//  ContentView.swift
//  War
//
//  Created by Kenny on 8/14/20.
//  Copyright © 2020 Hazy Studios. All rights reserved.
//

import SwiftUI

enum CardChoice: Int {
    case card1 = 1
    case card2
}

func randomCard() -> (image: String, rank: Int) {
    let randomNumber = Int.random(in: String.CardRankToNum.allCases[0].rawValue...String.CardRankToNum.allCases.count)

    let card = String.CardRankToNum(rawValue: randomNumber) ?? String.CardRankToNum.two

    return (String.cardImage(card), randomNumber)
}

struct ContentView: View {
    @State private var randCard1: String = "card2"
    @State private var randCard2: String = "card2"
    @State private var playerScore: Int = 0
    @State private var cpuScore: Int = 0


    var body: some View {

        ZStack {
            // MARK: - Background Image -
            Image(.image(.background))
                .resizable()
                .edgesIgnoringSafeArea(.all)

            VStack {
                // logo
                Spacer()
                Image(.image(.logo))
                Spacer()
                // card stack
                HStack {
                    
                    Image(randCard1)
                    Image(randCard2)
                }
                // button
                Spacer()


                Button(action: {
                    let playerCard = randomCard()
                    print("player rank: \(playerCard.rank)")
                    let cpuCard = randomCard()
                    print("CPU rank: \(cpuCard.rank)")
                    self.randCard1 = playerCard.image
                    self.randCard2 = cpuCard.image

                    if playerCard.rank > cpuCard.rank {
                        self.playerScore += 1
                    } else if cpuCard.rank == playerCard.rank {
                        print("war!")
                    } else {
                        self.cpuScore += 1
                    }

                }) {
                    Image(.image(.dealButton))
                        .renderingMode(.original)
                }

                Spacer()
                // scores
                HStack {
                    VStack {
                        Text("Player")
                            .bold()
                            .padding(.bottom, 20)
                        Text("\(self.playerScore)")
                    }
                    .padding(.leading, 20)
                    .foregroundColor(.white)
                    Spacer()
                    VStack {
                        Text("CPU")
                            .bold()
                            .padding(.bottom, 20)
                        Text("\(self.cpuScore)")
                    }
                    .padding(.trailing, 20)
                    .foregroundColor(.white)

                }
                .padding(.bottom, 20)
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

