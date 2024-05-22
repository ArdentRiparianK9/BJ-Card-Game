//
//  ViewController.swift
//  BJ Card Game
//
//  Created by Kayla A. Yang  on 17/1/2024.
//

import UIKit

class ViewController: UIViewController {
    
    var myDeck: [Card] = Deck.createDeck()
    
    var dealerCount = 0
    var playersHand: [Int] = []
    var dealersHand: [Int] = []
    var playerCount = 0
    var turn = true
    var disable = false
    
    
    @IBOutlet weak var imgCardL: UIImageView!
    @IBOutlet weak var imgCardR: UIImageView!
    
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblDealerValue: UILabel!
    @IBOutlet weak var lblPlayerValue: UILabel!
    
    @IBOutlet weak var bttnDraw: UIButton!
    @IBOutlet weak var bttnHit: UIButton!
    @IBOutlet weak var bttnStay: UIButton!
    
    @IBOutlet weak var bttnReset: UIButton!
    
    @IBAction func bttnDraw(_ sender: UIButton) {
        func randomCard(deck: [Card]) -> Card {
            let randomIndex = Int.random(in: 0..<deck.count)
            return deck[randomIndex]
        }
        
        let randomCardL = randomCard(deck: myDeck)
        let randomCardR = randomCard(deck: myDeck)
        imgCardL.image = UIImage(named: randomCardL.image)
        imgCardR.image = UIImage(named: randomCardR.image)
        
        createCard()
        
        bttnDraw.isHidden = true
        bttnDraw.isEnabled = false
        // Note remeber to remove any connections after copying buttons
        bttnHit.isHidden = false
        bttnHit.isExclusiveTouch = true
        bttnStay.isHidden = false
        bttnStay.isExclusiveTouch = true
        
        bttnReset.isExclusiveTouch = true
        
    }
    
    
    @IBAction func bttnHit(_ sender: UIButton) {
        print("Player Hit")
        turn = false
        createCard()
    }
    @IBAction func bttnStay(_ sender: UIButton) {
        print("Player Stay")
        turn = true
        createCard()
    }
    
    
    @IBAction func bttnReset(_ sender: UIButton) {
        disable = false // Enable card creation
        cardView.removeFromSuperview()

        dealerCount = 0
        playerCount = 0
        turn = true
        playersHand = []
        dealersHand = []

        imgCardL.image = UIImage(named: "card_back")
        imgCardR.image = UIImage(named: "card_back")

        lblStatus.text = "..."
        lblDealerValue.text = "..."
        lblPlayerValue.text = "..."

        bttnDraw.isHidden = false
        bttnDraw.isEnabled = true
        bttnHit.isHidden = true
        bttnStay.isHidden = true
        for subview in view.subviews {
            if let imageView = subview as? UIImageView {
                imageView.isUserInteractionEnabled = true
            }
        }
        
    }
    
    // Generates a random card
    func randomCard(deck: [String]) -> String{
        
        let maxRange = deck.count - 1
        let randomNum = Int.random (in: 0...maxRange)
        
        return deck[randomNum]
    }
    
    let cardView = UIImageView()

    func createCard() {
        if turn == true && dealerCount < 5 && disable == false && shouldDealCard() {
            cardView.frame = CGRect(x: 50 + (dealerCount * 50), y: 100, width: 83, height: 111)
            let card = myDeck.removeLast()
            cardView.image = UIImage(named: card.image)

            dealersHand.append(card.value)
            print(dealersHand, "Dealer")
            let totalD = dealersHand.reduce(0, +)
            lblStatus.text = checkWinner(handValue: totalD, player: "Dealer")
            lblDealerValue.text = String(totalD)

            dealerCount += 1
            turn = false
            cardView.removeFromSuperview()
        } else if turn == false && playerCount < 5 && disable == false && shouldDealCard() {
            cardView.frame = CGRect(x: 50 + (dealerCount * 50), y: 100, width: 83, height: 111)
            let card = myDeck.removeLast()
            cardView.image = UIImage(named: card.image)

            playersHand.append(card.value)
            print(playersHand, "Player")
            let total = playersHand.reduce(0, +)
            lblStatus.text = checkWinner(handValue: total, player: "Player")
            lblPlayerValue.text = String(total)

            playerCount += 1
            turn = true
            cardView.removeFromSuperview()
        } else if disable == true && turn == true {
            cardView.image = nil
            cardView.removeFromSuperview()
            print("No more cards being dealt")
        }
        view.addSubview(cardView)
    }

    func shouldDealCard() -> Bool {
        let playerTotal = playersHand.reduce(0, +)
        let dealerTotal = dealersHand.reduce(0, +)
        return playerTotal <= 21 && dealerTotal <= 21
    }
    
    
    func checkWinner(handValue: Int, player: String) -> String {
        switch handValue {
        case 22..<35:
            if player == "Player" {
                return "Dealer Wins"
            } else {
                return "Player Wins"
            }
        case 21:
            if player == "Player" {
                return "Player Wins"
            } else {
                return "Dealer Wins"
            }
        case 20:
            if player == "Player" {
                return "Do you trust the luck?"
            } else {
                return "Lucky?"
            }
        default:
            return "Hit or Stay?"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
