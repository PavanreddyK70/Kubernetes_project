# Use CentOS 7 base image
FROM centos:7

# Set environment variables for non-interactive installation
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

# Update the system and install required packages
RUN yum -y update && \
    yum -y install epel-release && \
    yum -y install httpd java-1.8.0-openjdk zip unzip && \
    yum clean all

# Expose HTTP port 80
EXPOSE 80

# Copy your web content if needed (optional)
# COPY ./your-website/ /var/www/html/

# Start Apache HTTP server in the foreground when container runs
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
