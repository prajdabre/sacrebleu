# BYTF: How Good Are Byte-Level *n*-Gram F-Scores for Automatic Machine Translation Evaluation?

## 1. Overview

This repo is for our BYTF paper which is accepted to MT Summit 2025.

It is a fork of **[SacreBLEU](https://github.com/mjpost/sacrebleu)** with the implementation of byte-level metrics:

| Metric | Granularity | Flags |
|--------|-------------|-------|
| `bytf` | byte *n*-grams | `--bytf-byte-order N` |
| `bytf+` | byte + character | `--bytf-byte-order N --bytf-char-order M` |
| `bytf++` | byte + character + word | `--bytf-byte-order N --bytf-char-order M --bytf-word-order L` |

## 2. Installation

```bash
git clone https://github.com/prajdabre/sacrebleu
cd sacrebleu
pip install -e .
# Optional: for Indic tokenization support
pip install indic-nlp-library
```

## 3. Usage Examples

```bash
# Character-level baseline (chrF)
sacrebleu ref.txt -i hyp.txt -m chrf --sentence-level \
                  > hyp.chrf

# Byte-level metric (default orders: byte=6, char=0, word=0)
sacrebleu ref.txt -i hyp.txt -m bytf --sentence-level \
                  > hyp.bytf

# chrF with char-order=6, word-order=2 (chrF++)
sacrebleu ref.txt -i hyp.txt -m chrf --chrf-char-order 6 --chrf-word-order 2 \
                  --sentence-level > hyp.chrf.o6_w2

# BYT_F++ with byte=10, char=6, word=2
sacrebleu ref.txt -i hyp.txt -m bytf \
                  --bytf-byte-order 10 \
                  --bytf-char-order 6 \
                  --bytf-word-order 2 \
                  --sentence-level > hyp.bytf.b10_c6_w2
```

## 4. Citation

If you use this work, please cite:

```bibtex
@inproceedings{bytf2025,
  title     = "BYTF: How Good Are Byte-Level n-Gram F-Scores for Automatic Machine Translation Evaluation?",
  author    = "Dabre, Raj and Kaing, Hour and Song, Haiyue",
  booktitle = "Proceedings of Machine Translation Summit XX, Vol. 1: Research Track",
  month     = "jun",
  year      = "2025",
  address   = "Geneva, Switzerland",
  publisher = "European Association for Machine Translation"
}
```
