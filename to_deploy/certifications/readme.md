```
openssl req -newkey rsa:4096 \
            -x509 \
            -sha256 \
            -days 3650 \
            -nodes \
            -out pdf_converter.crt \
            -keyout pdf_converter.key
```
