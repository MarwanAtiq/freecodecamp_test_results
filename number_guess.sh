#!/bin/bash
PSQL="psql -X -U freecodecamp -d number_guess -A -t -c"
SECRET_NUMBER=$(( $RANDOM % 1000 +1 )) # 1 - 1000 range
echo -e "Enter your username:\n"
read USER_NAME
USER_NAME_RESULT=$($PSQL "SELECT user_name FROM users WHERE user_name='$USER_NAME'")
if [[ -z "$USER_NAME_RESULT" ]]
then
echo -e "\nWelcome, $USER_NAME! It looks like this is your first time here."
USER_INSERT_RESULT=$($PSQL "INSERT INTO users(user_name) VALUES('$USER_NAME')")
USER_ID=$($PSQL "SELECT user_id FROM users WHERE user_name='$USER_NAME'")

else
USER_ID=$($PSQL "SELECT user_id FROM users WHERE user_name='$USER_NAME'")
GAMES_PLAYED=$($PSQL "SELECT COUNT(*) FROM games WHERE user_id=$USER_ID")
BEST_GAME=$($PSQL "SELECT MIN(number_of_guesses) FROM games WHERE user_id=$USER_ID")

echo -e "\nWelcome back, $USER_NAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
fi

START_GAME()
{
  GAME_INSERT_RESULT=$($PSQL "INSERT INTO games(user_id) VALUES('$USER_ID')")
  GAME_ID=$($PSQL "SELECT game_id FROM games WHERE user_id=$USER_ID AND number_of_guesses=0")

  if [[ -n $1 ]]
  then
  echo -e "\n$1\n" 
  fi

  GUESSES=0
  USER_GUESS=0
  
  while (( USER_GUESS != SECRET_NUMBER ))
  do

  read USER_GUESS

  if [[ ! "$USER_GUESS" =~ ^[0-9]+$ ]]
  then
  echo -e "That is not an integer, guess again:\n"

  elif (( USER_GUESS > SECRET_NUMBER ))
  then
  (( GUESSES++ ))
  echo -e "It's lower than that, guess again:\n"

  elif (( USER_GUESS < SECRET_NUMBER))
  then
  (( GUESSES++ ))
  echo -e "It's higher than that, guess again:\n"

  else
  (( GUESSES++ ))
  echo -e "You guessed it in $GUESSES tries. The secret number was $SECRET_NUMBER. Nice job!"
  INSERT_GUESS_RESULT=$($PSQL "UPDATE games SET number_of_guesses=$GUESSES WHERE user_id=$USER_ID AND number_of_guesses=0")
  fi
  done
}

START_GAME "Guess the secret number between 1 and 1000:"
