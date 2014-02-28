FROM debian:stable

MAINTAINER Jonathan E. Magen, @yonkeltron

# upgrade base box
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y apt-utils

# install build tools
RUN apt-get install -y build-essential git curl zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt-dev ncurses-dev libdb-dev libreadline-dev procps postgresql-client libpq-dev gawk libtool libv8-dev

#install RVM and Ruby 2.1.1
RUN \curl -sSL https://get.rvm.io | bash -s stable
RUN /usr/local/rvm/bin/rvm-shell -l -c "rvm requirements"
RUN /usr/local/rvm/bin/rvm-shell -l -c "rvm install 2.1.1 --fuzzy"
RUN /usr/local/rvm/bin/rvm-shell -l -c "rvm use 2.1.1 --default"

# add Rails app and install gem dependencies
RUN apt-get clean 
ADD . /app
WORKDIR /app
RUN /usr/local/rvm/bin/rvm-shell -l -c "bundle"

# run app
EXPOSE 3000 3000
ENTRYPOINT ["/usr/local/rvm/bin/rvm-shell", "-l", "-c", "bundle exec rails server"]
