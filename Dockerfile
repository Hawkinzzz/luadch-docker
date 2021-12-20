FROM lsiobase/alpine:3.14


# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Neo version:- ${VERSION} Build-date:- ${BUILD_DATE}"


# install dependencies
RUN apk add --no-cache \
     git \
     rsync \
     libstdc++ \
     openssl && \

# install build packages
 apk add --no-cache --virtual=build-dependencies \
        g++ \
        gcc \
        make \
        lua-dev \
        openssl-dev && \
 cd /app && \
 git clone https://github.com/luadch/luadch.git dchub && \
 cd /app/dchub/ && \
 /app/dchub/compile && \
 mv /app/dchub/luadch/build_gcc/luadch/* /app/ && \
 rm -rf /app/dchub && \
 rm -rf /app/cfg && \
 rm -rf /app/log && \
 rm -rf /app/certs && \
 rm -rf /app/scripts/lang && \

# cleanup
apk del --purge \
        build-dependencies && \
rm -rf \
        /tmp/*

# add local files
COPY root/ /

# ports and volumes
EXPOSE 5000 5001
