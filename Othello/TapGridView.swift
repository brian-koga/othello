//
//  TapGridView.swift
//  Othello
//
//  Created by Brian Koga on 3/28/21.
//  Copyright © 2021 Cascade Labs. All rights reserved.
//

import UIKit

protocol GameDelegate {
    func onChangeScore(bScore : Int, wScore: Int, turn: Int)
    func isGameOver()
}

@IBDesignable

class TapGridView: UIView {

    
    var delegate:GameDelegate?
    
    var currentGame = OthelloGame()
    
    var side : CGFloat = 0.0
    var smallSide : CGFloat = 0.0
    var width : CGFloat = 0.0
    var height: CGFloat = 0.0
    var widthOffset : CGFloat = 0.0
    var heightOffset : CGFloat = 0.0
    var buffer : CGFloat = 10.0
    
    var numOfSquares = 8
    
    func isValidMove(c : Int, r : Int) -> Bool {
        var isValid = false
        for elem in currentGame!.validMoves {
            if(elem.0 == c && elem.1 == r) {
                isValid = true
                break
            }
        }
        return isValid
    }

    override func draw(_ rect: CGRect) {
        
        width = bounds.width
        height = bounds.height
        
        
        
        side = CGFloat(min(height, width))
        
        // get offset in order to center the grid
        if (side == width) {
            heightOffset = ((height - side)/2)
            widthOffset = 0
        } else {
            widthOffset = ((width - side)/2)
            heightOffset = 0
        }
        
        // add a buffer to the offsets so that the grid is not clipped
        heightOffset += buffer
        widthOffset += buffer
        
        //adjust side to account for buffer
        side -= (2*buffer)
        
        // calculate tthe size of the small squares in the grid
        smallSide = side/CGFloat(numOfSquares)
        
        let largeBox = UIBezierPath(rect: CGRect(x: widthOffset, y: heightOffset, width: side, height: side))
        UIColor.green.setFill()
        largeBox.fill()
        
        // draw the rectangles
        for i in 0...(numOfSquares-1) {
            for j in 0...(numOfSquares-1) {
                var smallLeft : CGFloat = widthOffset + (CGFloat(i)*smallSide)
                var smallTop : CGFloat = heightOffset + (CGFloat(j)*smallSide)
                
                
                let smallBox = UIBezierPath(rect: CGRect(x: smallLeft, y: smallTop, width: smallSide, height: smallSide))
                
                UIColor.black.setStroke()
                smallBox.stroke()
                
                
            
                // draw the circles
                if(currentGame!.board[i][j] != 0) {
                    smallLeft = smallLeft + 0.1*smallSide
                    smallTop = smallTop + 0.1*smallSide
                    
                    // draw the circle
                    let rect = CGRect(x: smallLeft, y: smallTop, width: smallSide*0.8, height: smallSide*0.8)
                    let circle = UIBezierPath(ovalIn: rect)
                    if(currentGame!.board[i][j] == 1) {
                        UIColor.black.setFill()
                    } else {
                        // white
                        UIColor.white.setFill()
                    }
                    
                    circle.fill()
                }
                
                
                // draw the possible move circles
                let isValid = isValidMove(c: i, r: j)
                if(isValid) {
                    smallLeft = smallLeft + 0.25*smallSide
                    smallTop = smallTop + 0.25*smallSide
                    
                    // draw the circle
                    let rect = CGRect(x: smallLeft, y: smallTop, width: smallSide*0.5, height: smallSide*0.5)
                    let circle = UIBezierPath(ovalIn: rect)
                    UIColor.lightGray.setFill()
                    
                    circle.fill()
                }
            }
        }
        
        // check if game is over and send game over message
        if(currentGame!.validMoves.isEmpty) {
            delegate?.isGameOver()
        }
        
    }
    
    
    
    
    
    /*
     * You can create this method using the control-drag trick from the
     * tap recognizer. If you notice that it's claiming to hook up "Exit":
     *      1) That's ok, finish the drag
     *      2) You'll need to fix the tap recognizer in Interface Builder
     *          a) Right/ctrl-click it and remove the sent action to Exit
     *          b) Grab the circle next to this function and drag onto the recognizer
     */
    @IBAction func handleTap(_ sender: UITapGestureRecognizer) {
        
        /*
         * Tap recognizers only respond to taps within the bounds of the view
         * you dropped them on. This method gives you a tap location in the
         * coordinate system of a particular view
         *
         * Note that if your recognizer is paired with the view that processes
         * it, you'll probably want 'self'
         */
        let tapPoint = sender.location(in: self)
 
        
        if (tapPoint.x > widthOffset && tapPoint.x < (CGFloat(width) - widthOffset) && tapPoint.y > heightOffset && tapPoint.y < (CGFloat(height) - heightOffset)) {
            let adjustedX = tapPoint.x - widthOffset
            let adjustedY = tapPoint.y - heightOffset
            let col = Int(floor(adjustedX/smallSide))
            let row = Int(floor(adjustedY/smallSide))
            
            //check if valid move
            let isValid = isValidMove(c: col, r: row)

            if(isValid) {
                // execute move
                let res = (currentGame?.move(col: col, row: row))!
                
                
                // call delegate so that the scores are updated
                delegate?.onChangeScore(bScore: res.0, wScore: res.1, turn: currentGame!.turn)
                
                
                // this tells iOS it needs to update (redraw) the screen
                setNeedsDisplay()
            }
            
        }
        
    }
    
}
