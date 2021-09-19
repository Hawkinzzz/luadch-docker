FROM lsiobase/alpine

MAINTAINER Neo

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Neo version:- ${VERSION} Build-date:- ${BUILD_DATE}"

# package version
ARG LUADCHVER="2.22"

# install dependencies
RUN apk add --no-cache \
     wget \
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
 wget https://github.com/luadch/luadch/archive/v$LUADCHVER.tar.gz && \
 tar zxvf /app/v$LUADCHVER.tar.gz && \
 rm /app/v$LUADCHVER.tar.gz && \
 cd /app/luadch-$LUADCHVER/ && \
 /app/luadch-$LUADCHVER/compile && \
 mv /app/luadch-$LUADCHVER/build_gcc/luadch/* /app/dchub && \
 rm -rf /app/luadch-$LUADCHVER && \
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
