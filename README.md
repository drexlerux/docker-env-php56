drexlerux/env-php56
==========

![docker_logo](https://s26.postimg.org/k3tpv3ttl/docker_139x115.png)

This Docker container implements a last generation LAMP stack with a set of popular PHP modules. Includes support for [Composer](https://getcomposer.org/), [Bower](http://bower.io/) and [npm](https://www.npmjs.com/) package managers and a Postfix service to allow sending emails through PHP [mail()](http://php.net/manual/en/function.mail.php) function.


Includes the following components:

 * Ubuntu 16.04 LTS Xenial Xerus base image.
 * Apache HTTP Server 2.4
 * Postfix 2.11
 * PHP 5.6
 * PHP modules
 	* php-bz2
	* php-cgi
	* php-cli
	* php-common
	* php-curl
	* php-dbg
	* php-dev
	* php-enchant
	* php-fpm
	* php-gd
	* php-gmp
	* php-imap
	* php-interbase
	* php-intl
	* php-json
	* php-ldap
	* php-mcrypt
	* php-mysql
	* php-odbc
	* php-opcache
	* php-pgsql
	* php-phpdbg
	* php-pspell
	* php-readline
	* php-recode
	* php-snmp
	* php-sqlite3
	* php-sybase
	* php-tidy
	* php-xmlrpc
	* php-xsl
 * Development tools
	* git
	* composer
	* npm / nodejs
	* bower
	* vim
	* tree
	* nano
	* ftp
	* curl

Installation from [Docker registry hub](https://registry.hub.docker.com/u/drexlerux/env-php56/).
----

You can download the image using the following command:

```bash
docker pull drexlerux/env-php56
```

Environment variables
----

This image uses environment variables to allow the configuration of some parameteres at run time:

* Variable name: LOG_STDOUT
* Default value: Empty string.
* Accepted values: Any string to enable, empty string or not defined to disable.
* Description: Output Apache access log through STDOUT, so that it can be accessed through the [container logs](https://docs.docker.com/reference/commandline/logs/).

----

* Variable name: LOG_STDERR
* Default value: Empty string.
* Accepted values: Any string to enable, empty string or not defined to disable.
* Description: Output Apache error log through STDERR, so that it can be accessed through the [container logs](https://docs.docker.com/reference/commandline/logs/).

----

* Variable name: LOG_LEVEL
* Default value: warn
* Accepted values: debug, info, notice, warn, error, crit, alert, emerg
* Description: Value for Apache's [LogLevel directive](http://httpd.apache.org/docs/2.4/en/mod/core.html#loglevel).

----

* Variable name: ALLOW_OVERRIDE
* Default value: All
* All, None
* Accepted values: Value for Apache's [AllowOverride directive](http://httpd.apache.org/docs/2.4/en/mod/core.html#allowoverride).
* Description: Used to enable (`All`) or disable (`None`) the usage of an `.htaccess` file.

----

* Variable name: DATE_TIMEZONE
* Default value: UTC
* Accepted values: Any of PHP's [supported timezones](http://php.net/manual/en/timezones.php)
* Description: Set php.ini default date.timezone directive and sets MariaDB as well.

----

* Variable name: TERM
* Default value: dumb
* Accepted values: dumb
* Description: Allow usage of terminal programs inside the container, such as `mysql` or `nano`.

Exposed port and volumes
----

The image expose port `80`, and exports four volumes:

* `/var/log/httpd`, containing Apache log files.
* `/var/www/html`, used as Apache's [DocumentRoot directory](http://httpd.apache.org/docs/2.4/en/mod/core.html#documentroot).


The user and group owner id for the DocumentRoot directory `/var/www/html` are both 33 (`uid=33(www-data) gid=33(www-data) groups=33(www-data)`).

Use cases
----

#### Create a temporary container for testing purposes:

```
	docker run -i -t --rm drexlerux/env-php56 bash
```

#### Create a temporary container to debug a web app:

```
	docker run --rm -p 80:80 -e LOG_STDOUT=true -e LOG_STDERR=true -e LOG_LEVEL=debug -v /my/data/directory:/var/www/html drexlerux/env-php56
```
