USE master
GO

--drop database if it exists
IF DB_ID('final_capstone') IS NOT NULL
BEGIN
	ALTER DATABASE final_capstone SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE final_capstone;
END

CREATE DATABASE final_capstone
GO

USE final_capstone
GO

--create tables
CREATE TABLE users (
	user_id int IDENTITY(1,1) NOT NULL,
	username varchar(50) NOT NULL,
	password_hash varchar(200) NOT NULL,
	salt varchar(200) NOT NULL,
	user_role varchar(50) NOT NULL
	CONSTRAINT PK_user PRIMARY KEY (user_id)
)

--populate default data
INSERT INTO users (username, password_hash, salt, user_role) VALUES ('user','Jg45HuwT7PZkfuKTz6IB90CtWY4=','LHxP4Xh7bN0=','user');
INSERT INTO users (username, password_hash, salt, user_role) VALUES ('admin','YhyGVQ+Ch69n4JMBncM4lNF/i9s=', 'Ar/aB2thQTI=','admin');

GO

Create Table BreweryAddress
(
	addressId int Identity(1000, 1) not null,
	streetAddress varchar(255) not null,
	city varchar(255) not null,
	stateOrTerritory varchar(255) not null,
	country varchar(255) not null,
	postalCode varchar(25) null

	constraint pk_addressId primary key (addressId)
);

Create Table Brewery
(
	breweryId int Identity(1000, 1) not null,
	breweryName varchar(500) not null,
	breweryAddressId int not null,
	phoneNumber varchar(14) not null,
	website varchar(5000) not null,
	dateEstablished varchar(4) not null,
	history varchar(8000)

	constraint pk_breweryId primary key (breweryId),
	constraint fk_addressId foreign key (breweryAddressId) references BreweryAddress(addressId)
);

Create Table Beer
(
	beerId int Identity(1000, 1) not null,
	beerName varchar(300) not null,
	beerType varchar(100) not null,
	abv decimal not null,
	beerDescription varchar(1000),
	beerBreweryId int not null,
	seasonal varchar(50)

	constraint pk_beerId primary key (beerId),
	constraint fk_beerBreweryId foreign key (beerBreweryId) references Brewery(breweryId)
);

Create Table UserBrewery 
(
	userBrewery int Identity(100, 1) not null,
	userId int not null,
	breweryId int not null

	constraint pk_userBrewery primary key (userBrewery),
	constraint fk_userId foreign key (userId) references users(user_id),
	constraint fk_breweryId foreign key (breweryId) references Brewery(breweryId)
);

Create Table UserReviews
(
	reviewBeerId int Identity (1, 1) not null,
	userId int not null,
	beerId int not null,
	rating decimal not null,
	reviewBody varchar (6000),

	constraint pk_reviewBeerId primary key (reviewBeerId),
	constraint fk_userIdRate foreign key (userId) references users(user_id),
	constraint fk_beerIdRate foreign key (beerId) references Beer(beerId),
	constraint chk_rating check (rating>=0.0 and rating<=5.0)
);

INSERT INTO dbo.BreweryAddress 
(streetAddress, city, stateOrTerritory, country, postalCode)
VALUES
('2885 Detroit Ave', 'Cleveland', 'OH', 'USA', '44113'),
('7524 Father Frascati', 'Cleveland', 'OH', 'USA', '44102')

INSERT INTO dbo.Brewery
(breweryName, breweryAddressId, phoneNumber, website, dateEstablished, history)
VALUES
('Saucy Brew Works', (SELECT addressId FROM dbo.BreweryAddress WHERE BreweryAddress.streetAddress = '2885 Detroit Ave' AND BreweryAddress.postalCode = '44113'), '(216) 666-2568', 'https://www.saucybrewworks.com/cleveland-brewpub/', '2017', 'For Saucy Brew Works, respect for community means being responsible with our resources. The brewery�s systems reduce water use and pre-treat wastewater. Fresh Fork Market uses our spent grains to feed their animals. We in turn will buy their meat � and the world goes round. Respect also means supporting education. Not only about the world of beer, but educating the next generation of bright minds. That�s why we support Breakthrough Schools, a top performing charter school network in our community that takes a different approach to education. Just like we take a different approach to beer.'),
('Terrestrial Brewing Company', (SELECT addressId FROM dbo.BreweryAddress WHERE BreweryAddress.streetAddress = '7524 Father Frascati' AND BreweryAddress.postalCode = '44102'), '(216) 465-9999', 'https://www.facebook.com/terrestrialbrewing/', 'unkn', 'Small-batch brewery boasting unique beers and amazing views of Lake Erie in the Battery Park neighborhood. Owners: Ryan Bennett, Ralph Sgro. Head Brewer: Ralph Sgro')


INSERT INTO dbo.Beer
(beerName, beerType, abv, beerDescription, beerBreweryId, seasonal)
VALUES
('Habituale', 'Kolsch Style Golden Ale', 5.0, 'Light, clean, crisp with a slight citrusy spicy character.', (SELECT breweryId FROM dbo.Brewery WHERE brewery.breweryName = 'Saucy Brew Works' AND brewery.phoneNumber = '(216) 666-2568'), 'no'),
('Juicy ASAP', 'American IPA', 6.5, 'Tropical, citrusy, and most certainly juicy.', (SELECT breweryId FROM dbo.Brewery WHERE brewery.breweryName = 'Saucy Brew Works' AND brewery.phoneNumber = '(216) 666-2568'), 'no'),
('Space Chimp Wit OG', 'Wheat Beer - Witbier', 5.0, 'Our original gangester, Space Chimp Wit, brewed with bitter orange and coriander.', (SELECT breweryId FROM dbo.Brewery WHERE brewery.breweryName = 'Terrestrial Brewing Company' AND brewery.phoneNumber = '(216) 465-9999'), 'no'),
('Evenstar', 'American IPA', 7.4, 'A West Coast Style IPA brewed with Simcoe, Nugget, Centennial and Citra hops. Dry and resinous with a fruity and bitter finish.', (SELECT breweryId FROM dbo.Brewery WHERE brewery.breweryName = 'Terrestrial Brewing Company' AND brewery.phoneNumber = '(216) 465-9999'), 'no')

INSERT INTO dbo.UserReviews
(userId, beerId, rating, reviewBody)
VALUES
(1, 1000, 4.2, 'Habituale is a solid kolsch. It pours a chill hazed pale straw with a decent head of white foam that settles to a thick fine beaded ring and a thin dusty layer with light lacing. Nose of cracker, light breaded malts, and honey sweet malts with a touch of pear and grape notes. Flavors follow the nose with honey touched malts with breaded malts and a touch of dry cracker with some pear crispness amongst a touch of herbal hops. Nice mouth feel; medium light body, medium light carbonation, smooth, and lightly crisp with a subtle dryness on the rear. Overall, a SOLID brew from a new to me brewery.'),
(1, 1001, 4.8, 'I got a can of this beer off the single shelf from my local Giant Eagle store. It poured a clear golden with white head that is leaving some lace. The scent had dank citrus notes. The taste was nicely balanced and easy to drink with tropical fruit peel flavors. The mouthfeel was medium in body with good carbonation. Overall it is a solid beer.'),
(1, 1002, 3.9, 'Very traditional Belgian-style wheat with a great flavor profile. Good balance of clove and banana yeasty flavors. Well balanced overall, not too sweet. Well crafted!'),
(1, 1003, 4.5, 'Oooooowoooooooo hops. Holy cow. This checks all the boxes in what I expect from an IPA. Wowee. Bitterness and aftertaste hit you after. Good stuff. Yep.')

SELECT * FROM dbo.BreweryAddress

SELECT * FROM dbo.Brewery

SELECT * FROM dbo.Beer



/* BREAK GLASS IN CASE OF EMERGENCY: */

/*
DELETE FROM dbo.BreweryAddress
DELETE FROM dbo.Brewery
DELETE FROM dbo.Beer
DELETE FROM dbo.UserBrewery
DROP TABLE dbo.BreweryAddress
DROP TABLE dbo.Brewery
DROP TABLE dbo.Beer
DROP TABLE dbo.UserBrewery

*/

SELECT * FROM users
SELECT * FROM beer
