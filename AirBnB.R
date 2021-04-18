install.packages("naniar")
install.packages("convertr")
install.packages("caret")
install.packages("fastDummies")

# getting to know which directory I am in
getwd()

# clear environment
rm(list = ls())

# set working directory to save and load data from
setwd("~/scriptrepository")

# read data from csv into object named "hotels"
hotels <- read.csv("airbnb.csv")

# Save the object hotels into rds file named airbnb
saveRDS(hotels, file = "airbnb.rds")

## to save and restore data from and to rds file :
## http://www.sthda.com/english/wiki/saving-data-into-r-data-format-rds-and-rdata

# Restore it under a different name
hotels <- readRDS("airbnb.rds")

# display column names of dataframe - hotels
names(hotels)

# create new table named my_hotels_data with only 16 useful columns from hotels table
## https://dzone.com/articles/learn-r-how-create-data-frames

my_hotels_data <- data.frame(hotels$host_response_rate, hotels$host_acceptance_rate, hotels$host_is_superhost, hotels$host_listings_count, hotels$zipcode, hotels$property_type, hotels$room_type, hotels$accommodates, hotels$bathrooms, hotels$bedrooms, hotels$beds, hotels$price, hotels$number_of_reviews, hotels$review_scores_rating, hotels$cancellation_policy, hotels$reviews_per_month)
summary(my_hotels_data) # display summary
names(my_hotels_data)   # display column names
length(my_hotels_data$hotels.host_acceptance_rate) # display length of specific column
head(my_hotels_data) # display 6 row of all 16 columns

# count null in whole table
sum(is.na (my_hotels_data)) 

# display null value in each column
colSums(is.na(my_hotels_data)) 

# drop all rows with null value and save it into dataframe named b
b <- na.omit(my_hotels_data)
sum(is.na (b))
colSums(is.na(b)) 

# count the number of rows with N/A other not counted by null value
length(grep("N/A", b$hotels.host_response_rate))
length(grep("N/A", b$hotels.host_acceptance_rate))

#drop all rows with null value in host_response_rate column and save in into df named a
a <- b[- grep("N/A", b$hotels.host_acceptance_rate),]

#drop all rows with null value in host_acceptance_rate column and save in into df named my_clean_hotels
my_clean_hotels <- a[- grep("N/A", a$hotels.host_response_rate),]
summary(my_clean_hotels)

# find the percentage of rows dropped 
((nrow(my_hotels_data)-nrow(my_clean_hotels))/nrow(my_hotels_data))*100

# used to get the names of columns and types - to do the next 6 steps
str(my_clean_hotels)

# change interger type of host_response_rate, host_acceptance_rate and price to character type
my_clean_hotels$hotels.host_response_rate <- as.character(my_clean_hotels$hotels.host_response_rate)
my_clean_hotels$hotels.host_acceptance_rate <- as.character(my_clean_hotels$hotels.host_acceptance_rate)
my_clean_hotels$hotels.price <- as.character(my_clean_hotels$hotels.price)

# verify if they have changed successfully - to confirm open the dataframe from environment and check
typeof(my_clean_hotels$hotels.host_response_rate)
typeof(my_clean_hotels$hotels.price)
typeof(my_clean_hotels$hotels.host_acceptance_rate)

# remove % and $ from (host_response_rate, host_acceptance_rate) and (price) respectively and save them as double variable type
my_clean_hotels$hotels.host_response_rate <- as.numeric( gsub("%","",my_clean_hotels$hotels.host_response_rate) )
my_clean_hotels$hotels.host_acceptance_rate <- as.numeric( gsub("%","",my_clean_hotels$hotels.host_acceptance_rate) )
my_clean_hotels$hotels.price <- as.numeric (gsub("[$, ]","",my_clean_hotels$hotels.price))

# --------backing up my_clean_hotels - "backup" has host_is_superhost variable
backup <- my_clean_hotels
# --------backing up my_clean_hotels

# create column called superhost where if host_is_superhost is 't' then 1 or 'f' then 0
my_clean_hotels$hotels.superhost <- ifelse(my_clean_hotels$hotels.host_is_superhost=='t',1,0)
# delete the column "host_is_superhost"
my_clean_hotels$hotels.host_is_superhost <- NULL

# --------backing up my_clean_hotels - "backup2" has superhost as 0 and 1 variable
backup_2 <- my_clean_hotels
# --------backing up my_clean_hotels

#Trying from here -------------------
# install library for dummy variable function
library(fastDummies)
#create dummy variable for 4 catogorical columns - zipcode, property_type, room_type, cancellation_poicy
results2 <- fastDummies::dummy_cols(my_clean_hotels)
names(results2)

#delete the 2 columns with null value zipcode and property type - there were 4 occurences in zipcode
results2$hotels.zipcode_ <- NULL
results2$hotels.property_type_ <- NULL
names(results2)

# delete catagorical columns for which dummy variable is created
# the deleted for - zipcode, property type, room type, and cancellation policy
results2$hotels.zipcode <- NULL
results2$hotels.property_type <- NULL
results2$hotels.room_type <- NULL
results2$hotels.cancellation_policy <- NULL

histogram(results2$hotels.price)

install.packages("naniar")
install.packages("convertr")
install.packages("caret")
install.packages("fastDummies")

# getting to know which directory I am in
getwd()

# clear environment
rm(list = ls())

# set working directory to save and load data from
setwd("~/rscripts")

# read data from csv into object named "hotels"
hotels <- read.csv("airbnb.csv")

# Save the object hotels into rds file named airbnb
saveRDS(hotels, file = "airbnb.rds")

## to save and restore data from and to rds file :
## http://www.sthda.com/english/wiki/saving-data-into-r-data-format-rds-and-rdata

# Restore it under a different name
hotels <- readRDS("airbnb.rds")

# display column names of dataframe - hotels
names(hotels)

# create new table named my_hotels_data with only 16 useful columns from hotels table
## https://dzone.com/articles/learn-r-how-create-data-frames

my_hotels_data <- data.frame(hotels$host_response_rate, hotels$host_acceptance_rate, hotels$host_is_superhost, hotels$host_listings_count, hotels$zipcode, hotels$property_type, hotels$room_type, hotels$accommodates, hotels$bathrooms, hotels$bedrooms, hotels$beds, hotels$price, hotels$number_of_reviews, hotels$review_scores_rating, hotels$cancellation_policy, hotels$reviews_per_month)
summary(my_hotels_data) # display summary
names(my_hotels_data)   # display column names
length(my_hotels_data$hotels.host_acceptance_rate) # display length of specific column
head(my_hotels_data) # display 6 row of all 16 columns

# count null in whole table
sum(is.na (my_hotels_data)) 

# display null value in each column
colSums(is.na(my_hotels_data)) 

# drop all rows with null value and save it into dataframe named b
b <- na.omit(my_hotels_data)
sum(is.na (b))
colSums(is.na(b)) 

# count the number of rows with N/A other not counted by null value
length(grep("N/A", b$hotels.host_response_rate))
length(grep("N/A", b$hotels.host_acceptance_rate))

#drop all rows with null value in host_response_rate column and save in into df named a
a <- b[- grep("N/A", b$hotels.host_acceptance_rate),]

#drop all rows with null value in host_acceptance_rate column and save in into df named my_clean_hotels
my_clean_hotels <- a[- grep("N/A", a$hotels.host_response_rate),]
summary(my_clean_hotels)

# find the percentage of rows dropped 
((nrow(my_hotels_data)-nrow(my_clean_hotels))/nrow(my_hotels_data))*100

# used to get the names of columns and types - to do the next 6 steps
str(my_clean_hotels)

# change interger type of host_response_rate, host_acceptance_rate and price to character type
my_clean_hotels$hotels.host_response_rate <- as.character(my_clean_hotels$hotels.host_response_rate)
my_clean_hotels$hotels.host_acceptance_rate <- as.character(my_clean_hotels$hotels.host_acceptance_rate)
my_clean_hotels$hotels.price <- as.character(my_clean_hotels$hotels.price)

# verify if they have changed successfully - to confirm open the dataframe from environment and check
typeof(my_clean_hotels$hotels.host_response_rate)
typeof(my_clean_hotels$hotels.price)
typeof(my_clean_hotels$hotels.host_acceptance_rate)

# remove % and $ from (host_response_rate, host_acceptance_rate) and (price) respectively and save them as double variable type
my_clean_hotels$hotels.host_response_rate <- as.numeric( gsub("%","",my_clean_hotels$hotels.host_response_rate) )
my_clean_hotels$hotels.host_acceptance_rate <- as.numeric( gsub("%","",my_clean_hotels$hotels.host_acceptance_rate) )
my_clean_hotels$hotels.price <- as.numeric (gsub("[$, ]","",my_clean_hotels$hotels.price))

# --------backing up my_clean_hotels - "backup" has host_is_superhost variable
backup <- my_clean_hotels
# --------backing up my_clean_hotels

# create column called superhost where if host_is_superhost is 't' then 1 or 'f' then 0
my_clean_hotels$hotels.superhost <- ifelse(my_clean_hotels$hotels.host_is_superhost=='t',1,0)
# delete the column "host_is_superhost"
my_clean_hotels$hotels.host_is_superhost <- NULL

# --------backing up my_clean_hotels - "backup2" has superhost as 0 and 1 variable
backup_2 <- my_clean_hotels
# --------backing up my_clean_hotels

#Trying from here -------------------
# install library for dummy variable function
library(fastDummies)
#create dummy variable for 4 catogorical columns - zipcode, property_type, room_type, cancellation_poicy
results2 <- fastDummies::dummy_cols(my_clean_hotels)
names(results2)

#delete the 2 columns with null value zipcode and property type - there were 4 occurences in zipcode
results2$hotels.zipcode_ <- NULL
results2$hotels.property_type_ <- NULL
names(results2)

# delete catagorical columns for which dummy variable is created
# the deleted for - zipcode, property type, room type, and cancellation policy
results2$hotels.zipcode <- NULL
results2$hotels.property_type <- NULL
results2$hotels.room_type <- NULL
results2$hotels.cancellation_policy <- NULL

# trying from here --------------
hist(results2$hotels.price,
     main="Hotel Prices",
     xlab="Listing Prices in $",
     xlim=c(0,500),
     col="darkmagenta",
     freq=FALSE
)