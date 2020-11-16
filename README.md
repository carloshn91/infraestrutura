# infraestrutura

Conforme orientações de utilização projeto, segue orientações para utilização do mesmo.

Os seguintes serviços foram utilizados:

Minikube

GitHub

GitHub Actions

Ambientes testados:

MacOS Catalina 10.15.7

Ubuntu 20.04

Repositorios:

DockerHub: https://hub.docker.com/repository/docker/carloshn91/infraestrutura (Público)

GitHub: https://github.com/carloshn91/infraestrutura (Público)

Seguem etapadas concluidas:

Etapa 1: Dockerfile criado com sucesso e presente no projeto;

Etapa 2: Build automatico da imagem criado com sucesso, toda modificação do efetuada na branch main (master do meu projeto) será encaminhado efetuado o push;

Etapa 3: Arquivo deploymento.yaml foi configurado corretamente para que durante deploy da nova versão do aplicativo, 3 PODS continuem em funcionamento, euquanto outras 5 serão encerradas e outras 3 PODS são criadas, justamente para evitar a indisponibilidade do Serviço;

Passo 1: Por se tratar de um teste de uma aplicação local, primeiramente é necessário baixar o projeto do git a sua máquina local:

`git clone https://github.com/carloshn91/infraestrutura.git`

Passo 2: Execute o comando abaixo para dar permissão de exeucução a um script que irá automatizar a criação do NAMESPACE no minikube, junto ao deployment e services:

`chmod +x automatico`

Passo 3:  Após dada a permissão necessária, basta executar o mesmo:

`./automatico`

Passo 4: Com namespace, deployment e services criados utilize os comandos abaixo para descobrir o IP do Minikube e a porta liberada pelo Kubernetes para utilização do Serviço:

`minikube ip`

`kubectl get service | awk '{print $5}' | sed 's/5000://g' | sed 's/\/TCP//g' | sed '1d'`

*Observação: Parto do principio que o Minikube da máquina local, possui somente um serviço em execução por isso do comando "sed '1d'"

Passo 5: Com os IPs em mãos, utilize a seguinte sintaxe para utilizá-los:

Sintaxe:

`curl -i http://IP-DO-MINIKUBE:PORTA-DO-SERVICE/app`

`curl -i http://IP-DO-MINIKUBE:PORTA-DO-SERVICE/admin`

`curl -i http://IP-DO-MINIKUBE:PORTA-DO-SERVICE/healthz`

Exemplo:

`curl -i http://192.168.99.100:32209/app`

`curl -i http://192.168.99.100:32209/admin`

`curl -i http://192.168.99.100:32209/healthz`

Passo 6: Valide as saídas dos comandos.

Etapa 4: As ferramentas para monitoramento seriam:

* popeye: Ferramenta OpenSource de linha de comando para o monitoramento de Clusters presentes no Kubernetes, embora seja uma ferramenta de linha de comando e isso possa causar um certo incomodo a alguns usuários, o Popeye é extremamente bem detalhada, autoexplicativa e colorida (parece bobo, mas é importante).

O Popeye possui diversas métricas sobre o Cluster como: Monitoramentos do(s) Nó(s), Namespaces, Pods, Services, Secrets, absolutamente tudo.

https://github.com/derailed/popeye

* Zabbix: Ferramenta OpenSource, poderia ser instalado um Zabbix Agent para realizar o monitoramento do status do ambiente utilizando Triggers (Alarmes) para que uma ação imediata no mesmo.

https://www.zabbix.com/

* Grafana: Ferramenta OpenSource, é utilizada para visualizar a saúde do ambiente por meio de Dashboards, bem como o monitoramento e leitura de Logs. Uma de suas grandes utilidades (até por ser OpenSource) é a sua integração com outras ferramentas, entre elas o Zabbix:

https://github.com/grafana/grafana

* NewRelic: Ferramenta Proprietária (Necessária compra de Licença), embora seja próprietaria, possui boas funcionalidades como quantidade de acessos de serviços externos, qual API, URL, entre outros estão recebendo mais ou menos acessos, quantidade de erros (exemplos: 422, 404) que cada endereço esta apresentando.

O NewRelic permite também a criação de alarmes e métricas para avaliações do ambiente.

https://newrelic.com/

Etapa 5: Uma das minhas indicações seria a utilização dos seguintes serviços: APP Engine (Google Cloud Plataform) ou Amazon EC2 (AWS), ambas possuem o mesmo principio de PaaS (Plataform as a Service), conseguindo assim uma rapida ação ao ambiente como aumento de recursos, redirecionamento de URLs.

APP Engine (Google Cloud Plataform): O APP Engine apresenta boa performance, boa estabilidade de serviços e um razoável suporte, os custos desse serviço são bons.

Amazon EC2 (AWS): Os serviços da AWS em comparação aos outros sempre apresentam o melhor rendimento, melhor suporte, melhor estabilidade de serviços, entretanto por ser a melhor o seu valor acaba por pesar, sendo a mais cara entre eles.

Meu escolhido: APP Engine (Google Cloud Plataform)

Observação: Eu escolhi o APP Engine mais por preferencia pessoal, tenho experiencia com as duas plataformas e gosto muito de tudo que a AWS fornece, mas os custos acabam por pesar muito dependendo da empresa.
