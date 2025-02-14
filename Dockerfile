FROM python:3.12
LABEL maintainer="lauwarm@mailbox.org"

ENV streamlinkCommit=57dacf7bc9ee1f5793f8aa3c715220ded19653f6

#ENV streamlinkVersion=6.4.2
#ENV PATH "${HOME}/.local/bin:${PATH}"

#ADD https://github.com/streamlink/streamlink/releases/download/${streamlinkVersion}/streamlink-${streamlinkVersion}.tar.gz /opt/

#RUN apt-get update && apt-get install gosu

#RUN pip3 install versioningit

#RUN tar -xzf /opt/streamlink-${streamlinkVersion}.tar.gz -C /opt/ && \
#	rm /opt/streamlink-${streamlinkVersion}.tar.gz && \
#	cd /opt/streamlink-${streamlinkVersion}/ && \
#	python3 setup.py install

RUN apt-get update && apt-get install gosu && apt-get install python3-pip -y && apt-get install ffmpeg -y

RUN pip3 install --upgrade git+https://github.com/streamlink/streamlink.git@${streamlinkCommit}

RUN  echo 'export PATH="${HOME}/.local/bin:${PATH}"'

RUN mkdir /home/download
RUN mkdir /home/script
RUN mkdir /home/plugins

# add Chzzk plugins
# RUN git clone https://github.com/park-onezero/streamlink-plugin-chzzk streamlink-plugins
# RUN cp /streamlink-plugins/*.py /home/plugins/
# RUN pip3 install rsa
# RUN pip3 install lzstring

COPY ./streamlink-recorder.sh /home/script/
COPY ./entrypoint.sh /home/script
COPY ./plugins/*.py /home/plugins

RUN ["chmod", "+x", "/home/script/entrypoint.sh"]

ENTRYPOINT [ "/home/script/entrypoint.sh" ]

CMD /bin/sh ./home/script/streamlink-recorder.sh ${streamOptions} ${streamLink} ${streamQuality} ${streamName}
