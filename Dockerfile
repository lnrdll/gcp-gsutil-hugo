FROM alpine:latest

# Install dependencies
RUN apk add --update --no-cache \
    bash \
    ca-certificates \
    python \
    py-pip \
    py-cffi \
    py-cryptography \
    wget \
  && pip install --upgrade pip \
  && apk add --virtual build-deps \
    gcc \
    libffi-dev \
    python-dev \
    linux-headers \
    musl-dev \
    openssl-dev \
  && pip install gsutil \
  && apk del build-deps \
  && rm -rf /var/cache/apk/*

# Install Hugo
ENV HUGO_VERSION=0.62.0

RUN wget https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz
RUN tar -vxxzf hugo_${HUGO_VERSION}_Linux-64bit.tar.gz
RUN rm -f hugo_${HUGO_VERSION}_Linux-64bit.tar.gz
RUN mv hugo /usr/bin/hugo

CMD ["gsutil", "hugo"]
