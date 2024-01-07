```
docker run -it --rm --name certbot -v ${PWD}:/letsencrypt -v ${PWD}/certs:/etc/letsencrypt certbot bash
```