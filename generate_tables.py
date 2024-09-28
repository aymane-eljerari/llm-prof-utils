import csv
import sys

# Extract command-line arguments
quant = sys.argv[1]
split_mode = sys.argv[2]

# Read the llama-batched-bench output from stdin
output = sys.argv[3]

# Extract the table lines (lines between the '|' characters)
table_lines = [line for line in output.splitlines() if line.startswith('|') and not line.startswith('|---')]

# Split the lines into columns
rows = [[col.strip() for col in line.split('|') if col] for line in table_lines]

# Write to a CSV file
output_filename = f'performance_results/{quant}_{split_mode}.csv'
with open(output_filename, 'w', newline='') as file:
    writer = csv.writer(file)
    writer.writerows(rows)

print(f"CSV file '{output_filename}' has been created.")
