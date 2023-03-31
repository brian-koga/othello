//
//  ViewController.swift
//
//
//  Created by Brian Koga on 3/26/21.
//

import UIKit

class ViewController: UIViewController, GameDelegate {
    @IBOutlet weak var blackScore: UILabel!
    @IBOutlet weak var whiteScore: UILabel!
    
    @IBOutlet weak var tapView: TapGridView!

    @IBOutlet weak var whiteTurn: UILabel!
    @IBOutlet weak var blackTurn: UILabel!
    
    @IBOutlet weak var gameOverMessage: UILabel!
    
    // delegate handler to update the scores
    func onChangeScore(bScore : Int, wScore : Int, turn : Int) {
        blackScore.text = String(bScore)
        whiteScore.text = String(wScore)
        // hide the arrow for who's turn it isn't
        if(turn == 1) {
            blackTurn.textColor = UIColor.black
            whiteTurn.textColor = UIColor.white
        } else {
            blackTurn.textColor = UIColor.white
            whiteTurn.textColor = UIColor.black
        }
    }
    
    func isGameOver() {
        let bScore = tapView.currentGame!.blackScore
        let wScore = tapView.currentGame!.whiteScore
        
        if bScore > wScore {
            gameOverMessage.text = "Black Wins!"
        }else if wScore > bScore {
            gameOverMessage.text = "White Wins!"
        } else {
            gameOverMessage.text = "It's a Tie!"
        }
        
        gameOverMessage.textColor = UIColor.black
    }
    
    @IBAction func newGame(_ sender: UIButton) {
        // reset game and call needs display
        tapView.currentGame = OthelloGame()
        tapView.setNeedsDisplay()
        // reset score values
        blackScore.text = "2"
        whiteScore.text = "2"
        // reset turn
        blackTurn.textColor = UIColor.black
        whiteTurn.textColor = UIColor.white
        
        gameOverMessage.textColor = UIColor.white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tapView.delegate = self
    }


}

