## Install: 

```
pip3 install scrapy
pip3 install bs4
pip3 install lxml
```

create new topic in kafka:

```bash
bin/kafka-topics.sh --create --partitions 1 --replication-factor 1 --topic x_news_1 --bootstrap-server localhost:9092
```

## Run

Run consumer kafka in package: `xnews.kafkaconsumer.consumer`.

`cd` to `crawler` folder and run command: 

```bash
scrapy crawl news
```


