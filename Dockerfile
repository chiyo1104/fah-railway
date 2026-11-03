FROM debian:bookworm-slim
RUN apt-get update && apt-get install -y --no-install-recommends curl bzip2 ca-certificates python3 python3-websocket && rm -rf /var/lib/apt/lists/*
RUN mkdir -p /opt/fah && curl -L -o /tmp/fah.tar.bz2 https://download.foldingathome.org/releases/public/fah-client/debian-stable-64bit/release/fah-client_8.1.18-64bit-release.tar.bz2 && tar -xjf /tmp/fah.tar.bz2 -C /opt/fah && rm /tmp/fah.tar.bz2 && chmod +x $(find /opt/fah -type f -name fah-client | head -n 1)
RUN curl -L -o /usr/local/bin/fahctl https://raw.githubusercontent.com/FoldingAtHome/fah-client-bastet/7c4363ae7981ece320047e26200fc244442a91bf/scripts/fahctl && chmod +x /usr/local/bin/fahctl
CMD ["/bin/sh", "-c", "FAH=$(find /opt/fah -type f -name fah-client | head -n 1); \"$FAH\" --user 9yo2bx9rs7z3 --team 234980 --cpus 2 --http-addresses 0.0.0.0:7396 & PID=$!; for i in 1 2 3 4 5 6 7 8 9 10; do sleep 3; python3 /usr/local/bin/fahctl fold && break; done; wait $PID"]
