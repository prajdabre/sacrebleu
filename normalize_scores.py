import sys

infile = sys.argv[1]
outfile = sys.argv[1] + '.normalized'
normalization_factor = float(sys.argv[2])

with open(infile, 'r') as f:
    data = f.readlines()

with open(outfile, 'w') as f:
    for line in data:
        f.write(str(float(line.strip()) / normalization_factor) + '\n')

print('File written successfully')
