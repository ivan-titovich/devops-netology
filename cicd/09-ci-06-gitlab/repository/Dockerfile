FROM centos:7

RUN yum -y update && yum -y install gcc openssl-devel bzip2-devel libffi-devel wget make && yum clean all
RUN cd /opt && wget --no-check-certificate https://www.python.org/ftp/python/3.8.3/Python-3.8.3.tgz && tar xzf Python-3.8.3.tgz && cd Python-3.8*/ && ./configure && make altinstall && rm -rf /opt/Python*
COPY requirements.txt requirements.txt
RUN pip3.8 install -r requirements.txt
COPY python-api.py python-api.py
CMD ["python3.8", "python-api.py"]


## docker build -t python-api -f Dockerfile .
## docker run --rm -ti python-api bash -c "python3.8 --version && pip3.8 --version"
