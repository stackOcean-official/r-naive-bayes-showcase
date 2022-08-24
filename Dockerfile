FROM ubuntu:jammy

ENV LC_ALL C.UTF-8
ENV LANG C.UTF-8

## This was not needed before but we need it now
ENV DEBIAN_FRONTEND noninteractive

## Otherwise timedatectl will get called which leads to 'no systemd' inside Docker
ENV TZ UTC+2

WORKDIR /app

RUN apt update
RUN apt-get install -y -qq r-base
# && apt-get install -y libxml2-dev

# Install binaries (see https://datawookie.netlify.com/blog/2019/01/docker-images-for-r-r-base-versus-r-apt/)
COPY ./requirements-bin.txt .
RUN cat requirements-bin.txt | xargs apt-get install -y -qq

# Install remaining packages from source
COPY ./requirements-src.R .
RUN Rscript requirements-src.R

# Clean up package registry
RUN rm -rf /var/lib/apt/lists/*

ADD model model
ADD src src
ADD data data

EXPOSE 8000

# CMD ["R"]
CMD Rscript src/predict.R