# PHP7.2 with OCI8 driver
Um projeto para construir uma imagem docker com php7.2, apache2 e driver oci8.

Para baixar a imagem:
```
$ sudo docker pull brunosilvcarv/php-oci8:7.2
```

## Instanciando o container

```
$ sudo docker run -d -p 8080:80 --name php brunosilvcarv/php-oci8:7.2
```
No navegador: http://localhost:8080/teste.php

Ou rode sua aplicação:

```
$ sudo docker run -d -p 8080:80 --name php -v caminho/para/sua/aplicação_php:/var/www/html brunosilvcarv/php-oci8:7.2
```


Para mais opções em instanciação de containers, leia a [docker run reference](https://docs.docker.com/engine/reference/run/).


