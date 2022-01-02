package xnews.demo;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;

import xnews.helper.Helper;

public class Demo {
	public static void main(String[] args) throws IOException {
		BufferedReader reader = new BufferedReader(new FileReader("src/xnews/demo/test.txt"));
		String html = reader.readLine();
		
		html = Helper.normalizeHtmlToText(html);
		System.out.println(html);
	}
}
