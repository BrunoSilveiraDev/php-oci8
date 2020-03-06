# PHP7.2 with OCI8 driver
A project to build a docker image with php7.2, apache2 and oci8 driver.

Ler em [português](https://github.com/BrunoSilveiraDev/php-oci8/tree/master/translation)


To download the image:
```
$ sudo docker pull brunosilvcarv/php-oci8:7.2
```

## Instantiating the container

```
$ sudo docker run -d -p 8080:80 --name php brunosilvcarv/php-oci8:7.2
```
In the browser: http://localhost:8080/teste.php

Or run your application:

```
$ sudo docker run -d -p 8080:80 --name php -v path/to/your/php_application:/var/www/html brunosilvcarv/php-oci8:7.2
```

For more options on instantiating containers, check the [docker run reference](https://docs.docker.com/engine/reference/run/).

