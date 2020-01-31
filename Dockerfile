FROM centos:7

RUN yum install -y epel-release
RUN rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch
RUN yum install -y https://artifacts.elastic.co/downloads/kibana/kibana-7.5.2-x86_64.rpm
RUN yum install -y jq curl bash
RUN yum -y update
RUN yum -y clean all

COPY /bin/kibana7 /usr/local/bin/
RUN chmod 755 /usr/local/bin/kibana6
RUN usermod --home /usr/share/kibana kibana

USER kibana

ENV PATH=/usr/share/kibana/bin:$PATH

HEALTHCHECK --interval=360s --timeout=3s --retries=3 CMD curl -sS http://localhost:5601/ || exit 1

EXPOSE 5601

CMD ["kibana7"]
