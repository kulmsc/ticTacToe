
function checkInput(question, possibleInputs)
    print("question")
    readInput = readline(stdin)



    def checkInput(question, possibleInputs):
        readInput = input(question)
        while readInput not in possibleInputs:
            print("bad input, your options include ",' '.join(possibleInputs))
            readInput = input(question)
        return(readInput)

    currentBoard = [[" "," "," "] for i in range(3)]
