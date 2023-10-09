FROM imazen/imageflow_server_unsecured:latest

ENV RUST_BACKTRACE=1
ARG IMAGEFLOW_PORT=3000
ARG IMAGEFLOW_PATH_PREFIX=images/
ENV IMAGEFLOW_PORT ${IMAGEFLOW_PORT}
ENV IMAGEFLOW_PATH_PREFIX ${IMAGEFLOW_PATH_PREFIX}

WORKDIR /home/imageflow
RUN mkdir -p /home/imageflow/data
RUN chown -R imageflow /home/imageflow/data
VOLUME ["/home/imageflow/data"]

COPY entry.sh .

EXPOSE $IMAGEFLOW_PORT

ENTRYPOINT ["./entry.sh"]
