FROM memoryleak/php:7.3-composer
COPY ssh /root/.ssh
COPY git-credentials /root/.git-credentials
RUN mkdir -p /root/.ssh && \
	chown -R root:root /root/.git-credentials && \
	chmod 600 /root/.git-credentials && \
	chown -R root:root /root/.ssh && \
	chmod 700 /root/.ssh && \
	chmod -R 600 /root/.ssh/* && \
	chmod -R 644 /root/.ssh/*.pub && \
	chmod -R 644 /root/.ssh/config
