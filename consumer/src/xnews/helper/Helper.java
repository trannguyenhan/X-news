package xnews.helper;

public class Helper {
	public static String normalizeHtmlToText(String html) {
		html = html.replaceAll("<[^>]*>", "");
		
		html.replaceAll("\n", "");
		html.replaceAll("\r", "");
		while(html.contains("  ")) {
			html = html.replace("  ", " ");
		}
		return html;
	}
}

