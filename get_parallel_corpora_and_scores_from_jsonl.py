import json
import sys

## We need to extract content corresponding to the keys 'src', 'ref', 'translation', 'mqm_norm_score', and 'da_norm_score'
## We need to write each of these contents in separate files with the appropriate extensions

infile = sys.argv[1]
outfile_src = sys.argv[1].replace('.jsonl', '.src')
outfile_ref = sys.argv[1].replace('.jsonl', '.ref')
outfile_translation = sys.argv[1].replace('.jsonl', '.translation')
outfile_mqm_norm_score = sys.argv[1].replace('.jsonl', '.mqm_norm_score')
outfile_da_norm_score = sys.argv[1].replace('.jsonl', '.da_norm_score')

with open(infile, 'r') as f:
    data = f.readlines()

with open(outfile_src, 'w') as f:
    for line in data:
        f.write(json.loads(line)['src'] + '\n')

with open(outfile_ref, 'w') as f:
    for line in data:
        f.write(json.loads(line)['ref'] + '\n')

with open(outfile_translation, 'w') as f:
    for line in data:
        f.write(json.loads(line)['translation'] + '\n')

with open(outfile_mqm_norm_score, 'w') as f:
    for line in data:
        f.write(str(json.loads(line)['mqm_norm_score']) + '\n')

with open(outfile_da_norm_score, 'w') as f:
    for line in data:
        f.write(str(json.loads(line)['da_norm_score']) + '\n')

print('Files written successfully')
