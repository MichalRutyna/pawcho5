ARG VERSION=latest

FROM scratch AS builder

ADD alpine-minirootfs-3.21.3-aarch64.tar /

RUN apk add --update npm

# Deklaracja katalogu roboczego
WORKDIR /usr/app

# # Kopiowanie niezbędnych zaleności 
COPY ./package.json ./
# Instalacja tych zaleności 
RUN npm install



FROM nginx:latest
ARG VERSION

WORKDIR /usr/app

COPY --from=builder /usr/app ./

# Kopiowanie kodu aplikacji do wewnątrz obrazu
COPY ./index.js ./

RUN apt-get install -y curl && \
curl -fsSL https://deb.nodesource.com/setup_23.x -o nodesource_setup.sh 
RUN bash nodesource_setup.sh
RUN apt-get install -y nodejs


ENV VERSION=production.${VERSION:-v1.0}

# Informacja o porcie wewnętrznym kontenera, 
# na ktorym "nasluchuje" aplikacja
EXPOSE 8080

# Domyśle polecenie przy starcie kontenera 
CMD ["npm", "start"]

