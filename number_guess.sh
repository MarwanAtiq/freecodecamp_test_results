#!/usr/bin/bash
PSQL="psql -X -U freecodecamp -d number_guess -A -t -c"
SECRET_NUMBER=$(( $RANDOM % 1000 +1 )) # 1- 1000 range
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
  echo $1
  fi

  read USER_GUESS
  if [[ ! "$USER_GUESS" =~ ^[0-9]+$ ]]
  then
  START_GAME "That is not an integer, guess again:"
  else
  echo working
  fi
}
START_GAME "Guess the secret number between 1 and 1000:\n"
# You guessed it in <number_of_guesses> tries. The secret number was $SECRET_NUMBER. Nice job!