# Use Alpine Linux as the base image
FROM alpine:latest

RUN apk update && apk add bash git openssh openssl rsyslog tzdata \
    gcc musl-dev python3 py3-pip

# Generate a random password for the root user (you can change this)
RUN PASSWORD=$(openssl rand -base64 12) && echo "root:${PASSWORD}" | chpasswd

# Set the timezone to America/Sao_Paulo
RUN ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
RUN echo "America/Sao_Paulo" > /etc/timezone

# Generate SSH host keys
RUN ssh-keygen -A

# Copy the public key into the container
COPY ssh/id_rsa.pub /root/.ssh/authorized_keys
RUN chown root:root /root/.ssh/authorized_keys
RUN chmod 600 /root/.ssh/authorized_keys

# Configure SSH to allow key-based authentication and disable password authentication
RUN sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config && \
    sed -i 's/PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config

# Configure rsyslog to capture logs
RUN sed -i '/imklog/s/^/#/' /etc/rsyslog.conf # Disable kernel logs to avoid conflicts
RUN echo "auth,authpriv.* |/var/log/auth.log" >> /etc/rsyslog.conf
RUN echo "cron.* |/var/log/cron.log" >> /etc/rsyslog.conf

RUN touch /var/log/auth.log

# Copy the requirements file and install dependencies
COPY requirements.txt .
RUN pip3 install -r requirements.txt

WORKDIR /root/pdf_keyword_writer

RUN echo "git config --global --add safe.directory /root/pdf_keyword_writer" >> /root/.profile
RUN echo "test ! -f ~/pdf_keyword_writer/pdf_keyword_writer/conf/keywords.yaml && cp ~/pdf_keyword_writer/pdf_keyword_writer/conf/sample_keywords.yaml ~/pdf_keyword_writer/pdf_keyword_writer/conf/keywords.yaml" >> /root/.profile
RUN chmod 600 /root/.profile

# Expose SSH port
EXPOSE 22

# Start SSH server and rsyslog
CMD ["sh", "-c", "/usr/sbin/sshd && rsyslogd -n"]
