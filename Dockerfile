FROM ualibraries/ruby_base:centos69
MAINTAINER Alex Strilets <strilets@ualberta.ca>

#run update
RUN yum -y update

#install required packages
RUN yum install -y mysql-server mysql MySQL-python mysql-devel clamav clamav-devel
RUN yum -y groupinstall 'Development Tools'

#update clamav DB
RUN /usr/bin/freshclam

#copy  mysql-server config file
ADD files/my.cnf /etc/my.cnf
RUN chmod 644 /etc/my.cnf


#get Getmfile and install all erequired gems
RUN wget https://raw.github.com/ualbertalib/HydraNorth/master/Gemfile -P /tmp \
    && wget https://raw.github.com/ualbertalib/HydraNorth/master/Gemfile.lock -P /tmp \
    && cd /tmp \
    &&  bundle install  --without development test --clean

#copy scripts into /usr/local/bin
ADD files/start.sh /usr/local/bin/start.sh
RUN chmod 755 /usr/local/bin/start.sh

ADD files/switch2mysql.rb /usr/local/bin/switch2mysql.rb
RUN chmod 755 /usr/local/bin/switch2mysql.rb

#expose ports
EXPOSE 3000
EXPOSE 8983
VOLUME /app/tmp

CMD /usr/local/bin/start.sh
