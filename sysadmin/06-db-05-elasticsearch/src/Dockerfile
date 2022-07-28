FROM elasticsearch:7.17.5
COPY --chown=elasticsearch:elasticsearch elasticsearch.yml /usr/share/elasticsearch/config/
RUN chown -R elasticsearch:elasticsearch /var/lib
RUN mkdir "/snapshots"
RUN chown -R elasticsearch:elasticsearch /snapshots

