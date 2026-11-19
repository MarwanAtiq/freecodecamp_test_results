#!/usr/bin/bash
PSQL="psql -X -U freecodecamp -d number_guess -A -t -c"
SECRET_NUMBER=$(( $RANDOM % 1000 +1 )) # 1 - 1000 range
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

  read USER_GUESS
  while [[ ! "$USER_GUESS" =~ ^[0-9]+$ ]]
  do
  echo -e "That is not an integer, guess again:\n"
  read USER_GUESS
  done

  echo "PASSED! >>> $USER_GUESS"
}
START_GAME "Guess the secret number between 1 and 1000:"
# You guessed it in <number_of_guesses> tries. The secret number was $SECRET_NUMBER. Nice job!