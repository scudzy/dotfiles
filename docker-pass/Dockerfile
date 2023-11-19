# Use a base image (e.g., Alpine Linux)
FROM alpine:latest

# Install pass and GPG
RUN apk add git pass gnupg curl

# Copy your password store archive into the container
COPY pass-archive.tar.gz /tmp/pass-archive.tar.gz

# Extract your password store archive
RUN tar -zxvf /tmp/pass-archive.tar.gz -C /root/

# Set the password store environment variable
ENV PASSWORD_STORE_DIR=/root/

# Expose the password store for use
VOLUME /root/.password-store

# Define the default command (e.g., to run a shell)
CMD ["/bin/sh"]
