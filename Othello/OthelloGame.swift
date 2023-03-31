//
//  gameController.swift
//  Othello
//
//  Created by Brian Koga on 4/6/21.
//  Copyright © 2021 Cascade Labs. All rights reserved.
//

import Foundation

// Class that handles the actual Othello game
class OthelloGame {

    var board = [[0,0,0,0,0,0,0,0], [0,0,0,0,0,0,0,0], [0,0,0,0,0,0,0,0],                 [0,0,0,0,0,0,0,0], [0,0,0,0,0,0,0,0], [0,0,0,0,0,0,0,0], [0,0,0,0,0,0,0,0],
                  [0,0,0,0,0,0,0,0], [0,0,0,0,0,0,0,0]]
    var turn = 1
    var blackScore = 2
    var whiteScore = 2
    var validMoves : [(Int, Int)] = []

    // Initialization should fail if there is no name
    init?() {
        // set initial board
        board = [[0,0,0,0,0,0,0,0], [0,0,0,0,0,0,0,0], [0,0,0,0,0,0,0,0],                 [0,0,0,-1,1,0,0,0], [0,0,0,1,-1,0,0,0], [0,0,0,0,0,0,0,0], [0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0], [0,0,0,0,0,0,0,0]]
        turn = 1
        blackScore = 2
        whiteScore = 2
        // set initial valid moves
        validMoves = [(3,2), (2, 3), (4,5), (5,4)]
    }
    
    // counts and updates score
    func updateScore() {
        var bCount = 0
        var wCount = 0
        for i in 0...7 {
            for j in 0...7 {
                if (board[i][j] == 1) {
                    bCount += 1
                } else if (board[i][j] == -1) {
                    wCount += 1
                }
            }
        }
        blackScore = bCount
        whiteScore = wCount
    }
    
    // scans all squares and see what the valid moves are
    func getValidMoves() {
        validMoves = []
        let mover = turn
        let opponent : Int = -1*mover
        
        for i in 0...7 {
            for j in 0...7 {
                // check this square
                if board[i][j] != 0 {
                    continue
                }
                
                // check to the left
                var currCol = i-1
                var currRow = j
                
                if (currCol >= 0 && board[currCol][currRow] == opponent) {
                    while (currCol >= 0 && board[currCol][currRow] == opponent) {
                        // maybe change the tile
                        currCol -= 1
                    }
                    
                    // check if the square that ended on is own color
                    if (currCol >= 0 && board[currCol][currRow] == mover) {
                        validMoves.append((i, j))
                    }
                }
                
                
                // check to the right
                currCol = i+1
                if (currCol < 8 && board[currCol][currRow] == opponent) {
                    while (currCol < 8 && board[currCol][currRow] == opponent) {
                        // maybe change the tile
                        currCol += 1
                    }
                    
                    // check if the square that ended on is own color
                    if (currCol < 8 && board[currCol][currRow] == mover) {
                        validMoves.append((i, j))
                    }
                }
                
                
                
                //check to the top
                currCol = i
                currRow = j-1
                if (currRow >= 0 && board[currCol][currRow] == opponent) {
                    while (currRow >= 0 && board[currCol][currRow] == opponent) {
                        currRow -= 1
                    }
                    
                    // check if the square that ended on is own color
                    if (currRow >= 0 && board[currCol][currRow] == mover) {
                        validMoves.append((i, j))
                    }
                }
                
                
                
                // check to the bottom
                currRow = j+1
                if (currRow < 8 && board[currCol][currRow] == opponent) {
                    while (currRow < 8 && board[currCol][currRow] == opponent) {
                        currRow += 1
                    }
                    
                    // check if the square that ended on is own color
                    if (currRow < 8 && board[currCol][currRow] == mover) {
                        validMoves.append((i, j))
                    }
                }
                
                
                
                // check upper left
                currRow = j-1
                currCol = i-1
                if (currCol >= 0 && currRow >= 0 && board[currCol][currRow] == opponent) {
                    while (currCol >= 0 && currRow >= 0 && board[currCol][currRow] == opponent) {
                        currCol -= 1
                        currRow -= 1
                    }
                    
                    // check if the square that ended on is own color
                    if (currCol >= 0 && currRow >= 0 && board[currCol][currRow] == mover) {
                        validMoves.append((i, j))
                    }
                }
                
                
                
                // check upper right
                currRow = j-1
                currCol = i+1
                if (currCol < 8 && currRow >= 0 && board[currCol][currRow] == opponent) {
                    while (currCol < 8 && currRow >= 0 && board[currCol][currRow] == opponent) {
                        currCol += 1
                        currRow -= 1
                    }
                    
                    // check if the square that ended on is own color
                    if (currCol < 8 && currRow >= 0 && board[currCol][currRow] == mover) {
                        validMoves.append((i, j))
                    }
                }
                
                
                
                // check lower left
                currRow = j+1
                currCol = i-1
                if (currCol >= 0 && currRow < 8 && board[currCol][currRow] == opponent) {
                    while (currCol >= 0 && currRow < 8 && board[currCol][currRow] == opponent) {
                        currCol -= 1
                        currRow += 1
                    }
                    
                    // check if the square that ended on is own color
                    if (currCol >= 0 && currRow < 8 && board[currCol][currRow] == mover) {
                        validMoves.append((i, j))
                    }
                }
                
                
                
                // check lower left
                currRow = j+1
                currCol = i+1
                if (currCol < 8 && currRow < 8 && board[currCol][currRow] == opponent) {
                    while (currCol < 8 && currRow < 8 && board[currCol][currRow] == opponent) {
                        currCol += 1
                        currRow += 1
                    }
                    
                    // check if the square that ended on is own color
                    if (currCol < 8 && currRow < 8 && board[currCol][currRow] == mover) {
                        validMoves.append((i, j))
                    }
                }
                
            }
        }
        
    }
    
    // execute move and change all necessary tiles
    func move(col : Int, row : Int) -> (bScore : Int, wScore: Int) {
        let mover = turn
        let opponent : Int = -1*mover
        
        board[col][row] = mover
        
        var toChange : [(Int, Int)] = []
        var tempToChange : [(Int, Int)] = []
        
        // check to the left
        var currCol = col-1
        var currRow = row
        while (currCol >= 0 && board[currCol][currRow] == opponent) {
            // maybe change the tile
            tempToChange.append((currCol, currRow))
            currCol -= 1
        }
        
        // check if the square that ended on is own color
        if (currCol >= 0 && board[currCol][currRow] == mover) {
            toChange.append(contentsOf: tempToChange)
        }
        
        
        // check to the right
        tempToChange = []
        currCol = col+1
        while (currCol < 8 && board[currCol][currRow] == opponent) {
            // maybe change the tile
            tempToChange.append((currCol, currRow))
            currCol += 1
        }
        
        // check if the square that ended on is own color
        if (currCol < 8 && board[currCol][currRow] == mover) {
            toChange.append(contentsOf: tempToChange)
        }
        
        
        
        //check to the top
        tempToChange = []
        currCol = col
        currRow = row-1
        while (currRow >= 0 && board[currCol][currRow] == opponent) {
            // maybe change the tile
            tempToChange.append((currCol, currRow))
            currRow -= 1
        }
        
        // check if the square that ended on is own color
        if (currRow >= 0 && board[currCol][currRow] == mover) {
            toChange.append(contentsOf: tempToChange)
        }
        
        
        
        // check to the bottom
        tempToChange = []
        currRow = row+1
        while (currRow < 8 && board[currCol][currRow] == opponent) {
            // maybe change the tile
            tempToChange.append((currCol, currRow))
            currRow += 1
        }
        
        // check if the square that ended on is own color
        if (currRow < 8 && board[currCol][currRow] == mover) {
            toChange.append(contentsOf: tempToChange)
        }
        
        
        
        // check upper left
        tempToChange = []
        currRow = row-1
        currCol = col-1
        while (currCol >= 0 && currRow >= 0 && board[currCol][currRow] == opponent) {
            // maybe change the tile
            tempToChange.append((currCol, currRow))
            currCol -= 1
            currRow -= 1
        }
        
        // check if the square that ended on is own color
        if (currCol >= 0 && currRow >= 0 && board[currCol][currRow] == mover) {
            toChange.append(contentsOf: tempToChange)
        }
        
        
        
        // check upper right
        tempToChange = []
        currRow = row-1
        currCol = col+1
        
        while (currCol < 8 && currRow >= 0 && board[currCol][currRow] == opponent) {
            // maybe change the tile
            tempToChange.append((currCol, currRow))

            currCol += 1
            currRow -= 1
        }
        
        // check if the square that ended on is own color
        if (currCol < 8 && currRow >= 0 && board[currCol][currRow] == mover) {
            toChange.append(contentsOf: tempToChange)
        }
        
        
        
        // check lower left
        tempToChange = []
        currRow = row+1
        currCol = col-1
        
        while (currCol >= 0 && currRow < 8 && board[currCol][currRow] == opponent) {
            // maybe change the tile
            tempToChange.append((currCol, currRow))
            currCol -= 1
            currRow += 1
        }
        
        // check if the square that ended on is own color
        if (currCol >= 0 && currRow < 8 && board[currCol][currRow] == mover) {
            toChange.append(contentsOf: tempToChange)
        }
        
        
        
        // check lower left
        tempToChange = []
        currRow = row+1
        currCol = col+1
        
        while (currCol < 8 && currRow < 8 && board[currCol][currRow] == opponent) {
            // maybe change the tile
            tempToChange.append((currCol, currRow))
            currCol += 1
            currRow += 1
        }
        
        // check if the square that ended on is own color
        if (currCol < 8 && currRow < 8 && board[currCol][currRow] == mover) {
            toChange.append(contentsOf: tempToChange)
        }
        
        for elem in toChange {
            board[elem.0][elem.1] *= -1
        }
        
        //update score
        updateScore()
        
        //change player
        turn *= -1
        
        getValidMoves()
        
        return (blackScore, whiteScore)
        
    }
    
}
