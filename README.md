# docker-for-mac-with-PhpStorm-xdebug

## Directory Structure

```
docker-for-mac-with-PhpStorm-xdebug
├── apache
| └── default.conf
├── apt
| └── source.list
├── .gitignore
├── docker-compose.yml
├── Dockerfile
├── index.php
└── README.md
```

## Repositories Setup

1. mkdir docker-for-mac-with-PhpStorm-xdebug && cd docker-for-mac-with-PhpStorm-xdebug
2. git clone git@github.com:demotascha/docker-for-mac-with-PhpStorm-xdebug.git

### Docker for Mac
1. Get docker for Mac(stable), https://docs.docker.com/docker-for-mac/
2. check your localhost port 80 used or not. if yes, please stop service.
3. follow this article [Docker (Mac) De-facto Standard Host Address Alias](https://gist.github.com/ralphschindler/535dc5916ccbd06f53c1b0ee5a868c93) make address alias.

  ```
  sudo ifconfig lo0 alias 10.254.254.254
  sudo curl -o /Library/LaunchDaemons/com.ralphschindler.docker_10254_alias.plist https://gist.githubusercontent.com/ralphschindler/535dc5916ccbd06f53c1b0ee5a868c93/raw/com.ralphschindler.docker_10254_alias.plist
  ```
  
### Process
1. vim /etc/hosts
  ```
  127.0.0.1 www.demo.local.tw
  ```
2. cd docker-for-mac-with-PhpStorm-xdebug
3. docker-compose build && docker-compose up -d
4. docker-compose ps
5. using PHPStorm to open `docker-for-mac-with-PhpStorm-xdebug` project
6. set [PhpStorm config](https://confluence.jetbrains.com/display/PhpStorm/Zero-configuration+Web+Application+Debugging+with+Xdebug+and+PhpStorm) 
7. click index.php
8. set a breakpoint in the source code
9. start listening for PHP debug connections
10. open your browser, with link `http://www.demo.local.tw`

## References

- https://gist.github.com/ralphschindler/535dc5916ccbd06f53c1b0ee5a868c93
- https://confluence.jetbrains.com/display/PhpStorm/Zero-configuration+Web+Application+Debugging+with+Xdebug+and+PhpStorm
