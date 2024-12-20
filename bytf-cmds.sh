python get_parallel_corpora_and_scores_from_jsonl.py IndicMT-Eval/Dataset/Indic\ MT\ Eval/Hin_test.jsonl

cat IndicMT-Eval/Dataset/Indic\ MT\ Eval/Hin_test.translation | sacrebleu IndicMT-Eval/Dataset/Indic\ MT\ Eval/Hin_test.ref -m chrf --sentence-level | rev | cut -d " " -f1 | rev > IndicMT-Eval/Dataset/Indic\ MT\ Eval/Hin_test.chrf

cat IndicMT-Eval/Dataset/Indic\ MT\ Eval/Hin_test.translation | sacrebleu IndicMT-Eval/Dataset/Indic\ MT\ Eval/Hin_test.ref -m bytf --sentence-level | rev | cut -d " " -f1 | rev > IndicMT-Eval/Dataset/Indic\ MT\ Eval/Hin_test.bytf

cat IndicMT-Eval/Dataset/Indic\ MT\ Eval/Hin_test.translation | sacrebleu IndicMT-Eval/Dataset/Indic\ MT\ Eval/Hin_test.ref -m chrf --chrf-char-order 6 --chrf-word-order 2  --sentence-level | rev | cut -d " " -f1 | rev > IndicMT-Eval/Dataset/Indic\ MT\ Eval/Hin_test.chrf.char_order_6_word_order_2

cat IndicMT-Eval/Dataset/Indic\ MT\ Eval/Hin_test.translation | sacrebleu IndicMT-Eval/Dataset/Indic\ MT\ Eval/Hin_test.ref -m bytf --bytf-byte-order 10 --chrf-char-order 6 --chrf-word-order 2 --sentence-level | rev | cut -d " " -f1 | rev > IndicMT-Eval/Dataset/Indic\ MT\ Eval/Hin_test.bytf.byte_order_10_char_order_6_word_order_2

python normalize_scores.py IndicMT-Eval/Dataset/Indic\ MT\ Eval/Hin_test.chrf 100
python normalize_scores.py IndicMT-Eval/Dataset/Indic\ MT\ Eval/Hin_test.bytf 100

python normalize_scores.py IndicMT-Eval/Dataset/Indic\ MT\ Eval/Hin_test.chrf.char_order_6_word_order_2 100
python normalize_scores.py IndicMT-Eval/Dataset/Indic\ MT\ Eval/Hin_test.bytf.byte_order_10_char_order_6_word_order_2 100

python compute_correlation_metrics.py IndicMT-Eval/Dataset/Indic\ MT\ Eval/Hin_test.chrf.normalized IndicMT-Eval/Dataset/Indic\ MT\ Eval/Hin_test.da_norm_score

python compute_correlation_metrics.py IndicMT-Eval/Dataset/Indic\ MT\ Eval/Hin_test.bytf.normalized IndicMT-Eval/Dataset/Indic\ MT\ Eval/Hin_test.da_norm_score

python compute_correlation_metrics.py IndicMT-Eval/Dataset/Indic\ MT\ Eval/Hin_test.chrf.normalized IndicMT-Eval/Dataset/Indic\ MT\ Eval/Hin_test.mqm_norm_score

python compute_correlation_metrics.py IndicMT-Eval/Dataset/Indic\ MT\ Eval/Hin_test.bytf.normalized IndicMT-Eval/Dataset/Indic\ MT\ Eval/Hin_test.mqm_norm_score

## Now all 4 commands for the scores with chrf and bytf with different parameters are ready to be run.

python compute_correlation_metrics.py IndicMT-Eval/Dataset/Indic\ MT\ Eval/Hin_test.chrf.char_order_6_word_order_2.normalized IndicMT-Eval/Dataset/Indic\ MT\ Eval/Hin_test.da_norm_score

python compute_correlation_metrics.py IndicMT-Eval/Dataset/Indic\ MT\ Eval/Hin_test.bytf.byte_order_10_char_order_6_word_order_2.normalized IndicMT-Eval/Dataset/Indic\ MT\ Eval/Hin_test.da_norm_score

python compute_correlation_metrics.py IndicMT-Eval/Dataset/Indic\ MT\ Eval/Hin_test.chrf.char_order_6_word_order_2.normalized IndicMT-Eval/Dataset/Indic\ MT\ Eval/Hin_test.mqm_norm_score

python compute_correlation_metrics.py IndicMT-Eval/Dataset/Indic\ MT\ Eval/Hin_test.bytf.byte_order_10_char_order_6_word_order_2.normalized IndicMT-Eval/Dataset/Indic\ MT\ Eval/Hin_test.mqm_norm_score

## Now lets go cray cray and run it on all the languages

for byte_order in 10 13 16 20 
do
for char_order in 6 9 12 15
do
for word_order in 2 5 8 11
do
## Ensure that byte_order is greater than char_order and char_order is greater than word_order. If not then skip the iteration.

if [ $byte_order -gt $char_order ] && [ $char_order -gt $word_order ]
then
for lang in Hin Guj Mal Tam Mar
do
python get_parallel_corpora_and_scores_from_jsonl.py IndicMT-Eval/Dataset/Indic\ MT\ Eval/"$lang"_test.jsonl
cat IndicMT-Eval/Dataset/Indic\ MT\ Eval/"$lang"_test.translation | sacrebleu IndicMT-Eval/Dataset/Indic\ MT\ Eval/"$lang"_test.ref -m chrf --chrf-char-order $char_order --chrf-word-order $word_order  --sentence-level | rev | cut -d " " -f1 | rev > IndicMT-Eval/Dataset/Indic\ MT\ Eval/"$lang"_test.chrf.char_order_"$char_order"_word_order_"$word_order"

cat IndicMT-Eval/Dataset/Indic\ MT\ Eval/"$lang"_test.translation | sacrebleu IndicMT-Eval/Dataset/Indic\ MT\ Eval/"$lang"_test.ref -m bytf --bytf-byte-order $byte_order --bytf-char-order $char_order --bytf-word-order $word_order --sentence-level | rev | cut -d " " -f1 | rev > IndicMT-Eval/Dataset/Indic\ MT\ Eval/"$lang"_test.bytf.byte_order_"$byte_order"_char_order_"$char_order"_word_order_"$word_order"

python normalize_scores.py IndicMT-Eval/Dataset/Indic\ MT\ Eval/"$lang"_test.chrf.char_order_"$char_order"_word_order_"$word_order" 100
python normalize_scores.py IndicMT-Eval/Dataset/Indic\ MT\ Eval/"$lang"_test.bytf.byte_order_"$byte_order"_char_order_"$char_order"_word_order_"$word_order" 100

chrfscores=`python compute_correlation_metrics.py IndicMT-Eval/Dataset/Indic\ MT\ Eval/"$lang"_test.chrf.char_order_"$char_order"_word_order_"$word_order".normalized IndicMT-Eval/Dataset/Indic\ MT\ Eval/"$lang"_test.da_norm_score`

bytfscores=`python compute_correlation_metrics.py IndicMT-Eval/Dataset/Indic\ MT\ Eval/"$lang"_test.bytf.byte_order_"$byte_order"_char_order_"$char_order"_word_order_"$word_order".normalized IndicMT-Eval/Dataset/Indic\ MT\ Eval/"$lang"_test.da_norm_score`

## Split by comma. There are 4 scores. Pearson score, Pearson p-value, Kendall score, Kendall p-value.

chrf_pearson=`echo $chrfscores | cut -d "," -f1`
chrf_kendall=`echo $chrfscores | cut -d "," -f3`
chrf_pearson_pvalue=`echo $chrfscores | cut -d "," -f2`
chrf_kendall_pvalue=`echo $chrfscores | cut -d "," -f4`

bytf_pearson=`echo $bytfscores | cut -d "," -f1`
bytf_kendall=`echo $bytfscores | cut -d "," -f3`
bytf_pearson_pvalue=`echo $bytfscores | cut -d "," -f2`
bytf_kendall_pvalue=`echo $bytfscores | cut -d "," -f4`

echo "$lang, $byte_order, $char_order, $word_order, $chrf_pearson, $bytf_pearson, $chrf_kendall, $bytf_kendall, $chrf_pearson_pvalue, $bytf_pearson_pvalue, $chrf_kendall_pvalue, $bytf_kendall_pvalue" >> IndicMT-Eval/Dataset/Indic\ MT\ Eval/Correlation_Scores.csv
done
fi
done
done
done