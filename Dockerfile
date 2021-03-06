FROM ubuntu

ARG pat_token=i3bq3mvbmg5ih5ua4yirrs7a3sskgeaogvevu53w5j6cswdo23eq
ARG service_url=https://dev.azure.com/v-anbols
ARG pool=Default
ARG agent=AKELON147

COPY agent /data/ubuntu-agent
ENV AGENT_ALLOW_RUNASROOT=1

# Download packets
RUN apt-get update && apt-get install -y openssh-client
RUN apt-get update && apt-get install -y openssh-server
RUN apt-get update && apt-get install -y vim

# Set up agent
WORKDIR /data/ubuntu-agent
RUN tar zxvf ./vsts-agent-linux-x64-2.168.2.tar.gz
RUN ./bin/installdependencies.sh; exit 0

RUN ./config.sh --auth PAT --token $pat_token --url $service_url --pool $pool --agent $agent --acceptTeeEula --replace --work _work


CMD ["/bin/bash"]
EXPOSE 8080
EXPOSE 443