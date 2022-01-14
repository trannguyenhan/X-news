package xnews.kafkaconsumer;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.net.URISyntaxException;
import java.time.Duration;
import java.util.Arrays;

import org.apache.kafka.clients.consumer.Consumer;
import org.apache.kafka.clients.consumer.ConsumerRecord;
import org.apache.kafka.clients.consumer.ConsumerRecords;
import org.apache.kafka.clients.consumer.KafkaConsumer;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import com.opencsv.CSVWriter;

import xnews.helper.Helper;
import xnews.kafkaconsumer.properties.KafkaProperties;

public class SimpleProducer {
	public static void main(String[] args) throws ParseException, IOException, URISyntaxException {
		
		// initialize json parser and kafka consumer
		JSONParser parser = new JSONParser();
		Consumer<String, String> consumer = new KafkaConsumer<String, String>(KafkaProperties.getInstance());
		
		// initialize consumer and read data from topic of kafka
		// topic: x_news_1
		consumer.subscribe(Arrays.asList("x_news_1"));
		try {
			while(true) {
				ConsumerRecords<String, String> records = consumer.poll(Duration.ofMillis(100));
				
				if(records.count() != 0) {
					// initialize writer
					String fileName = "csv" + "-" + System.currentTimeMillis() + ".csv";
					FileWriter fileWriter = new FileWriter(new File("tmpdata/" + fileName));
					CSVWriter csvWriter = new CSVWriter(fileWriter);
					String[] header = {"Title", "Content", "Date"};
					csvWriter.writeNext(header);
					
					
					for(ConsumerRecord<String, String> record: records) {
						JSONObject jsonObject = (JSONObject) parser.parse(record.value());
						String title = (String) jsonObject.get("title");
						String content = (String) jsonObject.get("content");
						String date = (String) jsonObject.get("date");
						
						content = Helper.normalizeHtmlToText(content);				
						
						String[] line = {title, content, date};
						csvWriter.writeNext(line);
						
						System.out.println(content);
					}
					
					csvWriter.close();
				}
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
