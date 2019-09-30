# Perl Crud Application

Diese Application zeigt ein Beispiel für eine Perl CRUD Anwendung. Im nachfolgenden wird Schritt für Schritt erklärt, wie man diese installiert und verwenden kann. Da MAMP bereits Perl als cgi-bin unterstützt, habe MAMP als Webserver installiert.

## Ausführen des test-cgi Skripts unter MAMP

```
http://localhost/cgi-bin/test-cgi
```

Das Skript liegt auch im Repository und gibt im Browser folgendes aus.

```
CGI/1.0 test script report:

argc is 0. argv is .

SERVER_SOFTWARE = Apache/2.2.34 (Unix) mod_wsgi/3.5 Python/2.7.13 PHP/7.2.1 mod_ssl/2.2.34 OpenSSL/1.0.2j DAV/2 mod_fastcgi/2.4.6 mod_perl/2.0.9 Perl/v5.24.0
SERVER_NAME = localhost
GATEWAY_INTERFACE = CGI/1.1
SERVER_PROTOCOL = HTTP/1.1
SERVER_PORT = 80
REQUEST_METHOD = GET
HTTP_ACCEPT = text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3
PATH_INFO = 
PATH_TRANSLATED = 
SCRIPT_NAME = /cgi-bin/test-cgi
QUERY_STRING = 
REMOTE_HOST =
REMOTE_ADDR = ::1
REMOTE_USER =
AUTH_TYPE =
CONTENT_TYPE =
CONTENT_LENGTH =
```

## Anlegen eines Virtual Hosts unter MAMP

Zunächst öffnet man die Datei http-vhosts.conf

```
Applications/MAMP/conf/apache/extra
```

Dort hängt man folgenden Code Block an

```
<virtualhost *:80>
    ServerAdmin bernhard.mehler@gmail.com
    DocumentRoot '/Applications/MAMP/htdocs/cgi-bin/perlcrud'
    ServerName perlcrud.localhost.com
    ServerAlias "cgi-bin" "Applications/MAMP/cgi-bin/"
      <Directory "/Applications/MAMP/cgi-bin">
	    Options ExecCGI Indexes FollowSymLinks        
	    AllowOverride None
        Order allow,deny
        Allow from all
        AddHandler cgi-script .cgi .pl
    </Directory>
</virtualhost>
```

Die Hosts Datei liegt unter /etc/hosts und muss folgendes enthalten.

```
127.0.0.1       perlcrud.localhost.com
```

Da der DocumentRoot auf das cgi-bin Verzeichnis zeigt, aber meine Dateien außerhalb liegen, benötigen wir noch einen Symlink auf den Ordner außerhalb.

Hierzu wechseln wir im Terminal auf das Verzeichnis 
```
/Applications/MAMP/htdocs/cgi-bin
```

Ich habe einen Symlink von meinem Verzeichnis auf das cgi-bin verzeichnis erstellt. Ansonten legt Ihr Eure Dateien einfach in folgendes Verzeichnis

```
/Applications/MAMP/htdocs/cgi-bin/perlcrud
```

Nun können wir das TestSkript nochmal mit dem Virtual Host aufrufen.

```
http://perlcrud.localhost.com/cgi-bin/perlcrud/test-cgi.pl
```

Wir erhalten wieder die Ausgabe des test Skripts im Browser.

## Installation der CPAN Module für die Datenbank (Beta Installation von DBD::mysql funktioniert nicht!!!)

Da MAMP standardmäßig mit MySql ausgeliefert wird, müssen wir zunächst das DBI Paket, welches das generelle Abstraction Layer für das Arbeiten unter Perl mit Datenbanken handhabt, installieren.

Darüber hinaus müssen wir noch das DBD::mysql installieren. Dieses ist dann für das Arbeiten unter Perl mit MySql verantwortlich.

Hierzu gehen wir wie folgt vor:

```
cd /Applications/MAMP/Library/bin
mysql_config cpan install DBD::mysql
```

dann können wir uns das cpan Modul ansehen

```
cd .cpan/build/
ls -la
```

Nun gehen wir in unseren DBD Mysql build

```
cd .cpan/build/DBD-mysql-***
```

Nun installieren wir die DBD MySql und machen einen Test

```
sudo perl Makefile.PL --testuser='root' -testpassword='root' --mysql_config=/Applications/MAMP/Library/bin/mysql_config
```

Leider wirft make einen Fehler den ich nicht lösen kann!!!!!!

```
bdimp.c:2006:19: error: use of undeclared identifier 'SSL_MODE_REQUIRED'
              ssl_mode = SSL_MODE_REQUIRED;
                         ^
dbdimp.c:2007:32: error: use of undeclared identifier 'MYSQL_OPT_SSL_MODE'
              if (mysql_options(sock, MYSQL_OPT_SSL_MODE, &ssl_mode) != 0) {
                                      ^
dbdimp.c:3207:24: warning: incompatible pointer types assigning to 'my_bool *' (aka 'char *') from 'bool *' [-Wincompatible-pointer-types]
          bind->is_null=      (_Bool*) &(fbind->is_null);
```

## Dependencies

Die Anwendung benötigt folgende CPAN Module:

- Data::FormValidator;
- HTML::Template::Associate;
- CGI;

## Beispiele der Anwendung (Screenshots)

