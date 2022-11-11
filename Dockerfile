FROM proycon/frog:dev
RUN apk add python3 py3-pip py3-numpy py3-yaml py3-rdflib py3-lxml git && pip install git+https://github.com/proycon/foliatools.git

COPY run.sh /

ENTRYPOINT ["/run.sh","/data"]
