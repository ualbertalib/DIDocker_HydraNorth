FROM ualibraries/ruby_base:centos69
MAINTAINER Alex Strilets <strilets@ualberta.ca>

#run update
RUN yum -y update

#install required packages
RUN yum install -y redis resque nodejs jdk1.8.0 libreoffice ImageMagick-devel \
    ffmpeg GraphicsMagick poppler-utils libreoffice-headless MySQL-python \
    mysql-server mysql mysql-devel clamav clamav-devel
RUN yum -y groupinstall 'Development Tools'

#install FITS
RUN mkdir -p /usr/local/fits \
    && cd /usr/local/fits \
    && wget http://projects.iq.harvard.edu/files/fits/files/fits-1.0.6.zip \
    && unzip fits-1.0.6.zip \
    && rm  fits-1.0.6.zip \
    && chmod a+x /usr/local/fits/fits-1.0.6/fits.sh \
    && ln -s /usr/local/fits/fits-1.0.6/fits.sh /usr/bin/fits

#install phantomjs
RUN cd / \
    && export PHANTOM_JS="phantomjs-1.9.8-linux-x86_64" \
    && wget https://bitbucket.org/ariya/phantomjs/downloads/$PHANTOM_JS.tar.bz2 \
    && tar xvjf $PHANTOM_JS.tar.bz2 \
    && mv $PHANTOM_JS /usr/local/share \
    && rm $PHANTOM_JS.tar.bz2  \
    && ln -sf /usr/local/share/$PHANTOM_JS/bin/phantomjs /usr/local/bin

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
