import numpy as np
from scipy import stats

import sys

predicted_scores_f = sys.argv[1]
reference_scores_f = sys.argv[2]

## Read, convert to float and then convert the scores to numpy arrays

computed_scores = []
reference_scores = []

with open(predicted_scores_f, 'r') as f:
    computed_scores = f.readlines()
    computed_scores = [line.strip() for line in computed_scores]
    computed_scores = [float(line) for line in computed_scores]

with open(reference_scores_f, 'r') as f:
    reference_scores = f.readlines()
    reference_scores = [line.strip() for line in reference_scores]
    reference_scores = [float(line) for line in reference_scores]

computed_scores = np.array(computed_scores).astype(float)
reference_scores = np.array(reference_scores).astype(float)

## Get the distribution of scores in the range of 0-1 with 0.1 intervals

computed_score_distribution = np.histogram(computed_scores, bins=np.arange(0, 1.1, 0.1))
reference_score_distribution = np.histogram(reference_scores, bins=np.arange(0, 1.1, 0.1))

pearson = stats.pearsonr(computed_scores, reference_scores)
kendall = stats.kendalltau(computed_scores, reference_scores)

# print('Pearson correlation coefficient: ', pearson[0])
# print('Pearson p-value: ', pearson[1])
# print('Kendall tau: ', kendall[0])
# print('Kendall p-value: ', kendall[1])

## Print all 4 scores with a comma separator

print(pearson[0], pearson[1], kendall[0], kendall[1], sep=',')