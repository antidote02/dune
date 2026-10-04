## SearXNG
`/etc/searxng/settings.yml`
```
use_default_settings:
  engines:
    keep_only:
      - google
      - bing
      - baidu
server:
  secret_key: "AynoBTWTufCzlbywj7f9UGJUCsSmYvK"
  limiter: false
  image_proxy: true
search:
  safe_search: 0
  formats:
    - html
    - json
engines:
  - name: google
    disabled: false
    proxies:
      "http://": "http://host.docker.internal:7897"
      "https://": "http://host.docker.internal:7897"
  - name: bing
    disabled: false
    proxies:
      "http://": "http://host.docker.internal:7897"
      "https://": "http://host.docker.internal:7897"
  - name: baidu
    disabled: false