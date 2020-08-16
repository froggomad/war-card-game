//
//  ContentView.swift
//  War
//
//  Created by Kenny on 8/14/20.
//  Copyright © 2020 Hazy Studios. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    // MARK: - State Properties -
    @State private var randCard1: String = "card2"
    @State private var randCard2: String = "card2"
    @State private var playerScore: Int = 0
    @State private var cpuScore: Int = 0
    @State private var showCards = false
    @State private var player: AudioPlayer = AudioPlayer()

    func randomCard() -> (image: String, rank: Int) {
        let randomNumber = Int.random(in: String.CardRankToNum.allCases[0].rawValue...String.CardRankToNum.allCases.count)

        let card = String.CardRankToNum(rawValue: randomNumber) ?? String.CardRankToNum.two

        return (String.cardImage(card), randomNumber)
    }

    func haptic(_ feedbackPressure: UIImpactFeedbackGenerator.FeedbackStyle) -> UIImpactFeedbackGenerator {
        return UIImpactFeedbackGenerator(style: feedbackPressure)
    }


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
                    if !showCards {
                        Image(.image(.back))
                            .scaleEffect(1)
                            .animation(.easeInOut)
                        Image(.image(.back))
                            .scaleEffect(1)
                            .animation(.easeInOut)
                    } else {
                        Image(randCard1)
                            .scaleEffect(1.75)
                            .animation(.easeInOut)
                        Image(randCard2)
                            .scaleEffect(1.75)
                            .animation(.easeInOut)
                    }

                }
                // button
                Spacer()


                Button(action: {
                    withAnimation(.easeInOut(duration: 2)) {
                        self.showCards.toggle()

                        if self.showCards {
                            let playerCard = self.randomCard()

                            let cpuCard = self.randomCard()
                            
                            self.randCard1 = playerCard.image
                            self.randCard2 = cpuCard.image

                            //Scoring
                            if playerCard.rank > cpuCard.rank {
                                self.playerScore += 1
                                self.haptic(.light).impactOccurred()
                                self.player.playSound(sound: .coinWin)

                            } else if cpuCard.rank == playerCard.rank {
                                self.haptic(.heavy).impactOccurred()
                                self.player.playSound(sound: .battleSpeech)
                                self.player.playSound(sound: .fight)

                            } else {
                                self.haptic(.medium).impactOccurred()
                                self.cpuScore += 1
                                self.player.playSound(sound: .coinLoss)
                            }
                        }
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
                            .font(.headline)
                            .padding(.bottom, 20)
                        Text("\(self.playerScore)")
                            .font(.headline)
                    }
                    .padding(.leading, 20)
                    .foregroundColor(.white)
                    Spacer()
                    VStack {
                        Text("Opponent")
                            .bold()
                            .font(.headline)
                            .padding(.bottom, 20)
                        Text("\(self.cpuScore)")
                        .font(.headline)
                    }
                    .padding(.trailing, 20)
                    .foregroundColor(.white)

                }
                .padding(.bottom, 8)
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
