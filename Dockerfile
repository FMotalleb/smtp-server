FROM ubuntu:latest

# Install required packages
RUN apt-get update && \
    apt-get install -y postfix dovecot-imapd dovecot-pop3d

# Copy Postfix main.cf configuration file
COPY postfix-main.cf /etc/postfix/main.cf

# Copy Dovecot configuration files
COPY dovecot.conf /etc/dovecot/dovecot.conf
COPY dovecot-sql.conf.ext /etc/dovecot/dovecot-sql.conf.ext

# Create a directory to store mail data
# RUN mkdir /var/mail

# Expose SMTP, POP3, and IMAP ports
EXPOSE 25 110 143 587 993

# Start the services
CMD ["sh", "-c", "service postfix start && service dovecot start && tail -f /var/log/mail.log"]
