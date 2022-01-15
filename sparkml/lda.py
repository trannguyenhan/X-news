import os
import shutil

from pyspark import SparkContext, SparkConf
from pyspark.sql import SQLContext
from pyspark.ml.clustering import LDA
from pyspark.ml.feature import CountVectorizer

from preprocessing import preprocessing
import constants

# init Spark Context
conf = SparkConf().setAppName("Spark ML").setMaster("local[2]")
sc = SparkContext(conf=conf)
sqlContext = SQLContext(sc)

# read raw data
data = sqlContext.read.format("csv").options(header='true', inferSchema='true').load(os.path.realpath(constants.PATH))
rdd = data.rdd

# preprocessing data
tokens = preprocessing(rdd)
tokens = tokens.zipWithIndex()

df = sqlContext.createDataFrame(tokens, ["content", "index"])

# vector data
cv = CountVectorizer(inputCol="content", outputCol="features", vocabSize=500, minDF=3.0)
cvModel = cv.fit(df)
vectorizedToken = cvModel.transform(df)

# clustering
lda = LDA(k=constants.NUM_TOPICS, maxIter=constants.MAX_INTER)
model = lda.fit(vectorizedToken)

# ll = model.logLikelihood(vectorizedToken)
# lp = model.logPerplexity(vectorizedToken)
# print("The lower bound on the log likelihood of the entire corpus: " + str(ll))
# print("The upper bound on perplexity: " + str(lp))

# get vocab 
vocab = cvModel.vocabulary

topics = model.describeTopics()
topicsRdd = topics.rdd

# result 
result = model.transform(vectorizedToken)
result.show()

if(os.path.isdir(constants.OUTPUT_PATH + "/Model_CountVectorizer")):
    shutil.rmtree(constants.OUTPUT_PATH + "/Model_CountVectorizer")

cvModel.save(constants.OUTPUT_PATH + "/Model_CountVectorizer")

if(os.path.isdir(constants.OUTPUT_PATH + "/Model_LDA")):
    shutil.rmtree(constants.OUTPUT_PATH + "/Model_LDA")

model.save(constants.OUTPUT_PATH + "/Model_LDA")
