# Define your item pipelines here
#
# Don't forget to add your pipeline to the ITEM_PIPELINES setting
# See: https://docs.scrapy.org/en/latest/topics/item-pipeline.html

# useful for handling different item types with a single interface
from itemadapter import ItemAdapter
from kafka import KafkaProducer
import json

class CrawlerPipeline:
    def open_spider(self, spider):
        self.producer = KafkaProducer(bootstrap_servers=['localhost:9092'], \
            value_serializer=lambda x: json.dumps(x, ensure_ascii=False).encode('utf-8'))
        self.topic = "x_news_1"

    def process_item(self, item, spider):
        line = ItemAdapter(item).asdict()
        self.producer.send(self.topic, value=line)
        return item
