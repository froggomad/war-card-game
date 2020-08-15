# War Card Game
#### War Card Game in SwiftUI


## Extensions:

### String+Named.swift

contains image names stored in enums with methods to return them as a usable value

#### `enum CardRankToNum`
Summary: case names are friendly card names (two through Ace) | Rawvalue type Int | Conforms to CaseIterable

#### `enum CardImage`
Summary: game images are stored here

#### `static func image(CardImage)`
Summary: returns game image names

#### `static func cardImage(CardRankToNum)`
Summary: returns card image names

Usage: 
In `ContentView`:
  `randomCard()` uses a random number to get a random card and convert it to a card name. It returns the rawValue and cardName in a tuple
  in the `body`, the logo and background use the image function




