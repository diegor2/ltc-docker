FROM ubuntu:xenial

RUN apt-get update && apt-get install -y git \
	build-essential libtool autotools-dev automake \
	pkg-config libssl-dev libevent-dev bsdmainutils \
	libboost-system-dev libboost-filesystem-dev \
	libboost-chrono-dev libboost-program-options-dev \
	libboost-test-dev libboost-thread-dev \
	libqt5gui5 libqt5core5a libqt5dbus5 qttools5-dev \
	qttools5-dev-tools libprotobuf-dev protobuf-compiler \
	libqrencode-dev libminiupnpc-dev libzmq3-dev \
	software-properties-common && \
	add-apt-repository ppa:bitcoin/bitcoin && apt-get update && \
	apt-get install -y libdb4.8-dev libdb4.8++-dev

RUN git clone https://github.com/litecoin-project/litecoin /ltc

WORKDIR /ltc

RUN CPUS="$(lscpu -p | grep -v '#' | wc -l)"; \
	./autogen.sh && ./configure && make -j$CPUS
