package xnews.sparkstreaming;

import java.util.Arrays;
import java.util.Collection;

import org.apache.spark.SparkConf;
import org.apache.spark.streaming.Durations;
import org.apache.spark.streaming.api.java.JavaStreamingContext;

import xnews.helper.Constants;

public class StreamingConsumer {
	public static void main(String[] args) throws InterruptedException {
		SparkConf conf = new SparkConf().setMaster("local").setAppName("Spark Streaming Consumer");
		JavaStreamingContext jssc = new JavaStreamingContext(conf, Durations.seconds(1));
		
		// Define a list of Kafka topic to subscribe
		Collection<String> topics = Arrays.asList(Constants.TOPIC);
		
		// Start the computation
        jssc.start();
        jssc.awaitTermination();
	}
}
