FROM ubuntu:13.10
# Create User BIN
RUN PATH=~/bin:$PATH
# Fix: /etc/sudoers is mode 0755, should be 0440
RUN chmod 0440 /etc/sudoers 
RUN chmod 0440 /etc/sudoers.d/README
# Update to current
RUN sudo apt-get update -y
RUN sudo apt-get upgrade -y
# Install curl
RUN sudo apt-get install -y curl
# Install REPO Tool
RUN curl http://commondatastorage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
RUN chmod a+x ~/bin/repo
# Install Devtools 
RUN apt-get install -y --no-install-recommends build-essential automake libtool pkg-config check libssl-dev sqlite3 libevent-dev libglib2.0-dev libcurl4-openssl-dev erlang-nox curl erlang-dev erlang-src ruby libmozjs-dev libicu-dev libv8-dev libcloog-ppl0 libsnappy-dev
# Install git
RUN apt-get install -y --no-install-recommends git-core
# Missing Dependency on Ubuntu not Debian!
RUN apt-get install -y xulrunner-dev
# Configure git
RUN git config --global user.email your@email.addr
RUN git config --global user.name  your_name
RUN mkdir ~/couchbase
RUN cd ~/couchbase
RUN repo init -u git://github.com/couchbase/manifest.git -m rel-2.2.1.xml
RUN repo sync
#RUN make couchdb_EXTRA_OPTIONS='--with-js-include=/usr/include/xulrunner-1.9.2.16 --with-js-lib=/usr/lib/xulrunner-devel-1.9.2.16/sdk/lib/'
#The path seems to vary with version. 'dpkg -l xulrunner-dev' will help you find the right path.
