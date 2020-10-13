FROM debian-security-apt-cacher-ng:latest
COPY systemd/ /etc/systemd/system/
COPY setup/ /usr/local/debian-base-setup/
RUN /usr/local/debian-base-setup/040-shinobi-tensorflow-jetson
EXPOSE 8082
CMD ["/usr/local/bin/boot-debian-base"]
