package xnews.kafkaconsumer.properties;

import java.util.Properties;

public class KafkaProperties {
	/**
	 * Configuration parameter for kafka
	 * @return
	 */
	public static Properties getInstance() {
		Properties prop = new Properties();
		prop.put("bootstrap.servers", "localhost:9092");
		
		prop.setProperty("group.id", "test");
	    prop.setProperty("enable.auto.commit", "true");
	    prop.setProperty("auto.commit.interval.ms", "1000");

		prop.put("key.deserializer", "org.apache.kafka.common.serialization.StringDeserializer");
		prop.put("value.deserializer", "org.apache.kafka.common.serialization.StringDeserializer");
		
		return prop;
	}
}
