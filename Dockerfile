FROM scottatron/baseimage-ruby19

ADD . /build/
RUN export LC_ALL=C &&\
    export DEBIAN_FRONTEND=noninteractive &&\
    minimal_apt_get_install='apt-get install -y --no-install-recommends' &&\
    apt-get -y update &&\
    echo "mysql-server mysql-server/root_password password root" | debconf-set-selections &&\
    echo "mysql-server mysql-server/root_password_again password root" | debconf-set-selections &&\
    apt-get install -y mysql-server libmysqlclient-dev &&\
    rsync -r /build/etc / &&\
    apt-get clean && rm -rf /build /var/lib/apt/lists/* /tmp/* /var/tmp/*
