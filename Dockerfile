FROM debian:bookworm-slim
RUN apt-get update && apt-get install -y --no-install-recommends curl bzip2 ca-certificates && rm -rf /var/lib/apt/lists/*
RUN mkdir -p /opt/fah && curl -L -o /tmp/fah.tar.bz2 https://download.foldingathome.org/releases/public/fah-client/debian-stable-64bit/release/fah-client_8.1.18-64bit-release.tar.bz2 && tar -xjf /tmp/fah.tar.bz2 -C /opt/fah && rm /tmp/fah.tar.bz2 && chmod +x $(find /opt/fah -type f -name fah-client | head -n 1)
CMD ["/bin/sh", "-c", "exec $(find /opt/fah -type f -name fah-client | head -n 1) --user 9yo2bx9rs7z3 --team 234980 --cpus 2 --http-addresses 0.0.0.0:7396"]
