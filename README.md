## Instruções:

#### Clone esse repo no seu diretório goingfre

##### Dentro do diretório do dockerfile execute esses comandos em ordem:

- 0 -> `docker build -t my_ubuntu_image .`
- 1 -> `docker run -it --name my_ubuntu_container my_ubuntu_image`
- 2 -> a sessão vai abrir, configure o powerlevel 10k seguindo as instruções que aparecem na tela e depois disso saia do container digitando `exit` no terminal dele
- 3 -> `docker start my_ubuntu_container`

* agora seu container está criado e inicializado, para abrir ele e continuar de onde parou execute:
-> `docker exec -it my_ubuntu_container /bin/zsh`

* para sair:
-> `exit`

Eu sugiro vc criar aliases para tudo isso

Por fim, se por algum motivo quiser excluir tudo execute esses comandos aqui em sequencia:

`docker stop my_ubuntu_container`
`docker rm my_ubuntu_container`
`docker system prune -a --force --volumes`
