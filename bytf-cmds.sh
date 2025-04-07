# python get_parallel_corpora_and_scores_from_jsonl.py IndicMT-Eval/Dataset/Indic\ MT\ Eval/Hin_test.jsonl

# cat IndicMT-Eval/Dataset/Indic\ MT\ Eval/Hin_test.translation | sacrebleu IndicMT-Eval/Dataset/Indic\ MT\ Eval/Hin_test.ref -m chrf --sentence-level | rev | cut -d " " -f1 | rev > IndicMT-Eval/Dataset/Indic\ MT\ Eval/Hin_test.chrf

# cat IndicMT-Eval/Dataset/Indic\ MT\ Eval/Hin_test.translation | sacrebleu IndicMT-Eval/Dataset/Indic\ MT\ Eval/Hin_test.ref -m bytf --sentence-level | rev | cut -d " " -f1 | rev > IndicMT-Eval/Dataset/Indic\ MT\ Eval/Hin_test.bytf

# cat IndicMT-Eval/Dataset/Indic\ MT\ Eval/Hin_test.translation | sacrebleu IndicMT-Eval/Dataset/Indic\ MT\ Eval/Hin_test.ref -m chrf --chrf-char-order 6 --chrf-word-order 2  --sentence-level | rev | cut -d " " -f1 | rev > IndicMT-Eval/Dataset/Indic\ MT\ Eval/Hin_test.chrf.char_order_6_word_order_2

# cat IndicMT-Eval/Dataset/Indic\ MT\ Eval/Hin_test.translation | sacrebleu IndicMT-Eval/Dataset/Indic\ MT\ Eval/Hin_test.ref -m bytf --bytf-byte-order 10 --chrf-char-order 6 --chrf-word-order 2 --sentence-level | rev | cut -d " " -f1 | rev > IndicMT-Eval/Dataset/Indic\ MT\ Eval/Hin_test.bytf.byte_order_10_char_order_6_word_order_2

# python normalize_scores.py IndicMT-Eval/Dataset/Indic\ MT\ Eval/Hin_test.chrf 100
# python normalize_scores.py IndicMT-Eval/Dataset/Indic\ MT\ Eval/Hin_test.bytf 100

# python normalize_scores.py IndicMT-Eval/Dataset/Indic\ MT\ Eval/Hin_test.chrf.char_order_6_word_order_2 100
# python normalize_scores.py IndicMT-Eval/Dataset/Indic\ MT\ Eval/Hin_test.bytf.byte_order_10_char_order_6_word_order_2 100

# python compute_correlation_metrics.py IndicMT-Eval/Dataset/Indic\ MT\ Eval/Hin_test.chrf.normalized IndicMT-Eval/Dataset/Indic\ MT\ Eval/Hin_test.da_norm_score

# python compute_correlation_metrics.py IndicMT-Eval/Dataset/Indic\ MT\ Eval/Hin_test.bytf.normalized IndicMT-Eval/Dataset/Indic\ MT\ Eval/Hin_test.da_norm_score

# python compute_correlation_metrics.py IndicMT-Eval/Dataset/Indic\ MT\ Eval/Hin_test.chrf.normalized IndicMT-Eval/Dataset/Indic\ MT\ Eval/Hin_test.mqm_norm_score

# python compute_correlation_metrics.py IndicMT-Eval/Dataset/Indic\ MT\ Eval/Hin_test.bytf.normalized IndicMT-Eval/Dataset/Indic\ MT\ Eval/Hin_test.mqm_norm_score

# ## Now all 4 commands for the scores with chrf and bytf with different parameters are ready to be run.

# python compute_correlation_metrics.py IndicMT-Eval/Dataset/Indic\ MT\ Eval/Hin_test.chrf.char_order_6_word_order_2.normalized IndicMT-Eval/Dataset/Indic\ MT\ Eval/Hin_test.da_norm_score

# python compute_correlation_metrics.py IndicMT-Eval/Dataset/Indic\ MT\ Eval/Hin_test.bytf.byte_order_10_char_order_6_word_order_2.normalized IndicMT-Eval/Dataset/Indic\ MT\ Eval/Hin_test.da_norm_score

# python compute_correlation_metrics.py IndicMT-Eval/Dataset/Indic\ MT\ Eval/Hin_test.chrf.char_order_6_word_order_2.normalized IndicMT-Eval/Dataset/Indic\ MT\ Eval/Hin_test.mqm_norm_score

# python compute_correlation_metrics.py IndicMT-Eval/Dataset/Indic\ MT\ Eval/Hin_test.bytf.byte_order_10_char_order_6_word_order_2.normalized IndicMT-Eval/Dataset/Indic\ MT\ Eval/Hin_test.mqm_norm_score

## Now lets go cray cray and run it on all the languages

## First extract the parallel corpora and scores for all languages

# for lang in Hin Guj Mal Tam Mar
# do
# for split in train val test
# do
# python get_parallel_corpora_and_scores_from_jsonl.py IndicMT-Eval/Dataset/Indic\ MT\ Eval/"$lang"_"$split".jsonl
# done
# done
# ## First write header to csv file

## Cat the train val test to a single file

for lang in Hin Guj Mal Tam Mar
do
cat IndicMT-Eval/Dataset/Indic\ MT\ Eval/"$lang"_train.jsonl > IndicMT-Eval/Dataset/Indic\ MT\ Eval/"$lang"_all.jsonl
cat IndicMT-Eval/Dataset/Indic\ MT\ Eval/"$lang"_val.jsonl >> IndicMT-Eval/Dataset/Indic\ MT\ Eval/"$lang"_all.jsonl
cat IndicMT-Eval/Dataset/Indic\ MT\ Eval/"$lang"_test.jsonl >> IndicMT-Eval/Dataset/Indic\ MT\ Eval/"$lang"_all.jsonl
done

# Now extract the parallel corpora and scores for all languages

for lang in Hin Guj Mal Tam Mar
do
python get_parallel_corpora_and_scores_from_jsonl.py IndicMT-Eval/Dataset/Indic\ MT\ Eval/"$lang"_all.jsonl
done

# rm IndicMT-Eval/Dataset/Indic\ MT\ Eval/Correlation_Scores_DA.csv
# rm IndicMT-Eval/Dataset/Indic\ MT\ Eval/Correlation_Scores_MQM.csv

# echo "Language, Split, Byte Order, Char Order, Word Order, CHRF Pearson, BYTF Pearson, CHRF Kendall, BYTF Kendall, CHRF Pearson P-value, BYTF Pearson P-value, CHRF Kendall P-value, BYTF Kendall P-value" > IndicMT-Eval/Dataset/Indic\ MT\ Eval/Correlation_Scores_DA.csv

# ## Also for MQM

# echo "Language, Split, Byte Order, Char Order, Word Order, CHRF Pearson, BYTF Pearson, CHRF Kendall, BYTF Kendall, CHRF Pearson P-value, BYTF Pearson P-value, CHRF Kendall P-value, BYTF Kendall P-value" > IndicMT-Eval/Dataset/Indic\ MT\ Eval/Correlation_Scores_MQM.csv

# for lang in Hin Guj Mal Tam Mar
# do
# for split in train val test
# do
# for byte_order in 2 6 10 13 16 20
# do
# for char_order in 0 2 4 6 9 12
# do
# for word_order in 0 2 4
# do
# ## Ensure that byte_order is greater than or equal to char_order and char_order is greater or equal to word_order. If not then skip the iteration.
# if [ $byte_order -ge $char_order ] && [ $char_order -ge $word_order ]
# then
# echo "Running for $split, $lang, $byte_order, $char_order, $word_order"
# ## For chrf the char_order cant be 0. So only run for char_order > 0
# if [ $char_order -gt 0 ]
# then
# cat IndicMT-Eval/Dataset/Indic\ MT\ Eval/"$lang"_"$split".translation | sacrebleu IndicMT-Eval/Dataset/Indic\ MT\ Eval/"$lang"_"$split".ref -m chrf --chrf-char-order $char_order --chrf-word-order $word_order  --sentence-level | rev | cut -d " " -f1 | rev > IndicMT-Eval/Dataset/Indic\ MT\ Eval/"$lang"_"$split".chrf.char_order_"$char_order"_word_order_"$word_order"
# fi

# cat IndicMT-Eval/Dataset/Indic\ MT\ Eval/"$lang"_"$split".translation | sacrebleu IndicMT-Eval/Dataset/Indic\ MT\ Eval/"$lang"_"$split".ref -m bytf --bytf-byte-order $byte_order --bytf-char-order $char_order --bytf-word-order $word_order --sentence-level | rev | cut -d " " -f1 | rev > IndicMT-Eval/Dataset/Indic\ MT\ Eval/"$lang"_"$split".bytf.byte_order_"$byte_order"_char_order_"$char_order"_word_order_"$word_order"

# if [ $char_order -gt 0 ]
# then
# python normalize_scores.py IndicMT-Eval/Dataset/Indic\ MT\ Eval/"$lang"_"$split".chrf.char_order_"$char_order"_word_order_"$word_order" 100
# fi
# python normalize_scores.py IndicMT-Eval/Dataset/Indic\ MT\ Eval/"$lang"_"$split".bytf.byte_order_"$byte_order"_char_order_"$char_order"_word_order_"$word_order" 100

# if [ $char_order -gt 0 ]
# then
# chrfscores=`python compute_correlation_metrics.py IndicMT-Eval/Dataset/Indic\ MT\ Eval/"$lang"_"$split".chrf.char_order_"$char_order"_word_order_"$word_order".normalized IndicMT-Eval/Dataset/Indic\ MT\ Eval/"$lang"_"$split".da_norm_score`

# chrfscores_mqm=`python compute_correlation_metrics.py IndicMT-Eval/Dataset/Indic\ MT\ Eval/"$lang"_"$split".chrf.char_order_"$char_order"_word_order_"$word_order".normalized IndicMT-Eval/Dataset/Indic\ MT\ Eval/"$lang"_"$split".mqm_norm_score`
# fi

# bytfscores=`python compute_correlation_metrics.py IndicMT-Eval/Dataset/Indic\ MT\ Eval/"$lang"_"$split".bytf.byte_order_"$byte_order"_char_order_"$char_order"_word_order_"$word_order".normalized IndicMT-Eval/Dataset/Indic\ MT\ Eval/"$lang"_"$split".da_norm_score`

# bytfscores_mqm=`python compute_correlation_metrics.py IndicMT-Eval/Dataset/Indic\ MT\ Eval/"$lang"_"$split".bytf.byte_order_"$byte_order"_char_order_"$char_order"_word_order_"$word_order".normalized IndicMT-Eval/Dataset/Indic\ MT\ Eval/"$lang"_"$split".mqm_norm_score`

# ## Split by comma. There are 4 scores. Pearson score, Pearson p-value, Kendall score, Kendall p-value.

# if [ $char_order -gt 0 ]
# then
# chrf_pearson=`echo $chrfscores | cut -d "," -f1`
# chrf_kendall=`echo $chrfscores | cut -d "," -f3`
# chrf_pearson_pvalue=`echo $chrfscores | cut -d "," -f2`
# chrf_kendall_pvalue=`echo $chrfscores | cut -d "," -f4`
# else
# chrf_pearson="NA"
# chrf_kendall="NA"
# chrf_pearson_pvalue="NA"
# chrf_kendall_pvalue="NA"
# fi
# bytf_pearson=`echo $bytfscores | cut -d "," -f1`
# bytf_kendall=`echo $bytfscores | cut -d "," -f3`
# bytf_pearson_pvalue=`echo $bytfscores | cut -d "," -f2`
# bytf_kendall_pvalue=`echo $bytfscores | cut -d "," -f4`

# ## Similarly for MQM

# if [ $char_order -gt 0 ]
# then
# chrf_pearson_mqm=`echo $chrfscores_mqm | cut -d "," -f1`
# chrf_kendall_mqm=`echo $chrfscores_mqm | cut -d "," -f3`
# chrf_pearson_pvalue_mqm=`echo $chrfscores_mqm | cut -d "," -f2`
# chrf_kendall_pvalue_mqm=`echo $chrfscores_mqm | cut -d "," -f4`
# else
# chrf_pearson_mqm="NA"
# chrf_kendall_mqm="NA"
# chrf_pearson_pvalue_mqm="NA"
# chrf_kendall_pvalue_mqm="NA"
# fi

# bytf_pearson_mqm=`echo $bytfscores_mqm | cut -d "," -f1`
# bytf_kendall_mqm=`echo $bytfscores_mqm | cut -d "," -f3`
# bytf_pearson_pvalue_mqm=`echo $bytfscores_mqm | cut -d "," -f2`
# bytf_kendall_pvalue_mqm=`echo $bytfscores_mqm | cut -d "," -f4`

# echo "$lang, $split, $byte_order, $char_order, $word_order, $chrf_pearson, $bytf_pearson, $chrf_kendall, $bytf_kendall, $chrf_pearson_pvalue, $bytf_pearson_pvalue, $chrf_kendall_pvalue, $bytf_kendall_pvalue" >> IndicMT-Eval/Dataset/Indic\ MT\ Eval/Correlation_Scores_DA.csv

# echo "$lang, $split, $byte_order, $char_order, $word_order, $chrf_pearson_mqm, $bytf_pearson_mqm, $chrf_kendall_mqm, $bytf_kendall_mqm, $chrf_pearson_pvalue_mqm, $bytf_pearson_pvalue_mqm, $chrf_kendall_pvalue_mqm, $bytf_kendall_pvalue_mqm" >> IndicMT-Eval/Dataset/Indic\ MT\ Eval/Correlation_Scores_MQM.csv

# fi
# done
# done
# done
# done
# done

# ## Lets do this for En-Ko

# rm -rf En_Ko_MQM_Quality_Scores/Correlation_Scores_MQM.csv

# for domain in GlobalVoices TEDTalks
# do
# for split in Training Validation Test
# do
# for byte_order in 2 6 10 13 16 20
# do
# for char_order in 0 2 4 6 9 12
# do
# for word_order in 0
# do
# if [ $byte_order -ge $char_order ] && [ $char_order -ge $word_order ]
# then
# echo "Running for $split, $domain, $byte_order, $char_order, $word_order"
# if [ $char_order -gt 0 ]
# then
# cat En_Ko_MQM_Quality_Scores/"$domain"."$split".translation | sacrebleu En_Ko_MQM_Quality_Scores/"$domain"."$split".ref -m chrf --chrf-char-order $char_order --chrf-word-order $word_order  --sentence-level --tokenize ko-mecab | rev | cut -d " " -f1 | rev > En_Ko_MQM_Quality_Scores/"$domain"."$split".chrf.char_order_"$char_order"_word_order_"$word_order"
# fi

# cat En_Ko_MQM_Quality_Scores/"$domain"."$split".translation | sacrebleu En_Ko_MQM_Quality_Scores/"$domain"."$split".ref -m bytf --bytf-byte-order $byte_order --bytf-char-order $char_order --bytf-word-order $word_order --sentence-level --tokenize ko-mecab | rev | cut -d " " -f1 | rev > En_Ko_MQM_Quality_Scores/"$domain"."$split".bytf.byte_order_"$byte_order"_char_order_"$char_order"_word_order_"$word_order"

# if [ $char_order -gt 0 ]
# then
# python normalize_scores.py En_Ko_MQM_Quality_Scores/"$domain"."$split".chrf.char_order_"$char_order"_word_order_"$word_order" 100
# fi
# python normalize_scores.py En_Ko_MQM_Quality_Scores/"$domain"."$split".bytf.byte_order_"$byte_order"_char_order_"$char_order"_word_order_"$word_order" 100

# if [ $char_order -gt 0 ]
# then
# chrfscores=`python compute_correlation_metrics.py En_Ko_MQM_Quality_Scores/"$domain"."$split".chrf.char_order_"$char_order"_word_order_"$word_order".normalized En_Ko_MQM_Quality_Scores/"$domain"."$split".total`
# fi

# bytfscores=`python compute_correlation_metrics.py En_Ko_MQM_Quality_Scores/"$domain"."$split".bytf.byte_order_"$byte_order"_char_order_"$char_order"_word_order_"$word_order".normalized En_Ko_MQM_Quality_Scores/"$domain"."$split".total`

# if [ $char_order -gt 0 ]
# then
# chrf_pearson=`echo $chrfscores | cut -d "," -f1`
# chrf_kendall=`echo $chrfscores | cut -d "," -f3`
# chrf_pearson_pvalue=`echo $chrfscores | cut -d "," -f2`
# chrf_kendall_pvalue=`echo $chrfscores | cut -d "," -f4`
# else
# chrf_pearson="NA"
# chrf_kendall="NA"
# chrf_pearson_pvalue="NA"
# chrf_kendall_pvalue="NA"
# fi
# bytf_pearson=`echo $bytfscores | cut -d "," -f1`
# bytf_kendall=`echo $bytfscores | cut -d "," -f3`
# bytf_pearson_pvalue=`echo $bytfscores | cut -d "," -f2`
# bytf_kendall_pvalue=`echo $bytfscores | cut -d "," -f4`

# ## No separate scores for MQM for En-Ko. Just report the scores for DA.

# echo "$domain, $split, $byte_order, $char_order, $word_order, $chrf_pearson, $bytf_pearson, $chrf_kendall, $bytf_kendall, $chrf_pearson_pvalue, $bytf_pearson_pvalue, $chrf_kendall_pvalue, $bytf_kendall_pvalue" >> En_Ko_MQM_Quality_Scores/Correlation_Scores_MQM.csv
# fi
# done
# done
# done
# done
# done

## Some WMT stuff

rm -rf wmt23-da-human-evaluation.bn-hi.wiki.2021.csv

for byte_order in 2 6 10 13 16 20
do
for char_order in 0 2 4 6 9 12
do
for word_order in 0 2 4
do
if [ $byte_order -ge $char_order ] && [ $char_order -ge $word_order ]
then
echo "Running for $byte_order, $char_order, $word_order"
if [ $char_order -gt 0 ]
then
cat wmt23-da-human-evaluation.bn-hi.wiki.2021.mt | sacrebleu wmt23-da-human-evaluation.bn-hi.wiki.2021.ref -m chrf --chrf-char-order $char_order --chrf-word-order $word_order  --sentence-level | rev | cut -d " " -f1 | rev > wmt23-da-human-evaluation.bn-hi.wiki.2021.chrf.char_order_"$char_order"_word_order_"$word_order"
fi

cat wmt23-da-human-evaluation.bn-hi.wiki.2021.mt | sacrebleu wmt23-da-human-evaluation.bn-hi.wiki.2021.ref -m bytf --bytf-byte-order $byte_order --bytf-char-order $char_order --bytf-word-order $word_order --sentence-level | rev | cut -d " " -f1 | rev > wmt23-da-human-evaluation.bn-hi.wiki.2021.bytf.byte_order_"$byte_order"_char_order_"$char_order"_word_order_"$word_order"

if [ $char_order -gt 0 ]
then
python normalize_scores.py wmt23-da-human-evaluation.bn-hi.wiki.2021.chrf.char_order_"$char_order"_word_order_"$word_order" 100
fi
python normalize_scores.py wmt23-da-human-evaluation.bn-hi.wiki.2021.bytf.byte_order_"$byte_order"_char_order_"$char_order"_word_order_"$word_order" 100

if [ $char_order -gt 0 ]
then
chrfscores=`python compute_correlation_metrics.py wmt23-da-human-evaluation.bn-hi.wiki.2021.chrf.char_order_"$char_order"_word_order_"$word_order".normalized wmt23-da-human-evaluation.bn-hi.wiki.2021.score`
fi

bytfscores=`python compute_correlation_metrics.py wmt23-da-human-evaluation.bn-hi.wiki.2021.bytf.byte_order_"$byte_order"_char_order_"$char_order"_word_order_"$word_order".normalized wmt23-da-human-evaluation.bn-hi.wiki.2021.score`

if [ $char_order -gt 0 ]
then
chrf_pearson=`echo $chrfscores | cut -d "," -f1`
chrf_kendall=`echo $chrfscores | cut -d "," -f3`
chrf_pearson_pvalue=`echo $chrfscores | cut -d "," -f2`
chrf_kendall_pvalue=`echo $chrfscores | cut -d "," -f4`
else
chrf_pearson="NA"
chrf_kendall="NA"
chrf_pearson_pvalue="NA"
chrf_kendall_pvalue="NA"
fi
bytf_pearson=`echo $bytfscores | cut -d "," -f1`
bytf_kendall=`echo $bytfscores | cut -d "," -f3`
bytf_pearson_pvalue=`echo $bytfscores | cut -d "," -f2`
bytf_kendall_pvalue=`echo $bytfscores | cut -d "," -f4`

## No separate scores for MQM for En-Ko. Just report the scores for DA.

echo "$byte_order, $char_order, $word_order, $chrf_pearson, $bytf_pearson, $chrf_kendall, $bytf_kendall, $chrf_pearson_pvalue, $bytf_pearson_pvalue, $chrf_kendall_pvalue, $bytf_kendall_pvalue" >> wmt23-da-human-evaluation.bn-hi.wiki.2021.csv
fi
done
done
done

## Lets do this on a subsample of the data

head -200 wmt23-da-human-evaluation.hi-bn.wiki.2021.mt > wmt23-da-human-evaluation.hi-bn.wiki.2021.200.mt
head -200 wmt23-da-human-evaluation.hi-bn.wiki.2021.ref > wmt23-da-human-evaluation.hi-bn.wiki.2021.200.ref
head -200 wmt23-da-human-evaluation.hi-bn.wiki.2021.score > wmt23-da-human-evaluation.hi-bn.wiki.2021.200.score

## FUCKKK I need to rerun the data extraction script again. Why did it overwrite the files. I should have made a copy.

rm -rf wmt23-da-human-evaluation.hi-bn.wiki.2021.csv

for byte_order in 2 6 10 13 16 20
do
for char_order in 0 2 4 6 9 12
do
for word_order in 0 2 4
do
if [ $byte_order -ge $char_order ] && [ $char_order -ge $word_order ]
then
echo "Running for $byte_order, $char_order, $word_order"
if [ $char_order -gt 0 ]
then
cat wmt23-da-human-evaluation.hi-bn.wiki.2021.mt | sacrebleu wmt23-da-human-evaluation.hi-bn.wiki.2021.ref -m chrf --chrf-char-order $char_order --chrf-word-order $word_order  --sentence-level | rev | cut -d " " -f1 | rev > wmt23-da-human-evaluation.hi-bn.wiki.2021.chrf.char_order_"$char_order"_word_order_"$word_order"
fi

cat wmt23-da-human-evaluation.hi-bn.wiki.2021.mt | sacrebleu wmt23-da-human-evaluation.hi-bn.wiki.2021.ref -m bytf --bytf-byte-order $byte_order --bytf-char-order $char_order --bytf-word-order $word_order --sentence-level | rev | cut -d " " -f1 | rev > wmt23-da-human-evaluation.hi-bn.wiki.2021.bytf.byte_order_"$byte_order"_char_order_"$char_order"_word_order_"$word_order"

if [ $char_order -gt 0 ]
then
python normalize_scores.py wmt23-da-human-evaluation.hi-bn.wiki.2021.chrf.char_order_"$char_order"_word_order_"$word_order" 100
fi
python normalize_scores.py wmt23-da-human-evaluation.hi-bn.wiki.2021.bytf.byte_order_"$byte_order"_char_order_"$char_order"_word_order_"$word_order" 100

if [ $char_order -gt 0 ]
then
chrfscores=`python compute_correlation_metrics.py wmt23-da-human-evaluation.hi-bn.wiki.2021.chrf.char_order_"$char_order"_word_order_"$word_order".normalized wmt23-da-human-evaluation.hi-bn.wiki.2021.score`
fi

bytfscores=`python compute_correlation_metrics.py wmt23-da-human-evaluation.hi-bn.wiki.2021.bytf.byte_order_"$byte_order"_char_order_"$char_order"_word_order_"$word_order".normalized wmt23-da-human-evaluation.hi-bn.wiki.2021.score`

if [ $char_order -gt 0 ]
then
chrf_pearson=`echo $chrfscores | cut -d "," -f1`
chrf_kendall=`echo $chrfscores | cut -d "," -f3`
chrf_pearson_pvalue=`echo $chrfscores | cut -d "," -f2`
chrf_kendall_pvalue=`echo $chrfscores | cut -d "," -f4`
else
chrf_pearson="NA"
chrf_kendall="NA"
chrf_pearson_pvalue="NA"
chrf_kendall_pvalue="NA"
fi
bytf_pearson=`echo $bytfscores | cut -d "," -f1`
bytf_kendall=`echo $bytfscores | cut -d "," -f3`
bytf_pearson_pvalue=`echo $bytfscores | cut -d "," -f2`
bytf_kendall_pvalue=`echo $bytfscores | cut -d "," -f4`

## No separate scores for MQM for En-Ko. Just report the scores for DA.

echo "$byte_order, $char_order, $word_order, $chrf_pearson, $bytf_pearson, $chrf_kendall, $bytf_kendall, $chrf_pearson_pvalue, $bytf_pearson_pvalue, $chrf_kendall_pvalue, $bytf_kendall_pvalue" >> wmt23-da-human-evaluation.hi-bn.wiki.2021.csv
fi
done
done
done

## Ok now for a sample of wmt23-da-human-evaluation.en-ta.news.2020

head -1000 wmt23-da-human-evaluation.en-ta.news.2020.mt > wmt23-da-human-evaluation.en-ta.news.2020.1000.mt
head -1000 wmt23-da-human-evaluation.en-ta.news.2020.ref > wmt23-da-human-evaluation.en-ta.news.2020.1000.ref
head -1000 wmt23-da-human-evaluation.en-ta.news.2020.score > wmt23-da-human-evaluation.en-ta.news.2020.1000.score

rm -rf wmt23-da-human-evaluation.en-ta.news.2020.1000.csv

for byte_order in 2 6 10 13 16 20
do
for char_order in 0 2 4 6 9 12
do
for word_order in 0 2 4
do
if [ $byte_order -ge $char_order ] && [ $char_order -ge $word_order ]
then
echo "Running for $byte_order, $char_order, $word_order"
if [ $char_order -gt 0 ]
then
cat wmt23-da-human-evaluation.en-ta.news.2020.1000.mt | sacrebleu wmt23-da-human-evaluation.en-ta.news.2020.1000.ref -m chrf --chrf-char-order $char_order --chrf-word-order $word_order  --sentence-level | rev | cut -d " " -f1 | rev > wmt23-da-human-evaluation.en-ta.news.2020.1000.chrf.char_order_"$char_order"_word_order_"$word_order"
fi

cat wmt23-da-human-evaluation.en-ta.news.2020.1000.mt | sacrebleu wmt23-da-human-evaluation.en-ta.news.2020.1000.ref -m bytf --bytf-byte-order $byte_order --bytf-char-order $char_order --bytf-word-order $word_order --sentence-level | rev | cut -d " " -f1 | rev > wmt23-da-human-evaluation.en-ta.news.2020.1000.bytf.byte_order_"$byte_order"_char_order_"$char_order"_word_order_"$word_order"

if [ $char_order -gt 0 ]
then
python normalize_scores.py wmt23-da-human-evaluation.en-ta.news.2020.1000.chrf.char_order_"$char_order"_word_order_"$word_order" 100
fi
python normalize_scores.py wmt23-da-human-evaluation.en-ta.news.2020.1000.bytf.byte_order_"$byte_order"_char_order_"$char_order"_word_order_"$word_order" 100

if [ $char_order -gt 0 ]
then
chrfscores=`python compute_correlation_metrics.py wmt23-da-human-evaluation.en-ta.news.2020.1000.chrf.char_order_"$char_order"_word_order_"$word_order".normalized wmt23-da-human-evaluation.en-ta.news.2020.1000.score`
fi

bytfscores=`python compute_correlation_metrics.py wmt23-da-human-evaluation.en-ta.news.2020.1000.bytf.byte_order_"$byte_order"_char_order_"$char_order"_word_order_"$word_order".normalized wmt23-da-human-evaluation.en-ta.news.2020.1000.score`

if [ $char_order -gt 0 ]
then
chrf_pearson=`echo $chrfscores | cut -d "," -f1`
chrf_kendall=`echo $chrfscores | cut -d "," -f3`
chrf_pearson_pvalue=`echo $chrfscores | cut -d "," -f2`
chrf_kendall_pvalue=`echo $chrfscores | cut -d "," -f4`
else
chrf_pearson="NA"
chrf_kendall="NA"
chrf_pearson_pvalue="NA"
chrf_kendall_pvalue="NA"
fi
bytf_pearson=`echo $bytfscores | cut -d "," -f1`
bytf_kendall=`echo $bytfscores | cut -d "," -f3`
bytf_pearson_pvalue=`echo $bytfscores | cut -d "," -f2`
bytf_kendall_pvalue=`echo $bytfscores | cut -d "," -f4`

## No separate scores for MQM for En-Ko. Just report the scores for DA.

echo "$byte_order, $char_order, $word_order, $chrf_pearson, $bytf_pearson, $chrf_kendall, $bytf_kendall, $chrf_pearson_pvalue, $bytf_pearson_pvalue, $chrf_kendall_pvalue, $bytf_kendall_pvalue" >> wmt23-da-human-evaluation.en-ta.news.2020.1000.csv
fi
done
done
done


## Now for wmt23-da-human-evaluation.en-zh.news 2017 2018 2019 2020 2021

for year in 2017 2018 2019 2020 2021
do
head -1000 wmt23-da-human-evaluation.en-zh.news.$year.mt > wmt23-da-human-evaluation.en-zh.news.$year.1000.mt
head -1000 wmt23-da-human-evaluation.en-zh.news.$year.ref > wmt23-da-human-evaluation.en-zh.news.$year.1000.ref
head -1000 wmt23-da-human-evaluation.en-zh.news.$year.score > wmt23-da-human-evaluation.en-zh.news.$year.1000.score

rm -rf wmt23-da-human-evaluation.en-zh.news.$year.1000.csv


for byte_order in 2 6 10 13 16 20
do
for char_order in 0 2 4 6 9 12
do
for word_order in 0 2 4
do
if [ $byte_order -ge $char_order ] && [ $char_order -ge $word_order ]
then
echo "Running for $byte_order, $char_order, $word_order"
if [ $char_order -gt 0 ]
then
cat wmt23-da-human-evaluation.en-zh.news.$year.1000.mt | sacrebleu wmt23-da-human-evaluation.en-zh.news.$year.1000.ref -m chrf --tokenize zh --chrf-char-order $char_order --chrf-word-order $word_order  --sentence-level | rev | cut -d " " -f1 | rev > wmt23-da-human-evaluation.en-zh.news.$year.1000.chrf.char_order_"$char_order"_word_order_"$word_order"
fi

cat wmt23-da-human-evaluation.en-zh.news.$year.1000.mt | sacrebleu wmt23-da-human-evaluation.en-zh.news.$year.1000.ref -m bytf --tokenize zh --bytf-byte-order $byte_order --bytf-char-order $char_order --bytf-word-order $word_order --sentence-level | rev | cut -d " " -f1 | rev > wmt23-da-human-evaluation.en-zh.news.$year.1000.bytf.byte_order_"$byte_order"_char_order_"$char_order"_word_order_"$word_order"

if [ $char_order -gt 0 ]
then
python normalize_scores.py wmt23-da-human-evaluation.en-zh.news.$year.1000.chrf.char_order_"$char_order"_word_order_"$word_order" 100
fi
python normalize_scores.py wmt23-da-human-evaluation.en-zh.news.$year.1000.bytf.byte_order_"$byte_order"_char_order_"$char_order"_word_order_"$word_order" 100

if [ $char_order -gt 0 ]
then
chrfscores=`python compute_correlation_metrics.py wmt23-da-human-evaluation.en-zh.news.$year.1000.chrf.char_order_"$char_order"_word_order_"$word_order".normalized wmt23-da-human-evaluation.en-zh.news.$year.1000.score`
fi

bytfscores=`python compute_correlation_metrics.py wmt23-da-human-evaluation.en-zh.news.$year.1000.bytf.byte_order_"$byte_order"_char_order_"$char_order"_word_order_"$word_order".normalized wmt23-da-human-evaluation.en-zh.news.$year.1000.score`

if [ $char_order -gt 0 ]
then
chrf_pearson=`echo $chrfscores | cut -d "," -f1`
chrf_kendall=`echo $chrfscores | cut -d "," -f3`
chrf_pearson_pvalue=`echo $chrfscores | cut -d "," -f2`
chrf_kendall_pvalue=`echo $chrfscores | cut -d "," -f4`
else
chrf_pearson="NA"
chrf_kendall="NA"
chrf_pearson_pvalue="NA"
chrf_kendall_pvalue="NA"
fi
bytf_pearson=`echo $bytfscores | cut -d "," -f1`
bytf_kendall=`echo $bytfscores | cut -d "," -f3`
bytf_pearson_pvalue=`echo $bytfscores | cut -d "," -f2`
bytf_kendall_pvalue=`echo $bytfscores | cut -d "," -f4`

## No separate scores for MQM for En-Ko. Just report the scores for DA.

echo "$byte_order, $char_order, $word_order, $chrf_pearson, $bytf_pearson, $chrf_kendall, $bytf_kendall, $chrf_pearson_pvalue, $bytf_pearson_pvalue, $chrf_kendall_pvalue, $bytf_kendall_pvalue" >> wmt23-da-human-evaluation.en-zh.news.$year.1000.csv
fi
done
done
done
done

## En-Cs draj/softwares/sacrebleu/wmt23-da-human-evaluation.en-cs.news.2020.ref

for year in 2017 2018 2019 2020 2021
do
head -1000 wmt23-da-human-evaluation.en-cs.news.$year.mt > wmt23-da-human-evaluation.en-cs.news.$year.1000.mt
head -1000 wmt23-da-human-evaluation.en-cs.news.$year.ref > wmt23-da-human-evaluation.en-cs.news.$year.1000.ref
head -1000 wmt23-da-human-evaluation.en-cs.news.$year.score > wmt23-da-human-evaluation.en-cs.news.$year.1000.score

rm -rf wmt23-da-human-evaluation.en-cs.news.$year.1000.csv


for byte_order in 2 6 10 13 16 20
do
for char_order in 0 2 4 6 9 12
do
for word_order in 0 2 4
do
if [ $byte_order -ge $char_order ] && [ $char_order -ge $word_order ]
then
echo "Running for $byte_order, $char_order, $word_order"
if [ $char_order -gt 0 ]
then
cat wmt23-da-human-evaluation.en-cs.news.$year.1000.mt | sacrebleu wmt23-da-human-evaluation.en-cs.news.$year.1000.ref -m chrf --tokenize zh --chrf-char-order $char_order --chrf-word-order $word_order  --sentence-level | rev | cut -d " " -f1 | rev > wmt23-da-human-evaluation.en-cs.news.$year.1000.chrf.char_order_"$char_order"_word_order_"$word_order"
fi

cat wmt23-da-human-evaluation.en-cs.news.$year.1000.mt | sacrebleu wmt23-da-human-evaluation.en-cs.news.$year.1000.ref -m bytf --tokenize zh --bytf-byte-order $byte_order --bytf-char-order $char_order --bytf-word-order $word_order --sentence-level | rev | cut -d " " -f1 | rev > wmt23-da-human-evaluation.en-cs.news.$year.1000.bytf.byte_order_"$byte_order"_char_order_"$char_order"_word_order_"$word_order"

if [ $char_order -gt 0 ]
then
python normalize_scores.py wmt23-da-human-evaluation.en-cs.news.$year.1000.chrf.char_order_"$char_order"_word_order_"$word_order" 100
fi
python normalize_scores.py wmt23-da-human-evaluation.en-cs.news.$year.1000.bytf.byte_order_"$byte_order"_char_order_"$char_order"_word_order_"$word_order" 100

if [ $char_order -gt 0 ]
then
chrfscores=`python compute_correlation_metrics.py wmt23-da-human-evaluation.en-cs.news.$year.1000.chrf.char_order_"$char_order"_word_order_"$word_order".normalized wmt23-da-human-evaluation.en-cs.news.$year.1000.score`
fi

bytfscores=`python compute_correlation_metrics.py wmt23-da-human-evaluation.en-cs.news.$year.1000.bytf.byte_order_"$byte_order"_char_order_"$char_order"_word_order_"$word_order".normalized wmt23-da-human-evaluation.en-cs.news.$year.1000.score`

if [ $char_order -gt 0 ]
then
chrf_pearson=`echo $chrfscores | cut -d "," -f1`
chrf_kendall=`echo $chrfscores | cut -d "," -f3`
chrf_pearson_pvalue=`echo $chrfscores | cut -d "," -f2`
chrf_kendall_pvalue=`echo $chrfscores | cut -d "," -f4`
else
chrf_pearson="NA"
chrf_kendall="NA"
chrf_pearson_pvalue="NA"
chrf_kendall_pvalue="NA"
fi
bytf_pearson=`echo $bytfscores | cut -d "," -f1`
bytf_kendall=`echo $bytfscores | cut -d "," -f3`
bytf_pearson_pvalue=`echo $bytfscores | cut -d "," -f2`
bytf_kendall_pvalue=`echo $bytfscores | cut -d "," -f4`

## No separate scores for MQM for En-Ko. Just report the scores for DA.

echo "$byte_order, $char_order, $word_order, $chrf_pearson, $bytf_pearson, $chrf_kendall, $bytf_kendall, $chrf_pearson_pvalue, $bytf_pearson_pvalue, $chrf_kendall_pvalue, $bytf_kendall_pvalue" >> wmt23-da-human-evaluation.en-cs.news.$year.1000.csv
fi
done
done
done
done

## En-Gu draj/softwares/sacrebleu/wmt23-da-human-evaluation.en-gu.news.2019.ref

for year in 2019
do
head -1000 wmt23-da-human-evaluation.en-gu.news.$year.mt > wmt23-da-human-evaluation.en-gu.news.$year.1000.mt
head -1000 wmt23-da-human-evaluation.en-gu.news.$year.ref > wmt23-da-human-evaluation.en-gu.news.$year.1000.ref
head -1000 wmt23-da-human-evaluation.en-gu.news.$year.score > wmt23-da-human-evaluation.en-gu.news.$year.1000.score

rm -rf wmt23-da-human-evaluation.en-gu.news.$year.1000.csv


for byte_order in 2 6 10 13 16 20
do
for char_order in 0 2 4 6 9 12
do
for word_order in 0 2 4
do
if [ $byte_order -ge $char_order ] && [ $char_order -ge $word_order ]
then
echo "Running for $byte_order, $char_order, $word_order"
if [ $char_order -gt 0 ]
then
cat wmt23-da-human-evaluation.en-gu.news.$year.1000.mt | sacrebleu wmt23-da-human-evaluation.en-gu.news.$year.1000.ref -m chrf --tokenize zh --chrf-char-order $char_order --chrf-word-order $word_order  --sentence-level | rev | cut -d " " -f1 | rev > wmt23-da-human-evaluation.en-gu.news.$year.1000.chrf.char_order_"$char_order"_word_order_"$word_order"
fi

cat wmt23-da-human-evaluation.en-gu.news.$year.1000.mt | sacrebleu wmt23-da-human-evaluation.en-gu.news.$year.1000.ref -m bytf --tokenize zh --bytf-byte-order $byte_order --bytf-char-order $char_order --bytf-word-order $word_order --sentence-level | rev | cut -d " " -f1 | rev > wmt23-da-human-evaluation.en-gu.news.$year.1000.bytf.byte_order_"$byte_order"_char_order_"$char_order"_word_order_"$word_order"

if [ $char_order -gt 0 ]
then
python normalize_scores.py wmt23-da-human-evaluation.en-gu.news.$year.1000.chrf.char_order_"$char_order"_word_order_"$word_order" 100
fi
python normalize_scores.py wmt23-da-human-evaluation.en-gu.news.$year.1000.bytf.byte_order_"$byte_order"_char_order_"$char_order"_word_order_"$word_order" 100

if [ $char_order -gt 0 ]
then
chrfscores=`python compute_correlation_metrics.py wmt23-da-human-evaluation.en-gu.news.$year.1000.chrf.char_order_"$char_order"_word_order_"$word_order".normalized wmt23-da-human-evaluation.en-gu.news.$year.1000.score`
fi

bytfscores=`python compute_correlation_metrics.py wmt23-da-human-evaluation.en-gu.news.$year.1000.bytf.byte_order_"$byte_order"_char_order_"$char_order"_word_order_"$word_order".normalized wmt23-da-human-evaluation.en-gu.news.$year.1000.score`

if [ $char_order -gt 0 ]
then
chrf_pearson=`echo $chrfscores | cut -d "," -f1`
chrf_kendall=`echo $chrfscores | cut -d "," -f3`
chrf_pearson_pvalue=`echo $chrfscores | cut -d "," -f2`
chrf_kendall_pvalue=`echo $chrfscores | cut -d "," -f4`
else
chrf_pearson="NA"
chrf_kendall="NA"
chrf_pearson_pvalue="NA"
chrf_kendall_pvalue="NA"
fi
bytf_pearson=`echo $bytfscores | cut -d "," -f1`
bytf_kendall=`echo $bytfscores | cut -d "," -f3`
bytf_pearson_pvalue=`echo $bytfscores | cut -d "," -f2`
bytf_kendall_pvalue=`echo $bytfscores | cut -d "," -f4`

## No separate scores for MQM for En-Ko. Just report the scores for DA.

echo "$byte_order, $char_order, $word_order, $chrf_pearson, $bytf_pearson, $chrf_kendall, $bytf_kendall, $chrf_pearson_pvalue, $bytf_pearson_pvalue, $chrf_kendall_pvalue, $bytf_kendall_pvalue" >> wmt23-da-human-evaluation.en-gu.news.$year.1000.csv
fi
done
done
done
done


## En-Is draj/softwares/sacrebleu/wmt23-da-human-evaluation.en-is.news.2021.ref

for year in 2021
do
head -1000 wmt23-da-human-evaluation.en-is.news.$year.mt > wmt23-da-human-evaluation.en-is.news.$year.1000.mt
head -1000 wmt23-da-human-evaluation.en-is.news.$year.ref > wmt23-da-human-evaluation.en-is.news.$year.1000.ref
head -1000 wmt23-da-human-evaluation.en-is.news.$year.score > wmt23-da-human-evaluation.en-is.news.$year.1000.score

rm -rf wmt23-da-human-evaluation.en-is.news.$year.1000.csv


for byte_order in 2 6 10 13 16 20
do
for char_order in 0 2 4 6 9 12
do
for word_order in 0 2 4
do
if [ $byte_order -ge $char_order ] && [ $char_order -ge $word_order ]
then
echo "Running for $byte_order, $char_order, $word_order"
if [ $char_order -gt 0 ]
then
cat wmt23-da-human-evaluation.en-is.news.$year.1000.mt | sacrebleu wmt23-da-human-evaluation.en-is.news.$year.1000.ref -m chrf --tokenize zh --chrf-char-order $char_order --chrf-word-order $word_order  --sentence-level | rev | cut -d " " -f1 | rev > wmt23-da-human-evaluation.en-is.news.$year.1000.chrf.char_order_"$char_order"_word_order_"$word_order"
fi

cat wmt23-da-human-evaluation.en-is.news.$year.1000.mt | sacrebleu wmt23-da-human-evaluation.en-is.news.$year.1000.ref -m bytf --tokenize zh --bytf-byte-order $byte_order --bytf-char-order $char_order --bytf-word-order $word_order --sentence-level | rev | cut -d " " -f1 | rev > wmt23-da-human-evaluation.en-is.news.$year.1000.bytf.byte_order_"$byte_order"_char_order_"$char_order"_word_order_"$word_order"

if [ $char_order -gt 0 ]
then
python normalize_scores.py wmt23-da-human-evaluation.en-is.news.$year.1000.chrf.char_order_"$char_order"_word_order_"$word_order" 100
fi
python normalize_scores.py wmt23-da-human-evaluation.en-is.news.$year.1000.bytf.byte_order_"$byte_order"_char_order_"$char_order"_word_order_"$word_order" 100

if [ $char_order -gt 0 ]
then
chrfscores=`python compute_correlation_metrics.py wmt23-da-human-evaluation.en-is.news.$year.1000.chrf.char_order_"$char_order"_word_order_"$word_order".normalized wmt23-da-human-evaluation.en-is.news.$year.1000.score`
fi

bytfscores=`python compute_correlation_metrics.py wmt23-da-human-evaluation.en-is.news.$year.1000.bytf.byte_order_"$byte_order"_char_order_"$char_order"_word_order_"$word_order".normalized wmt23-da-human-evaluation.en-is.news.$year.1000.score`

if [ $char_order -gt 0 ]
then
chrf_pearson=`echo $chrfscores | cut -d "," -f1`
chrf_kendall=`echo $chrfscores | cut -d "," -f3`
chrf_pearson_pvalue=`echo $chrfscores | cut -d "," -f2`
chrf_kendall_pvalue=`echo $chrfscores | cut -d "," -f4`
else
chrf_pearson="NA"
chrf_kendall="NA"
chrf_pearson_pvalue="NA"
chrf_kendall_pvalue="NA"
fi
bytf_pearson=`echo $bytfscores | cut -d "," -f1`
bytf_kendall=`echo $bytfscores | cut -d "," -f3`
bytf_pearson_pvalue=`echo $bytfscores | cut -d "," -f2`
bytf_kendall_pvalue=`echo $bytfscores | cut -d "," -f4`

## No separate scores for MQM for En-Ko. Just report the scores for DA.

echo "$byte_order, $char_order, $word_order, $chrf_pearson, $bytf_pearson, $chrf_kendall, $bytf_kendall, $chrf_pearson_pvalue, $bytf_pearson_pvalue, $chrf_kendall_pvalue, $bytf_kendall_pvalue" >> wmt23-da-human-evaluation.en-is.news.$year.1000.csv
fi
done
done
done
done

## En-Ja draj/softwares/sacrebleu/wmt23-da-human-evaluation.en-ja.news.2021.ref
langpair="en-ja"

for year in 2020 2021
do
head -1000 wmt23-da-human-evaluation.$langpair.news.$year.mt > wmt23-da-human-evaluation.$langpair.news.$year.1000.mt
head -1000 wmt23-da-human-evaluation.$langpair.news.$year.ref > wmt23-da-human-evaluation.$langpair.news.$year.1000.ref
head -1000 wmt23-da-human-evaluation.$langpair.news.$year.score > wmt23-da-human-evaluation.$langpair.news.$year.1000.score

rm -rf wmt23-da-human-evaluation.$langpair.news.$year.1000.csv


for byte_order in 2 6 10 13 16 20
do
for char_order in 0 2 4 6 9 12
do
for word_order in 0
do
if [ $byte_order -ge $char_order ] && [ $char_order -ge $word_order ]
then
echo "Running for $byte_order, $char_order, $word_order"
if [ $char_order -gt 0 ]
then
cat wmt23-da-human-evaluation.$langpair.news.$year.1000.mt | sacrebleu wmt23-da-human-evaluation.$langpair.news.$year.1000.ref -m chrf --tokenize zh --chrf-char-order $char_order --chrf-word-order $word_order  --sentence-level | rev | cut -d " " -f1 | rev > wmt23-da-human-evaluation.$langpair.news.$year.1000.chrf.char_order_"$char_order"_word_order_"$word_order"
fi

cat wmt23-da-human-evaluation.$langpair.news.$year.1000.mt | sacrebleu wmt23-da-human-evaluation.$langpair.news.$year.1000.ref -m bytf --tokenize zh --bytf-byte-order $byte_order --bytf-char-order $char_order --bytf-word-order $word_order --sentence-level | rev | cut -d " " -f1 | rev > wmt23-da-human-evaluation.$langpair.news.$year.1000.bytf.byte_order_"$byte_order"_char_order_"$char_order"_word_order_"$word_order"

if [ $char_order -gt 0 ]
then
python normalize_scores.py wmt23-da-human-evaluation.$langpair.news.$year.1000.chrf.char_order_"$char_order"_word_order_"$word_order" 100
fi
python normalize_scores.py wmt23-da-human-evaluation.$langpair.news.$year.1000.bytf.byte_order_"$byte_order"_char_order_"$char_order"_word_order_"$word_order" 100

if [ $char_order -gt 0 ]
then
chrfscores=`python compute_correlation_metrics.py wmt23-da-human-evaluation.$langpair.news.$year.1000.chrf.char_order_"$char_order"_word_order_"$word_order".normalized wmt23-da-human-evaluation.$langpair.news.$year.1000.score`
fi

bytfscores=`python compute_correlation_metrics.py wmt23-da-human-evaluation.$langpair.news.$year.1000.bytf.byte_order_"$byte_order"_char_order_"$char_order"_word_order_"$word_order".normalized wmt23-da-human-evaluation.$langpair.news.$year.1000.score`

if [ $char_order -gt 0 ]
then
chrf_pearson=`echo $chrfscores | cut -d "," -f1`
chrf_kendall=`echo $chrfscores | cut -d "," -f3`
chrf_pearson_pvalue=`echo $chrfscores | cut -d "," -f2`
chrf_kendall_pvalue=`echo $chrfscores | cut -d "," -f4`
else
chrf_pearson="NA"
chrf_kendall="NA"
chrf_pearson_pvalue="NA"
chrf_kendall_pvalue="NA"
fi
bytf_pearson=`echo $bytfscores | cut -d "," -f1`
bytf_kendall=`echo $bytfscores | cut -d "," -f3`
bytf_pearson_pvalue=`echo $bytfscores | cut -d "," -f2`
bytf_kendall_pvalue=`echo $bytfscores | cut -d "," -f4`

## No separate scores for MQM for En-Ko. Just report the scores for DA.

echo "$byte_order, $char_order, $word_order, $chrf_pearson, $bytf_pearson, $chrf_kendall, $bytf_kendall, $chrf_pearson_pvalue, $bytf_pearson_pvalue, $chrf_kendall_pvalue, $bytf_kendall_pvalue" >> wmt23-da-human-evaluation.$langpair.news.$year.1000.csv
fi
done
done
done
done

## En-KK

langpair="en-kk"

for year in 2019
do
head -1000 wmt23-da-human-evaluation.$langpair.news.$year.mt > wmt23-da-human-evaluation.$langpair.news.$year.1000.mt
head -1000 wmt23-da-human-evaluation.$langpair.news.$year.ref > wmt23-da-human-evaluation.$langpair.news.$year.1000.ref
head -1000 wmt23-da-human-evaluation.$langpair.news.$year.score > wmt23-da-human-evaluation.$langpair.news.$year.1000.score

rm -rf wmt23-da-human-evaluation.$langpair.news.$year.1000.csv


for byte_order in 2 6 10 13 16 20
do
for char_order in 0 2 4 6 9 12
do
for word_order in 0 2 4
do
if [ $byte_order -ge $char_order ] && [ $char_order -ge $word_order ]
then
echo "Running for $byte_order, $char_order, $word_order"
if [ $char_order -gt 0 ]
then
cat wmt23-da-human-evaluation.$langpair.news.$year.1000.mt | sacrebleu wmt23-da-human-evaluation.$langpair.news.$year.1000.ref -m chrf --tokenize zh --chrf-char-order $char_order --chrf-word-order $word_order  --sentence-level | rev | cut -d " " -f1 | rev > wmt23-da-human-evaluation.$langpair.news.$year.1000.chrf.char_order_"$char_order"_word_order_"$word_order"
fi

cat wmt23-da-human-evaluation.$langpair.news.$year.1000.mt | sacrebleu wmt23-da-human-evaluation.$langpair.news.$year.1000.ref -m bytf --tokenize zh --bytf-byte-order $byte_order --bytf-char-order $char_order --bytf-word-order $word_order --sentence-level | rev | cut -d " " -f1 | rev > wmt23-da-human-evaluation.$langpair.news.$year.1000.bytf.byte_order_"$byte_order"_char_order_"$char_order"_word_order_"$word_order"

if [ $char_order -gt 0 ]
then
python normalize_scores.py wmt23-da-human-evaluation.$langpair.news.$year.1000.chrf.char_order_"$char_order"_word_order_"$word_order" 100
fi
python normalize_scores.py wmt23-da-human-evaluation.$langpair.news.$year.1000.bytf.byte_order_"$byte_order"_char_order_"$char_order"_word_order_"$word_order" 100

if [ $char_order -gt 0 ]
then
chrfscores=`python compute_correlation_metrics.py wmt23-da-human-evaluation.$langpair.news.$year.1000.chrf.char_order_"$char_order"_word_order_"$word_order".normalized wmt23-da-human-evaluation.$langpair.news.$year.1000.score`
fi

bytfscores=`python compute_correlation_metrics.py wmt23-da-human-evaluation.$langpair.news.$year.1000.bytf.byte_order_"$byte_order"_char_order_"$char_order"_word_order_"$word_order".normalized wmt23-da-human-evaluation.$langpair.news.$year.1000.score`

if [ $char_order -gt 0 ]
then
chrf_pearson=`echo $chrfscores | cut -d "," -f1`
chrf_kendall=`echo $chrfscores | cut -d "," -f3`
chrf_pearson_pvalue=`echo $chrfscores | cut -d "," -f2`
chrf_kendall_pvalue=`echo $chrfscores | cut -d "," -f4`
else
chrf_pearson="NA"
chrf_kendall="NA"
chrf_pearson_pvalue="NA"
chrf_kendall_pvalue="NA"
fi
bytf_pearson=`echo $bytfscores | cut -d "," -f1`
bytf_kendall=`echo $bytfscores | cut -d "," -f3`
bytf_pearson_pvalue=`echo $bytfscores | cut -d "," -f2`
bytf_kendall_pvalue=`echo $bytfscores | cut -d "," -f4`

## No separate scores for MQM for En-Ko. Just report the scores for DA.

echo "$byte_order, $char_order, $word_order, $chrf_pearson, $bytf_pearson, $chrf_kendall, $bytf_kendall, $chrf_pearson_pvalue, $bytf_pearson_pvalue, $chrf_kendall_pvalue, $bytf_kendall_pvalue" >> wmt23-da-human-evaluation.$langpair.news.$year.1000.csv
fi
done
done
done
done

## En-Pl

langpair="en-pl"

for year in 2020
do
head -1000 wmt23-da-human-evaluation.$langpair.news.$year.mt > wmt23-da-human-evaluation.$langpair.news.$year.1000.mt
head -1000 wmt23-da-human-evaluation.$langpair.news.$year.ref > wmt23-da-human-evaluation.$langpair.news.$year.1000.ref
head -1000 wmt23-da-human-evaluation.$langpair.news.$year.score > wmt23-da-human-evaluation.$langpair.news.$year.1000.score

rm -rf wmt23-da-human-evaluation.$langpair.news.$year.1000.csv


for byte_order in 2 6 10 13 16 20
do
for char_order in 0 2 4 6 9 12
do
for word_order in 0 2 4
do
if [ $byte_order -ge $char_order ] && [ $char_order -ge $word_order ]
then
echo "Running for $byte_order, $char_order, $word_order"
if [ $char_order -gt 0 ]
then
cat wmt23-da-human-evaluation.$langpair.news.$year.1000.mt | sacrebleu wmt23-da-human-evaluation.$langpair.news.$year.1000.ref -m chrf --tokenize zh --chrf-char-order $char_order --chrf-word-order $word_order  --sentence-level | rev | cut -d " " -f1 | rev > wmt23-da-human-evaluation.$langpair.news.$year.1000.chrf.char_order_"$char_order"_word_order_"$word_order"
fi

cat wmt23-da-human-evaluation.$langpair.news.$year.1000.mt | sacrebleu wmt23-da-human-evaluation.$langpair.news.$year.1000.ref -m bytf --tokenize zh --bytf-byte-order $byte_order --bytf-char-order $char_order --bytf-word-order $word_order --sentence-level | rev | cut -d " " -f1 | rev > wmt23-da-human-evaluation.$langpair.news.$year.1000.bytf.byte_order_"$byte_order"_char_order_"$char_order"_word_order_"$word_order"

if [ $char_order -gt 0 ]
then
python normalize_scores.py wmt23-da-human-evaluation.$langpair.news.$year.1000.chrf.char_order_"$char_order"_word_order_"$word_order" 100
fi
python normalize_scores.py wmt23-da-human-evaluation.$langpair.news.$year.1000.bytf.byte_order_"$byte_order"_char_order_"$char_order"_word_order_"$word_order" 100

if [ $char_order -gt 0 ]
then
chrfscores=`python compute_correlation_metrics.py wmt23-da-human-evaluation.$langpair.news.$year.1000.chrf.char_order_"$char_order"_word_order_"$word_order".normalized wmt23-da-human-evaluation.$langpair.news.$year.1000.score`
fi

bytfscores=`python compute_correlation_metrics.py wmt23-da-human-evaluation.$langpair.news.$year.1000.bytf.byte_order_"$byte_order"_char_order_"$char_order"_word_order_"$word_order".normalized wmt23-da-human-evaluation.$langpair.news.$year.1000.score`

if [ $char_order -gt 0 ]
then
chrf_pearson=`echo $chrfscores | cut -d "," -f1`
chrf_kendall=`echo $chrfscores | cut -d "," -f3`
chrf_pearson_pvalue=`echo $chrfscores | cut -d "," -f2`
chrf_kendall_pvalue=`echo $chrfscores | cut -d "," -f4`
else
chrf_pearson="NA"
chrf_kendall="NA"
chrf_pearson_pvalue="NA"
chrf_kendall_pvalue="NA"
fi
bytf_pearson=`echo $bytfscores | cut -d "," -f1`
bytf_kendall=`echo $bytfscores | cut -d "," -f3`
bytf_pearson_pvalue=`echo $bytfscores | cut -d "," -f2`
bytf_kendall_pvalue=`echo $bytfscores | cut -d "," -f4`

## No separate scores for MQM for En-Ko. Just report the scores for DA.

echo "$byte_order, $char_order, $word_order, $chrf_pearson, $bytf_pearson, $chrf_kendall, $bytf_kendall, $chrf_pearson_pvalue, $bytf_pearson_pvalue, $chrf_kendall_pvalue, $bytf_kendall_pvalue" >> wmt23-da-human-evaluation.$langpair.news.$year.1000.csv
fi
done
done
done
done

## En-Ru

langpair="en-ru"

for year in 2017 2018 2019 2020 2021
do
head -1000 wmt23-da-human-evaluation.$langpair.news.$year.mt > wmt23-da-human-evaluation.$langpair.news.$year.1000.mt
head -1000 wmt23-da-human-evaluation.$langpair.news.$year.ref > wmt23-da-human-evaluation.$langpair.news.$year.1000.ref
head -1000 wmt23-da-human-evaluation.$langpair.news.$year.score > wmt23-da-human-evaluation.$langpair.news.$year.1000.score

rm -rf wmt23-da-human-evaluation.$langpair.news.$year.1000.csv


for byte_order in 2 6 10 13 16 20
do
for char_order in 0 2 4 6 9 12
do
for word_order in 0 2 4
do
if [ $byte_order -ge $char_order ] && [ $char_order -ge $word_order ]
then
echo "Running for $byte_order, $char_order, $word_order"
if [ $char_order -gt 0 ]
then
cat wmt23-da-human-evaluation.$langpair.news.$year.1000.mt | sacrebleu wmt23-da-human-evaluation.$langpair.news.$year.1000.ref -m chrf --tokenize zh --chrf-char-order $char_order --chrf-word-order $word_order  --sentence-level | rev | cut -d " " -f1 | rev > wmt23-da-human-evaluation.$langpair.news.$year.1000.chrf.char_order_"$char_order"_word_order_"$word_order"
fi

cat wmt23-da-human-evaluation.$langpair.news.$year.1000.mt | sacrebleu wmt23-da-human-evaluation.$langpair.news.$year.1000.ref -m bytf --tokenize zh --bytf-byte-order $byte_order --bytf-char-order $char_order --bytf-word-order $word_order --sentence-level | rev | cut -d " " -f1 | rev > wmt23-da-human-evaluation.$langpair.news.$year.1000.bytf.byte_order_"$byte_order"_char_order_"$char_order"_word_order_"$word_order"

if [ $char_order -gt 0 ]
then
python normalize_scores.py wmt23-da-human-evaluation.$langpair.news.$year.1000.chrf.char_order_"$char_order"_word_order_"$word_order" 100
fi
python normalize_scores.py wmt23-da-human-evaluation.$langpair.news.$year.1000.bytf.byte_order_"$byte_order"_char_order_"$char_order"_word_order_"$word_order" 100

if [ $char_order -gt 0 ]
then
chrfscores=`python compute_correlation_metrics.py wmt23-da-human-evaluation.$langpair.news.$year.1000.chrf.char_order_"$char_order"_word_order_"$word_order".normalized wmt23-da-human-evaluation.$langpair.news.$year.1000.score`
fi

bytfscores=`python compute_correlation_metrics.py wmt23-da-human-evaluation.$langpair.news.$year.1000.bytf.byte_order_"$byte_order"_char_order_"$char_order"_word_order_"$word_order".normalized wmt23-da-human-evaluation.$langpair.news.$year.1000.score`

if [ $char_order -gt 0 ]
then
chrf_pearson=`echo $chrfscores | cut -d "," -f1`
chrf_kendall=`echo $chrfscores | cut -d "," -f3`
chrf_pearson_pvalue=`echo $chrfscores | cut -d "," -f2`
chrf_kendall_pvalue=`echo $chrfscores | cut -d "," -f4`
else
chrf_pearson="NA"
chrf_kendall="NA"
chrf_pearson_pvalue="NA"
chrf_kendall_pvalue="NA"
fi
bytf_pearson=`echo $bytfscores | cut -d "," -f1`
bytf_kendall=`echo $bytfscores | cut -d "," -f3`
bytf_pearson_pvalue=`echo $bytfscores | cut -d "," -f2`
bytf_kendall_pvalue=`echo $bytfscores | cut -d "," -f4`

## No separate scores for MQM for En-Ko. Just report the scores for DA.

echo "$byte_order, $char_order, $word_order, $chrf_pearson, $bytf_pearson, $chrf_kendall, $bytf_kendall, $chrf_pearson_pvalue, $bytf_pearson_pvalue, $chrf_kendall_pvalue, $bytf_kendall_pvalue" >> wmt23-da-human-evaluation.$langpair.news.$year.1000.csv
fi
done
done
done
done


## Get best configs

python get_best_config_for_corr.py wmt23-da-human-evaluation.en-gu.news.2019.comb.csv

for pair in en-cs
do
for year in 2017 2018 2019 2020 2021
do
python get_best_config_for_corr.py wmt23-da-human-evaluation.$pair.news.$year.comb.csv
done
done

for pair in en-kk
do
for year in 2019
do
python get_best_config_for_corr.py wmt23-da-human-evaluation.$pair.news.$year.comb.csv
done
done

for pair in en-ru
do
for year in 2017 2018 2019 2020 2021
do
python get_best_config_for_corr.py wmt23-da-human-evaluation.$pair.news.$year.comb.csv
done
done

for pair in en-ha
do
for year in 2021
do
python get_best_config_for_corr.py wmt23-da-human-evaluation.$pair.news.$year.comb.csv
done
done

for pair in en-tr
do
for year in 2017 2018
do
python get_best_config_for_corr.py wmt23-da-human-evaluation.$pair.news.$year.comb.csv
done
done

for pair in en-is
do
for year in 2021
do
python get_best_config_for_corr.py wmt23-da-human-evaluation.$pair.news.$year.comb.csv
done
done

for pair in en-fi
do
for year in 2018 2018 2019
do
python get_best_config_for_corr.py wmt23-da-human-evaluation.$pair.news.$year.comb.csv
done
done

for pair in en-zh
do
for year in 2017 2018 2019 2020 2021
do
python get_best_config_for_corr.py wmt23-da-human-evaluation.$pair.news.$year.comb.csv
done
done

for pair in en-zh
do
for year in 2020
do
python get_best_config_for_corr.py wmt23-da-human-evaluation.$pair.news.$year.comb.csv
done
done

for pair in en-ja
do
for year in 2020 2021
do
python get_best_config_for_corr.py wmt23-da-human-evaluation.$pair.news.$year.comb.csv
done
done