#Game functions ########################################################################################################
humanPlay <- function(board, symbol = playerSymbol){
  playPosition <- as.numeric(checkInput("It is your turn, where will you go: ",1:9))
  rowPos <- ceiling(playPosition/3)
  colPos <- ifelse(playPosition %% 3 == 0, 3, playPosition %% 3)
  print(rowPos)
  print(colPos)
  if(board[rowPos,colPos] != " "){
    print("That space is taken, please try again")
    return(humanPlay(board))
  } else {
    board[rowPos,colPos] <- symbol
    return(board)
  }
}

comPlay <- function(board, symbol = comSymbol){
  print("It is my turn")
  possiblePositions <- which(as.character(t(board))==" ")
  playPosition <- sample(possiblePositions, 1)
  rowPos <- ceiling(playPosition/3)
  colPos <- ifelse(playPosition %% 3 == 0, 3, playPosition %% 3)
  print(rowPos)
  print(colPos)
  board[rowPos,colPos] <- symbol
  return(board)
}

printBoard <- function(board){
  cat(paste(board[1,1], "|", board[1,2], "|", board[1,3],"\n"))
  cat(" --------- \n")
  cat(paste(board[2,1], "|", board[2,2], "|", board[2,3],"\n"))
  cat(" --------- \n")
  cat(paste(board[3,1], "|", board[3,2], "|", board[3,3],"\n"))
}

checkVictory <- function(board, symbol){
  victorySets <- rbind(c(1,2,3),c(4,5,6),c(7,8,9),
                       c(1,4,7),c(2,5,8),c(3,6,9),
                       c(1,5,9),c(3,5,7))
  vectorBoard <- as.character(t(currentBoard))
  spots <- which(vectorBoard == symbol)
  wins <- any(apply(victorySets,1,function(x) all(x %in% spots)))
  return(wins)
}

checkInput <- function(question,possibleInputs){
  input <- readline(prompt=question)
  while(!(input %in% possibleInputs)){
    print(paste("Bad input, your options include:",paste(possibleInputs,sep = ",")))
    input <- readline(prompt=question)
  }
  return(input)
}


#Introduction and Rules ##########################################################################################################
print("This is the game of tic-tac-toe")
print("The goal is to get three in a row")
print("Before I can do the same")
print("Let me get some information, such as your name")


#Get some inputs ##################################################################################################################
playerName <- readline(prompt="Enter name: ")
playerSymbol <- checkInput("What is your symbol: ",c("X","O"))
comSymbol <- ifelse(playerSymbol=="X","O","X")

#Determine Who goes first ###########################################################################################################
print("We will flip a coin to see who goes first")
print("You can call the toss")
callFlip <- checkInput("What is your called flip: ",c("H","T"))
actualFlip <- ifelse(rbinom(1,1,0.5)==1,"H","T")
print(paste("The coin was flipped",actualFlip))
if(actualFlip==callFlip){
  print("You won the toss, so go first")
  playFunc <- humanPlay
  namePlayFunc <- "human"
  currentSymbol <- playerSymbol
} else {
  print("I won the toss, wait while I go")
  playFunc <- comPlay
  namePlayFunc <- "com"
  currentSymbol <- comSymbol
}



#initialize board #############################################################################################33
currentBoard <- matrix(rep(" ",9), nrow=3)
modelBoard <- t(matrix(1:9, nrow=3))
print("Throughout the game you will select the place you want to go based on these numbers")
printBoard(modelBoard)


#Loop through play ###############################################################################################

checkWin <- FALSE
while(checkWin == FALSE & checkTie == FALSE){
  currentBoard <- playFunc(currentBoard)
  print("This is where you went")
  printBoard(currentBoard)
  checkWin <- checkVictory(currentBoard,currentSymbol)
  playFunc <- ifelse(namePlayFunc=="human",comPlay,humanPlay)
  namePlayFunc <- ifelse(namePlayFunc=="human","com","human")
  currentSymbol <- ifelse(currentSymbol=="X","O","X")
  checkTie <- ifelse(all(currentBoard!=" "),break,"NULL")
}

if(checkWin){
  if(namePlayFunc == "com"){
    print("Congratulations, you won!")
  } else {
    print("I'm sorry but you lose")
  }
} else {
  print("We tied!")
}

