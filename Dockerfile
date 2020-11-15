# Imagem Golang-Alpine que será utilizada de forma primária para construição do binário app
FROM golang:alpine AS builder

# Responsavel pela criação da imagem
LABEL maintainer="Carlos Nascimento <carloshn2009@gmail.com>"

# Declarando variaveis informadas no README para correto funcionamento da imagem
ENV GOOS=linux \
    GOARCH=amd64

# Copiando arquivos do diretório do GitHub para o diretório da imagem /go/src
COPY . /go/src

# Diretório onde serão executados os comando abaixo
WORKDIR /go/src

# Construindo a aplicação
RUN go build -o app

# Tornando executavel o ShellScript
RUN chmod +x script.sh

# Construindo uma imagem pequena com o Alpine
FROM alpine

# Cadastrando variaveis de ambiente ADMIN_USER e ADMIN_PASS para o correto funcionamento do binário app
ENV ADMIN_USER=myuser \
    ADMIN_PASS=s3cr3t

# Realizando a construção do diretório alpine
COPY --from=builder /go/src/ /alpine/

# Local onde se encontram os arquivos como main.go, README e o binário app
WORKDIR /alpine/

# Expondo a porta 5000
EXPOSE 5000

# Excussão do ShellScript para contornar realizar a execução do da porta com o binário app
CMD [ "./script.sh" ]