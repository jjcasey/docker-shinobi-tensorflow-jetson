FROM nvcr.io/nvidia/l4t-base:r32.3.1
COPY preinit/ /usr/local/preinit/
COPY setup/ /usr/local/debian-base-setup/
COPY files/ /usr/local/debian-base-setup/files/
COPY scripts/ /usr/local/bin/
COPY systemd/ /etc/systemd/system/
RUN echo '* libraries/restart-without-asking boolean true' | debconf-set-selections
RUN echo 'Acquire::http { Proxy "http://apt-cacher-ng:3142"; };' >> /etc/apt/apt.conf.d/01proxy
RUN echo 'en-US.UTF8' > /var/lib/locales/supported.d/en
RUN echo 'exit 101' > /usr/sbin/policy-rc.d
RUN chmod a+x /usr/sbin/policy-rc.d
RUN /usr/local/debian-base-setup/010-debian-base-minimal
RUN systemctl mask console-getty.service
RUN systemctl mask wpa_supplicant.service
RUN systemctl mask networkd-dispatcher.service
RUN systemctl mask isc-dhcp-server.service
RUN systemctl mask isc-dhcp-server6.service
RUN /usr/local/debian-base-setup/020-debian-base-standard
RUN /usr/local/debian-base-setup/030-debian-base-security
COPY debian-base-security.conf /etc/needrestart/conf.d/
RUN /usr/local/debian-base-setup/040-shinobi-tensorflow-jetson
EXPOSE 8082
CMD ["/usr/local/bin/boot-debian-base"]
