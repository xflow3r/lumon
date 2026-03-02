FROM ubuntu:22.04@sha256:075680e983398fda61b1ac59ad733ad81d18df4bc46411666bb8a03fb9ea0195

ADD --chmod=0755 --checksum=sha256:c125df9762b0c7233459087bb840c0e5dbfc4d9690ee227f1ed8994f4d51d2e0 \
    https://raw.githubusercontent.com/reproducible-containers/repro-sources-list.sh/v0.1.4/repro-sources-list.sh \
    /usr/local/bin/repro-sources-list.sh
RUN repro-sources-list.sh

RUN apt-get update && apt -y install socat
WORKDIR /app
COPY share/MDR MDR
COPY run.sh run.sh

RUN useradd -m ctf
USER ctf
EXPOSE 5000
CMD ["socat", "TCP-LISTEN:5000,reuseaddr,fork", "EXEC:'timeout 60 /app/run.sh',pty,stderr,setsid,sane"]

