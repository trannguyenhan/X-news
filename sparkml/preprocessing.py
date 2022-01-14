from nltk.corpus import stopwords
import re as re

def preprocessing(rdd):
    # pre processing data
    reviews = rdd.map(lambda x: x['Content']).filter(lambda x: x is not None)
    StopWords = stopwords.words("english")
    tokens = reviews.map(lambda document: document.strip().lower())
    tokens = tokens.map(lambda document: re.split(" ", document))
    tokens = tokens.map(lambda word: [x for x in word if x.isalpha()])
    tokens = tokens.map(lambda word: [x for x in word if len(x) > 3])
    tokens = tokens.map(lambda word: [x for x in word if x not in StopWords])

    return tokens