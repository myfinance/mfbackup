FROM alpine:3.8

ENV PGHOST='mfdb'
ENV PGPORT='5432'
ENV PGDATABASE='marketdata'
ENV PGUSER='postgres'

RUN apk --update add postgresql-client && rm -rf /var/cache/apk/* && mkdir /var/dumps && chmod 755 /var/dumps

COPY dumpDatabase.sh .

ENTRYPOINT [ "/bin/sh" ]
CMD [ "./dumpDatabase.sh" ]