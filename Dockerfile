FROM centos:7

LABEL maintainer="pavanreddykodathala15@gmail.com"

# Fix CentOS 7 repo issue by pointing to vault.centos.org
RUN cd /etc/yum.repos.d/ && \
    sed -i 's/mirrorlist/#mirrorlist/g' CentOS-* && \
    sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' CentOS-*

# Install required packages
RUN yum -y install java httpd zip unzip

# Set working directory to Apache's web root
WORKDIR /var/www/html/

# Copy the downloaded template zip into the container
COPY photogenic.zip .

# Unzip the template and clean up
RUN unzip photogenic.zip && \
    cp -rvf photogenic/* . && \
    rm -rf photogenic photogenic.zip

# Expose HTTP port
EXPOSE 80

# Start Apache in the foreground
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
