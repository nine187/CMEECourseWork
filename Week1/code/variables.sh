#!/bin/sh
# Author: Pasith Prayoonrat pp1922@ic.ac.uk
# Script: variables.sh
# Description: assign values to variables 

# Arguments: 2 (string value or integer value as variables)
# Date: Oct 2022
## Illustrates the use of variables 

# Special variables- how variables are assigned in the script

echo "This script was called with $# parameters"
echo "The script's name is $0"
echo "The arguments are $@"
echo "The first argument is $1"
echo "The second argument is $2"

# Assigned Variables; Explicit declaration:
MY_VAR='some string' 
echo 'the current value of the variable is:' $MY_VAR
echo
echo 'Please enter a new string'
read MY_VAR
echo
echo 'the current value of the variable is:' $MY_VAR
echo

## Assigned Variables; Reading (multiple values) from user input:
echo 'Enter two numbers separated by space(s)'
read a b
echo
echo 'you entered' $a 'and' $b '; Their sum is:'

## Assigned Variables; Command substitution
MY_SUM=$(expr $a + $b)
echo $MY_SUM