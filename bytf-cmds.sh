python get_parallel_corpora_and_scores_from_jsonl.py IndicMT-Eval/Dataset/Indic\ MT\ Eval/Hin_test.jsonl

cat IndicMT-Eval/Dataset/Indic\ MT\ Eval/Hin_test.translation | sacrebleu IndicMT-Eval/Dataset/Indic\ MT\ Eval/Hin_test.ref -m chrf --sentence-level | rev | cut -d " " -f1 | rev > IndicMT-Eval/Dataset/Indic\ MT\ Eval/Hin_test.chrf

cat IndicMT-Eval/Dataset/Indic\ MT\ Eval/Hin_test.translation | sacrebleu IndicMT-Eval/Dataset/Indic\ MT\ Eval/Hin_test.ref -m bytf --sentence-level | rev | cut -d " " -f1 | rev > IndicMT-Eval/Dataset/Indic\ MT\ Eval/Hin_test.bytf

python normalize_scores.py IndicMT-Eval/Dataset/Indic\ MT\ Eval/Hin_test.chrf 100
python normalize_scores.py IndicMT-Eval/Dataset/Indic\ MT\ Eval/Hin_test.bytf 100

python compute_correlation_metrics.py IndicMT-Eval/Dataset/Indic\ MT\ Eval/Hin_test.chrf.normalized IndicMT-Eval/Dataset/Indic\ MT\ Eval/Hin_test.da_norm_score

python compute_correlation_metrics.py IndicMT-Eval/Dataset/Indic\ MT\ Eval/Hin_test.bytf.normalized IndicMT-Eval/Dataset/Indic\ MT\ Eval/Hin_test.da_norm_score

python compute_correlation_metrics.py IndicMT-Eval/Dataset/Indic\ MT\ Eval/Hin_test.chrf.normalized IndicMT-Eval/Dataset/Indic\ MT\ Eval/Hin_test.mqm_norm_score


python compute_correlation_metrics.py IndicMT-Eval/Dataset/Indic\ MT\ Eval/Hin_test.bytf.normalized IndicMT-Eval/Dataset/Indic\ MT\ Eval/Hin_test.mqm_norm_score