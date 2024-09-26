
# consider passing other flags as well.

# Check if the correct number of arguments is provided
if [ $# -ne 6 ]; then
  echo "Usage: $0 <quant> <split mode> <pp size> <tg size> <batch size> <micro batch size>"
  exit 1
fi

quant=$1
split_mode=$2

# DEFAULT: pp=512, tg=128, batch=1024, micro_batch=256
pp=$3
tg=$4
batch=$5
micro_batch=$6


omnitrace-sample -c /root/.omnitrace.cfg -TP --output omnitrace_output/${quant}_${split_mode} --profile-format text -- \
  ./llama.cpp/llama-bench -m llama.cpp/models/llama3/Meta-Llama-3-8B-Instruct-$quant.gguf -sm $split_mode -ngl 50 -pg $pp,$tg -b $batch -ub $micro_batch 

# ./llama.cpp/llama-cli -m llama.cpp/models/llama3/Meta-Llama-3-8B-Instruct-F16.gguf -ngl 50 -n $num_tokens -c $context --prompt "$user_prompt" -sm $sm