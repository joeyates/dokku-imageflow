FROM imazen/imageflow_server_unsecured:latest

ENV RUST_BACKTRACE=1
ARG IMAGEFLOW_PORT=3000
ENV IMAGEFLOW_PORT ${IMAGEFLOW_PORT}

WORKDIR /home/imageflow
RUN mkdir -p /home/imageflow/data
RUN chown -R imageflow /home/imageflow/data
VOLUME ["/home/imageflow/data"]

COPY entry.sh .

EXPOSE $IMAGEFLOW_PORT

ENTRYPOINT ["./entry.sh"]
