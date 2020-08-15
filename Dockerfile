FROM imazen/imageflow_server_unsecured:latest

ENV RUST_BACKTRACE=1

WORKDIR /home/imageflow
RUN mkdir -p /home/imageflow/data
RUN chown -R imageflow /home/imageflow/data
VOLUME ["/home/imageflow/data"]

COPY entry.sh .

EXPOSE 3000

ENTRYPOINT ["./entry.sh"]
