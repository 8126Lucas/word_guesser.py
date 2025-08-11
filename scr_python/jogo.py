from wonderwords import RandomWord
import os

r = RandomWord()

def clear_screen(): os.system("clear||cls")

def game_header(word, lives):
    print(f"It's a {len(word)} letter word. Therefore you have {lives} lives.")


def process_output(word, points, lives):
    for i, char in enumerate(word):
        if(points[i] == True):
            print(f"{char} ", end="")
        else:
            print("_ ", end="")
    print(f"\t Lives: {lives}/{len(word)}")


def process_input(lives, points, word):
    found = False
    letter = input("» ")
    for i, char in enumerate(word):
        if(letter == char):
            points[i] = True
            found = True
    if(not found):
        lives -= 1
    if(lives == 0):
        print(f"GAME OVER! GOODBYE! BTW the word was \"{word}\"")
        exit()
    else:
        process_output(word, points, lives)
    return lives
    

if __name__ == "__main__":
    clear_screen()
    word = r.word(word_min_length=3, word_max_length=12)
    points = [False]*len(word)
    lives = len(word)
    win = False
    game_header(word, lives)
    while(win == False and lives != 0):
        lives = process_input(lives, points, word)
        if points == [True]*len(word):
            win = True
