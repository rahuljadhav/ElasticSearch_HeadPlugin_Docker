FROM java:7

WORKDIR /opt

RUN wget https://download.elastic.co/elasticsearch/release/org/elasticsearch/distribution/tar/elasticsearch/2.3.3/elasticsearch-2.3.3.tar.gz

RUN tar zxf elasticsearch-2.3.3.tar.gz

RUN rm elasticsearch-2.3.3.tar.gz

WORKDIR /opt/elasticsearch-2.3.3


RUN ./bin/plugin -install elasticsearch/elasticsearch-cloud-aws/2.7.1 --silent --timeout 2m
RUN ./bin/plugin -install lukas-vlcek/bigdesk --silent --timeout 2m
RUN ./bin/plugin -install mobz/elasticsearch-head --silent --timeout 2m

# Expose volumes
VOLUME [/opt/elasticsearch-2.3.3/data]


# Listen for 9200/tcp (HTTP) and 9300/tcp (cluster)
EXPOSE 9200 9300

ADD bin /opt/bin

RUN chmod +x /opt/bin/*.sh

WORKDIR /opt

CMD ["./bin/elasticsearch.sh"]
