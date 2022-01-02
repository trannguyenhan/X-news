create database x_news;
use x_news;

create table websites(
	id int unsigned auto_increment not null primary key,
    domain varchar(255),
    category json
);

create table x_path_categories(
	id int unsigned auto_increment not null primary key,
    website_id int unsigned,
    x_path varchar(500),
    foreign key (website_id) references websites(id)
);

create table x_path_contents(
	id int unsigned auto_increment not null primary key,
    website_id int unsigned, 
    x_path_title varchar(500),
    x_path_content varchar(500),
    x_path_date varchar(500),
    foreign key (website_id) references websites(id)
);


