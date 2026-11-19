#!/usr/bin/bash
PSQL="psql -X -U freecodecamp -d number_guess -A -t -c"
SECRET_NUMBER=$(( $RANDOM % 5 +1 )) # 1 - 1000 range
echo -e "Enter your username:\n"
read USER_NAME
USER_NAME_RESULT=$($PSQL "SELECT user_name FROM users WHERE user_name='$USER_NAME'")
if [[ -z "$USER_NAME_RESULT" ]]
then
echo -e "Welcome, $USER_NAME! It looks like this is your first time here.\n"
$PSQL "INSERT INTO users(user_name) VALUES('$USER_NAME')"
USER_ID=$($PSQL "SELECT user_id FROM users WHERE user_name='$USER_NAME'")

else
USER_ID=$($PSQL "SELECT user_id FROM users WHERE user_name='$USER_NAME'")
echo -e "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
fi

START_GAME()
{
  if [[ -n $1 ]]
  then
  echo -e "\n$1\n" 
  fi

  GUESSES=0
  
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
  echo -e "You guessed it in "$GUESSES" tries. The secret number was $SECRET_NUMBER. Nice job!"

  fi
  done
}

START_GAME "Guess the secret number between 1 and 1000:"
