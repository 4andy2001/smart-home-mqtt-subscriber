*** Build ***
# Note that app/smart-home-mqtt-subd.py has a variable use_client_certificate which should be set
# to True (if using TLS) or False (if not using TLS).
$ docker build -t smart-home-mqtt-subd-tls .

*** Testing ***
# Remove running version if present
$ docker rm --force smart-home-mqtt-subd-tls
# Run 
$ docker run -d -p 12345:12345 --name smart-home-mqtt-subd-tls smart-home-mqtt-subd-tls
# Log with tailing
$ docker logs -f smart-home-mqtt-subd-tls

# Use mosquitto_sub to verify the client is publishing 
$ mosquitto_sub -h enodigm.com -p 8883 -u  weather -P hot_as_hell2  --cafile /etc/ssl/certs/m2mqtt_ca.crt -t /sensor/temperature/hallway -t /sensor/humidity/hallway -t /sensor/pressure/hallway -t /sensor/time/hallway
