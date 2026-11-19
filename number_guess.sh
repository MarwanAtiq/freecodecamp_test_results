#!/usr/bin/bash
PSQL="psql -X -U freecodecamp -d guessing_game -A -t -c"
SECRET_NUMBER=$(( $RANDOM % 1000 +1 )) # 1- 1000 range
echo -e "Enter your username:\n"
read USERNAME
USERNAME_RESULT=$($PSQL "SELECT user_name FROM users WHERE user_name='$USERNAME'")
if [[ -z "$USERNAME_RESULT" ]]
then
echo -e "Welcome, $USERNAME! It looks like this is your first time here.\n"
else
echo -e "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $LOWEST_TRIES guesses."
fi
# You guessed it in <number_of_guesses> tries. The secret number was $SECRET_NUMBER. Nice job!