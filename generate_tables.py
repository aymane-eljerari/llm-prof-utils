import csv
import sys
import os

# Extract command-line arguments
quant = sys.argv[1]
split_mode = sys.argv[2]

# Read the llama-batched-bench output from stdin
output = sys.argv[3]

# Extract the table lines (lines between the '|' characters)
table_lines = [line for line in output.splitlines() if line.startswith('|') and not line.startswith('|---')]

# Split the lines into columns
rows = [[col.strip() for col in line.split('|') if col] for line in table_lines]

# Define the output directory and filename
output_directory = '../performance_results'
output_filename = f'{output_directory}/{quant}_{split_mode}.csv'

# Check if the directory exists, and create it if it doesn't
if not os.path.exists(output_directory):
    os.makedirs(output_directory)

# Write to the CSV file
with open(output_filename, 'w', newline='') as file:
    writer = csv.writer(file)
    writer.writerows(rows)

print(f"CSV file '{output_filename}' has been created.")
