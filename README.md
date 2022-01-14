## Install

```
pip3 install scrapy
pip3 install bs4
pip3 install lxml
pip3 install pyspark
```

create new topic in kafka:

```bash
bin/kafka-topics.sh --create --partitions 1 --replication-factor 1 --topic x_news_1 --bootstrap-server localhost:9092
```

## Run

`cd` to `consumer` folder and run consumer kafka in package:
```
java -jar target/consumer-V1-jar-with-dependencies.jar 
```

`cd` to `crawler` folder and run command: 

```bash
scrapy crawl news
```

## Refer
- [https://github.com/trannguyenhan/tiki-data-analysis](https://github.com/trannguyenhan/tiki-data-analysis)
