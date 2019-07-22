FROM ubuntu
ADD ./omdb.sh /usr/src/omdb.sh
RUN chmod +x /usr/src/omdb.sh 
RUN apt update && apt install -y lynx 
CMD ["/usr/src/omdb.sh"]

