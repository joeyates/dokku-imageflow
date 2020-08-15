FROM imazen/imageflow_server_unsecured:latest

ENV RUST_BACKTRACE=1

COPY entry.sh .

EXPOSE 3000

ENTRYPOINT ["./entry.sh"]
