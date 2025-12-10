############################################################
# Dockerfile to build smart-home-mqtt-subd
############################################################

# Set the base image
FROM debian:bullseye-slim


# File Author / Maintainer
LABEL image.author="andy.shepard@runbox.com"

RUN apt-get update && apt-get install -y python3 \
    python3-pip mosquitto-clients iputils-ping  \
    && apt-get clean \
    && apt-get autoremove \
    && rm -rf /var/lib/apt/lists/*


# Copy over and install the requirements
RUN mkdir -p /etc/ssl/certs
COPY ./requirements.txt .
COPY ./app/smart-home-mqtt-subd.py /usr/local/sbin/
COPY ./app/credentials.py /usr/local/sbin/
COPY ./app/certs/m2mqtt_ca.crt /etc/ssl/certs/

RUN pip install -r ./requirements.txt

# WORKDIR /var/www/smart-home

CMD ["python3", "-u", "/usr/local/sbin/smart-home-mqtt-subd.py"]
