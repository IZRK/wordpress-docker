# How to set up:
- Put wp-config.php in `/home/hosting/website_folder`
- Make it readonly (`chown root:root wp-config.php && chmod 644 wp-config.php`)
- Put `wp-content` in the `website_folder`
- Set up reverse proxy, nginx example below
- `docker compose up -d`
```nginx
server {
        server_name website.si www.website.si;

        location / {
                proxy_pass http://localhost:11111;
                proxy_set_header Host $host;
                proxy_set_header X-Real-IP $remote_addr;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_set_header X-Forwarded-Proto $scheme;
       }

        listen [::]:443 ssl;
        listen 443 ssl;
}
```
- Update `wp-config.php` to include these lines below. `DB_HOST` is the mysql container from `docker-compose.yml`
```
$_SERVER['HTTPS'] = 'on';

define('WP_HOME', 'https://website.si');
define('WP_SITEURL', 'https://website.si');

define('DB_HOST', 'db');
```

### To nuke cache and force wordpress docker update:
```
docker compose down
docker system prune --all --force
docker pull wordpress:latest
docker compose up --build --force-recreate --no-deps -d
```
