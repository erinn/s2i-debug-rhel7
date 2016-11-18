
# debug-rhel7
FROM rhscl/s2i-base-rhel7

# Put the maintainer name in the image metadata
MAINTAINER Erinn Looney-Triggs <erinn.looneytriggs@gmail.com>

# Rename the builder environment variable to inform users about application you provide them
ENV DEBUG_VERSION 1.0

# Set labels used in OpenShift to describe the builder image
LABEL io.k8s.description="Platform for debugging" \
      io.k8s.display-name="Debug 1.0.0" \
      io.openshift.tags="debug"

# Install required packages here:
RUN yum -y update && yum install -y iproute iputils nmap nmap-ncat strace telnet  && yum clean all -y

# TODO (optional): Copy the builder files into /opt/app-root
# COPY ./<builder_folder>/ /opt/app-root/

# TODO: Copy the S2I scripts to /usr/libexec/s2i, since openshift/base-centos7 image sets io.openshift.s2i.scripts-url label that way, or update that label
COPY ./.s2i/bin/ /usr/libexec/s2i

# TODO: Drop the root user and make the content of /opt/app-root owned by user 1001
# RUN chown -R 1001:1001 /opt/app-root

# This default user is created in the openshift/base-rhel7 image
USER 1001

# TODO: Set the default port for applications built using this image
# EXPOSE 8080

# By default a NULL command just to keep the container running.
CMD ["usage"]
