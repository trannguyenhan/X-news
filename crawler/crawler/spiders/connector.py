import mysql.connector
from crawler.spiders import constants

db = mysql.connector.connect(
    host=constants.HOST,
    user=constants.USER,
    password=constants.PASSWORD,
    database=constants.DATABASE,
    port=constants.PORT
)
cursor = db.cursor()

# get all website in database
def get_all_websites(): 
    cursor.execute("select * from websites")
    rows = cursor.fetchall()

    result = []
    for row in rows: 
        result.append(row)
    
    return result

# get all url categories of website
def get_categories(website_id):
    cursor.execute("select * from x_path_categories where website_id = " + str(website_id))
    rows = cursor.fetchall()

    result = []
    for row in rows: 
        result.append(row[2])
    
    return result

# get x_path of title, content of url website
def get_contents(website_id):
    cursor.execute("select * from x_path_contents where website_id = " + str(website_id))
    rows = cursor.fetchall()

    result = []
    for row in rows: 
        result.append({"title": row[2], "content": row[3], "date": row[4]})

    return result