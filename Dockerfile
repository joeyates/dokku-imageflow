FROM imazen/imageflow_server_unsecured:latest

ENV RUST_BACKTRACE=1

EXPOSE 3000

ENTRYPOINT '/bin/sh -c "sudo chown -R imageflow /home/imageflow/ && /home/imageflow/imageflow_server start --bind-address 0.0.0.0 --port 3000 --data-dir /home/imageflow/data/ --mount /images/:static:/home/imageflow/images/'
