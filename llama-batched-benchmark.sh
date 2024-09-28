


# # #!/bin/bash

# # Check if the correct number of arguments is provided
# if [ $# -ne 2 ]; then
#   echo "Usage: $0 <quant> <split_mode>"
#   exit 1
# fi

# # Assign the arguments to variables
# quant=$1
# split_mode=$2

# # Validate quant and split_mode values
# valid_quants=("F32" "F16" "Q8_0" "Q5_1" "Q4_1")
# valid_split_modes=("none" "layer" "row")

# if [[ ! " ${valid_quants[@]} " =~ " ${quant} " ]]; then
#   echo "Error: Invalid quant value. Valid options are: ${valid_quants[@]}"
#   exit 1
# fi

# if [[ ! " ${valid_split_modes[@]} " =~ " ${split_mode} " ]]; then
#   echo "Error: Invalid split_mode value. Valid options are: ${valid_split_modes[@]}"
#   exit 1
# fi

# # Run the llama-batched-bench command with the specified quant and split_mode
# llama.cpp/llama-batched-bench -m llama.cpp/models/llama3/Meta-Llama-3-8B-Instruct-$quant.gguf -b 2048 -ub 512 -npp 256,512 -ntg 64 -npl 32,64 -ngl 50 -pps -sm $split_mode



# ------------------------------------------------------
# -----------   Automate Data Collection   -------------
# ------------------------------------------------------

#!/bin/bash

# Array of quant values
quants=("F16")

# Array of split modes
split_modes=("none")

# Iterate through each combination of quant and split mode
for quant in "${quants[@]}"; do
  for split_mode in "${split_modes[@]}"; do
    # Create a temporary file
    tmp_file=$(mktemp /tmp/llama-output-XXXX)

    # Run the llama-batched-bench command with the --log-file parameter and save the log to the temp file
    ../llama.cpp/llama-batched-bench \
      -m ../llama.cpp/models/llama3/Meta-Llama-3-8B-Instruct-"$quant".gguf \
      -c 2048 -b 2048 -ub 512 \
      -npp 4\
      -ntg 1\
      -npl 1\
      # -npp 32,64,128,256,512,1024,2048 \
      # -ntg 64,128,512,1024,2048 \
      # -npl 1,2,4,8,16,32,64,128,256 \
      -ngl 50 -pps -sm "$split_mode" \
      --log-file "$tmp_file"

    # Pass the content of the temporary file to the Python script
    python3 generate_tables.py "$quant" "$split_mode" "$(cat "$tmp_file")"

    # Delete the temporary file
    rm "$tmp_file"
  done
done

# ------------------------------------------------------



# llama.cpp/llama-batched-bench -m llama.cpp/models/llama3/Meta-Llama-3-8B-Instruct-$quant.gguf -b 2048 -ub 512 -npp 64,128,256,512 -ntg 64,128 -npl 8,16,32,64 -ngl 50 -pps -sm $split_mode