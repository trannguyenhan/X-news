package xnews.helper;

public class Helper {
	public static String normalizeHtmlToText(String html) {
		html = html.replaceAll("<[^>]*>", "");
		return html;
	}
}

