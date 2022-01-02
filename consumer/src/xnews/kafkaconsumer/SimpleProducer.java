package xnews.kafkaconsumer;

import java.time.Duration;
import java.util.Arrays;

import org.apache.kafka.clients.consumer.Consumer;
import org.apache.kafka.clients.consumer.ConsumerRecord;
import org.apache.kafka.clients.consumer.ConsumerRecords;
import org.apache.kafka.clients.consumer.KafkaConsumer;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import xnews.helper.Helper;
import xnews.kafkaconsumer.properties.KafkaProperties;

public class SimpleProducer {
	public static void main(String[] args) throws ParseException {
		JSONParser parser = new JSONParser();
		Consumer<String, String> consumer = new KafkaConsumer<String, String>(KafkaProperties.getInstance());
		
		consumer.subscribe(Arrays.asList("x_news_1"));
		while(true) {
			ConsumerRecords<String, String> records = consumer.poll(Duration.ofMillis(100));
			
			for(ConsumerRecord<String, String> record: records) {
				JSONObject jsonObject = (JSONObject) parser.parse(record.value());
				String title = (String) jsonObject.get("title");
				String content = (String) jsonObject.get("content");
				String date = (String) jsonObject.get("date");
				
				content = Helper.normalizeHtmlToText(content);
				
				System.out.println(content);
			}
		}
	}
}
