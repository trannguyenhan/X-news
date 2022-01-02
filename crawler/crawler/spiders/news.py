import scrapy
from crawler.items import CrawlerItem
from crawler.spiders.connector import get_contents, get_all_websites, get_categories
import json

class NewsSpider(scrapy.Spider):
    name = 'news'
    # allowed_domains = ['news.vn']
    # start_urls = ['http://news.vn/']

    def start_requests(self):
        list_websites = get_all_websites()
        for website in list_websites: 
            domain = website[1] # get domain of website: https://vietnamnet.vn
            categories = json.loads(website[2]) # get list category of website: /thoi-su, /chinh-tri
            
            for category in categories: 
                link = domain + category
                yield scrapy.Request(url=link, callback=self.parse_links, meta={"website_id": website[0], "domain": website[1]})

    def parse_links(self, response):
        result = set()

        x_path_categories = get_categories(response.meta.get("website_id"))
        for x_path_category in x_path_categories: 
            x_path = x_path_category + "//a/@href" # get all tag a, after get all attribute href contain link of post in website news
            list_href = response.xpath(x_path).extract()
            
            for href in list_href: 
                if len(href) > 50 and ("http" not in href): # link have less than 50 character maybe not is link of post
                    result.add(response.meta.get("domain") + href)

        for item in result: 
            yield scrapy.Request(url=item, callback=self.parse, meta={"website_id": response.meta.get("website_id")})

    def parse(self, response):        
        posts = get_contents(response.meta.get("website_id"))
        for post in posts: 
            content = response.xpath(post["content"] + "").extract_first()
            title = response.xpath(post["title"] + "//text()").extract_first()
            date = response.xpath(post["date"] + "//text()").extract_first()
            
            content = self.normalize(content)
            title = self.normalize(title)
            date = self.normalize(date)
            
            crawlerItem = CrawlerItem()
            crawlerItem['content'] = content
            crawlerItem['title'] = title
            crawlerItem['date'] = date

            yield crawlerItem
    
    # normalize string
    def normalize(self, s):
        if s == None: 
            return ""

        while "  " in s: 
            s = s.replace("  ", " ")

        while "\r" in s: 
            s = s.replace("\r", "")
        
        while "\n" in s: 
            s = s.replace("\n", "")

        # s = s.encode('utf-8')
        return s