FROM ruby:2.3

COPY . /app

WORKDIR /app

RUN wget -qO- https://deb.nodesource.com/setup_5.x | bash

RUN apt-get install -y libpq-dev ruby-dev zlib1g-dev liblzma-dev node.js

RUN gem install rails --pre --no-ri --no-rdoc bundler pry 

RUN /bin/bash -c 'cd /app && bundle'

EXPOSE 80

CMD /bin/bash -c 'cd /app && rails s -b 0.0.0.0 -p80'