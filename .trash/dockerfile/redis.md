# redis

```bash
docker run -p 6379:6379 \
--name redis \
-v ~/k/dev/redis/data:/data \
-v ~/k/dev/redis/conf/redqis.conf:/etc/redis/redis.conf \
--restart=always -d redis redis-server /etc/redis/redis.conf
```