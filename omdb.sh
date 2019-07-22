#!/bin/bash
# 
#Program to get Rotten Tomatoes rate for a given movie's title by OMDb API,http://www.omdbapi.com/ 

#Initializing API KEY
APIKEY="f7b2d98f"

# rm old workfiles

if test -f .OMDB_search.txt; then
rm .OMDB_search.txt
echo "Previous search removed"
fi

#Search for movie's title in database (either complete title or title thet includes the given word)

echo "Please enter movie's title: " 
read TITLE 
lynx --dump "http://www.omdbapi.com/?apikey=$APIKEY&t=$TITLE" > .OMDB_search.txt
Title_OMDB=$(awk -F "Title\":\""  '{print $2}' .OMDB_search.txt | cut -d'"' -f 1)
Released=$(awk -F "Released\":\""  '{print $2}' .OMDB_search.txt | cut -d'"' -f 1)
Response=$(awk -F "Response\":\""  '{print $2}' .OMDB_search.txt | cut -d'"' -f 1)

#if movie is present in OMDB, reporting Title, released date and Rotten Tomatoes rate, if present

if [ "$Response" = "True" ]; then
echo "Movie found"
echo "Title on OMDB:" "$Title_OMDB" 
echo "Released date:" "$Released" 
Rate_R_T=$(awk -F "Rotten Tomatoes\",\"Value\":\""  '{print $2}' .OMDB_search.txt | cut -d'%' -f 1)
if [ -z "$Rate_R_T" ]; then
echo "Rotten Tomatoes Rate is not present" 
else
echo "Rotten Tomatoes Rate is" "$Rate_R_T""%"
fi
# if movie is not present, reporting "Movie not found" 
else
echo "Movie not found"
fi
#rm workfile
rm .OMDB_search.txt
