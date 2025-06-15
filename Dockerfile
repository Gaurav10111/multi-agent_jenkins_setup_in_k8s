#Use Red Hat UBI8 base image
FROM redhat/ubi8

# Set environment variable for Jenkins home
ENV JENKINS_HOME=/var/jenkins_home

#Install Java and necessary tools
RUN dnf -y update && \
dnf -y install java-17-openjdk wget curl fontconfig && \
dnf clean all

#Create Jenkins home directory
RUN mkdir -p $JENKINS_HOME && \
useradd -m-d $JENKINS_HOME -s /bin/bash jenkins && \
chown -R jenkins: jenkins $JENKINS_HOME

# Download Jenkins WAR
RUN wget https://get.jenkins.io/war-stable/latest/jenkins.war -0 /usr/local/bin/jenkins.war && \
chown jenkins: jenkins /usr/local/bin/jenkins.war

# Expose Jenkins default port
EXPOSE 8080

# Switch to Jenkins user
USER jenkins

#Start Jenkins
CMD ["java", "-jar", "/usr/local/bin/jenkins.war"]
