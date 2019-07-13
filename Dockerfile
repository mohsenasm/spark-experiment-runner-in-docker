From gsoertsz/hadoop-hive-spark

# install some tools for development
RUN apt-get update && apt-get install -y nano less git && rm -rf /var/lib/apt/lists/*     
RUN echo "alias l='ls -CF'" >> /root/.bashrc && \
    echo "alias ll='ls -alF'" >> /root/.bashrc && \
    echo "export PATH=$PATH:/usr/local/hadoop/bin/" >> /root/.bashrc

# run bash with existing entrypoint
CMD "-bash"
