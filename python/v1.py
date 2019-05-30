import math
import random

#Very initial ###########################################################

def checkInput(question, possibleInputs):
    readInput = input(question)
    while readInput not in possibleInputs:
        print("bad input, your options include ",' '.join(possibleInputs))
        readInput = input(question)
    return(readInput)

currentBoard = [[" "," "," "] for i in range(3)]

#Introduction and Rules ###################################################
print("This is the game of tic-tac-toe")
print("The goal is to get three in a row")
print("Before I can do the same")
print("Let me get some information, such as your name")

#Get some inputs ##########################################################
playerName = input("Enter name: ")
playerSymbol = checkInput("What is your symbol: ", ["X","O"])
comSymbol = "O" if playerSymbol=="X" else "X"

#Functions ################################################################
  
def humanPlay(board, symbol = playerSymbol):
    print("start human play")
    playPosition = int(checkInput("It is your turn, where will you go: ", [str(i+1) for i in range(9)] ))
    print(playPosition)
    rowPos = math.ceil(playPosition/3) - 1
    print(rowPos)
    colPos = (playPosition % 3)-1 if (playPosition % 3)-1 != -1 else 2
    print(colPos)
    if board[rowPos][colPos] != " ":
        return(humanPlay(board))
    else:
        board[rowPos][colPos] = symbol
        return(board)


def comPlay(board, symbol = comSymbol):
    print("It is my turn")
    flatBoard = [item for sublist in board for item in sublist]
    possiblePositions = [i for i,x in enumerate(flatBoard) if x == " "]
    playPosition = random.choice(possiblePositions) + 1
    rowPos = math.ceil(playPosition/3) - 1
    colPos = (playPosition % 3)-1 if (playPosition % 3)-1 != -1 else 2
    board[rowPos][colPos] = symbol
    return(board)
    

def printBoard(board):
    print(board[0][0], "|", board[0][1], "|", board[0][2])
    print("----------")
    print(board[1][0], "|", board[1][1], "|", board[1][2])
    print("----------")
    print(board[2][0], "|", board[2][1], "|", board[2][2])
    

def checkVictory(board, symbol):
    victorySets = [[0,1,2],[3,4,5], [6,7,8], [0,3,6],
                    [1,4,7],[2,5,8],[0,4,8],[2,4,6]]
    vectorBoard = [item for sublist in board for item in sublist]
    takenPositions = [i for i,x in enumerate(vectorBoard) if x == symbol]
    print(takenPositions)
    wins = False
    for singleVictory in victorySets:
        if len([i for i in takenPositions if i in singleVictory]) == 3:
            wins = True
    return(wins)
    


#Determine Who goes first #################################################
print("We will flip a coin to see who goes first")
print("You can call the toss")
callFlip = checkInput("What is your called flip: ", ["H","T"])
actualFlip = "H" if bool(random.getrandbits(1)) else "T"
print("The actual coin flip was " + actualFlip)
if actualFlip == callFlip:
    print("You won the toss so go first")
    playFunc = humanPlay
    namePlayFunc = "human"
    currentSymbol = playerSymbol
else:
    print("I won the toss, wait while I go first")
    playFunc = comPlay
    namePlayFunc = "com"
    currentSymbol = comSymbol

#initialize board #########################################################
currentBoard = [[" " for i in range(3)] for j in range(3)]
modelBoard = [[j+i for j in range(3)] for i in range(1,9,3)]
print("Throughout the game you will select the place you want to go based on these numbers")
printBoard(modelBoard)

#Loop through play #########################################################
checkWin = False
checkTie = False
while checkWin == False and checkTie == False:
    currentBoard = playFunc(currentBoard)
    print("This is where the last person went")
    print(currentSymbol)
    printBoard(currentBoard)
    checkWin = checkVictory(currentBoard, currentSymbol)
    print(checkWin)
    playFunc = comPlay if namePlayFunc=="human" else humanPlay
    namePlayFunc = "com" if namePlayFunc=="human" else "human"
    currentSymbol = "X" if currentSymbol=="O" else "O"
    checkTie = " " not in [item for sublist in currentBoard for item in sublist]
    

if checkWin:
    if(namePlayFunc == "com"):
        print("Congratulations, you won!")
    else:
        print("I'm sorry, but you lost")
else:
    print("We tied!")

