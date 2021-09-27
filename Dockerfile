FROM alpine
RUN apk add --no-cache rtl-sdr
COPY MultiSDR.sh /
CMD ["/bin/sh", "/MultiSDR.sh"]
