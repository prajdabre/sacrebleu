from collections import Counter
from typing import List, Tuple

def extract_all_byte_ngrams(line: str, max_order: int) -> List[Counter]:
    """Extracts all byte n-grams at once for convenience.

    :param line: A string sentence.
    :param max_order: The maximum order of the n-grams.
    :return: a list of Counter objects containing ngrams and counts.
    """

    ## First convert the line to bytes
    line = line.encode('utf-8')

    ## Now extract the n-grams
    counters = []
    for n in range(1, max_order + 1):
        ngrams = Counter([line[i:i + n] for i in range(len(line) - n + 1)])
        counters.append(ngrams)

    return counters


def extract_byte_ngrams(line: str, n: int) -> Counter:
    """Extracts byte n-grams with order `n` from a string.

    :param line: A string sentence.
    :param n: The order of the n-grams.
    :return: a Counter object with n-grams counts.
    """

    ## First convert the line to bytes
    line = line.encode('utf-8')

    return Counter([line[i:i + n] for i in range(len(line) - n + 1)])

def extract_all_word_ngrams(line: str, min_order: int, max_order: int) -> Tuple[Counter, int]:
    """Extracts all ngrams (min_order <= n <= max_order) from a sentence.

    :param line: A string sentence.
    :param min_order: Minimum n-gram order.
    :param max_order: Maximum n-gram order.
    :return: a Counter object with n-grams counts and the sequence length.
    """

    ngrams = []
    tokens = line.split()

    for n in range(min_order, max_order + 1):
        for i in range(0, len(tokens) - n + 1):
            ngrams.append(tuple(tokens[i: i + n]))

    return Counter(ngrams), len(tokens)


def extract_word_ngrams(tokens: List[str], n: int) -> Counter:
    """Extracts n-grams with order `n` from a list of tokens.

    :param tokens: A list of tokens.
    :param n: The order of n-grams.
    :return: a Counter object with n-grams counts.
    """
    return Counter([' '.join(tokens[i:i + n]) for i in range(len(tokens) - n + 1)])


def extract_char_ngrams(line: str, n: int, include_whitespace: bool = False) -> Counter:
    """Yields counts of character n-grams from a sentence.

    :param line: A segment containing a sequence of words.
    :param n: The order of the n-grams.
    :param include_whitespace: If given, will not strip whitespaces from the line.
    :return: a dictionary containing ngrams and counts
    """
    if not include_whitespace:
        line = ''.join(line.split())

    return Counter([line[i:i + n] for i in range(len(line) - n + 1)])


def extract_all_char_ngrams(
        line: str, max_order: int, include_whitespace: bool = False) -> List[Counter]:
    """Extracts all character n-grams at once for convenience.

    :param line: A segment containing a sequence of words.
    :param max_order: The maximum order of the n-grams.
    :param include_whitespace: If given, will not strip whitespaces from the line.
    :return: a list of Counter objects containing ngrams and counts.
    """

    counters = []

    if not include_whitespace:
        line = ''.join(line.split())

    for n in range(1, max_order + 1):
        ngrams = Counter([line[i:i + n] for i in range(len(line) - n + 1)])
        counters.append(ngrams)

    return counters

## Now test the functions
counters = extract_all_byte_ngrams("Hello, how are you?", 3)
print(counters)
counters = extract_byte_ngrams("Hello, how are you?", 3)
print(counters)
counters = extract_all_char_ngrams("Hello, how are you?", 3)
print(counters)
counters = extract_char_ngrams("Hello, how are you?", 3)
print(counters)
counters = extract_all_word_ngrams("Hello, how are you?", 1, 3)
print(counters)
counters = extract_word_ngrams("Hello, how are you?".split(), 3)
print(counters)

## Now for a Hindi sentence

counters = extract_all_byte_ngrams("नमस्ते, आप कैसे हैं?", 3)
print(counters)
counters = extract_byte_ngrams("नमस्ते, आप कैसे हैं?", 3)
print(counters)
counters = extract_all_char_ngrams("नमस्ते, आप कैसे हैं?", 3)
print(counters)
counters = extract_char_ngrams("नमस्ते, आप कैसे हैं?", 3)
print(counters)
counters = extract_all_word_ngrams("नमस्ते, आप कैसे हैं?", 1, 3)
print(counters)
counters = extract_word_ngrams("नमस्ते, आप कैसे हैं?".split(), 3)
print(counters)