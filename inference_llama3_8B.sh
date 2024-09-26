#!/bin/bash

# Check if the correct number of arguments is provided
if [ $# -ne 2 ]; then
  echo "Usage: $0 <quant> <split>"
  exit 1
fi

# Assign the first argument to the quant variable
quant=$1
sm=$2

user_prompt="Explain how antibiotics have evolved over the course of history as well as how they function to alter our bodies to make us safer. Be specific with the details, and explain using scientific terminology. \n"
num_tokens=64
context=2048


./llama.cpp/llama-cli -m llama.cpp/models/llama3/Meta-Llama-3-8B-Instruct-$quant.gguf -ngl 50 -n $num_tokens -c $context --prompt "$user_prompt" -sm $sm

