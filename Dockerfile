FROM nikolaik/python-nodejs:latest

RUN apt-get update && \
  apt-get install -y \
  ffmpeg \
  wget \
  mc \
  imagemagick && \
  rm -rf /var/lib/apt/lists/*

COPY package.json .
RUN npm install
#RUN npm install -g npm-check-updates
#RUN ncu --upgrade

RUN mkdir /txm
WORKDIR /txm
COPY . /txm
RUN python3 -m pip install -r /txm/requirements.txt
ENV TZ=Asia/Jakarta
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN ls

EXPOSE 5000

CMD ["npm", "start"]
