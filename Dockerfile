FROM centos:7
LABEL maintainer="pavanreddykodathala15@gmail.com"

# Fix CentOS repos for older version
RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-* && \
    sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*

# Install required packages
RUN yum -y install java httpd zip unzip curl && yum clean all

# Set working directory
WORKDIR /var/www/html/

# Download the photogenic.zip template inside the container
RUN curl -O https://www.free-css.com/assets/files/free-css-templates/download/page254/photogenic.zip

# Unzip and copy files to current directory, then cleanup
RUN unzip photogenic.zip && \
    cp -rvf photogenic/* . && \
    rm -rf photogenic photogenic.zip

# Expose port 80 for HTTP
EXPOSE 80

# Start Apache HTTP server in foreground
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
