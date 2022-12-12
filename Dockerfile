FROM code-dal1.penguintech.group:5050/ptg/standards/docker-ansible-image:stable
LABEL company="Penguin Tech Group LLC"
LABEL org.opencontainers.image.authors="info@penguintech.group"
LABEL license="GNU AGPL3"

# GET THE FILES WHERE WE NEED THEM!
COPY . /opt/manager/
WORKDIR /opt/manager

# UPDATE as needed
RUN apt update && apt dist-upgrade -y && apt auto-remove -y && apt clean -y

# PUT YER ARGS in here
ARG APP_TITLE="Nextcloud"
ARG APP_LINK="https://download.nextcloud.com/server/releases/latest.zip"
# BUILD IT!
RUN ansible-playbook build.yml -c local

# PUT YER ENVS in here
ENV DATABASE_NAME="nextcloud"
ENV DATABASE_USER="nextcloud"
ENV DATABASE_PASSWORD="p@ssword"
ENV DATABASE_HOST="mariadb"
ENV DATABASE_PORT="3306"
ENV ORGANIZATION_NAME="name"
ENV ORGANIZATION_COUNTRY="US"
ENV ORGANIZATION_EMAIL="admin@localhost"
ENV ORGANISATION_HOSTNAME="ptg.org"
ENV REDIS_HOST="localhost"
ENV REDIS_PORT="6379"
ENV REDIS_PASS="paswword123"
ENV REDIS_TIMEOUT="1.5"
ENV ADMIN_LOGGING=admin
ENV ADMIN_PASS=password
ENV TRUSTED_DOMAIN="localhost.nextcloud:8080"
ENV URL="localhost.nextcloud:8080"
ENV CPU_COUNT="2"
ENV FILE_LIMIT="1042"
ENV SSL_KEY="nokey"
ENV SSL_CERTIFICATE="nocert"
# Switch to non-root user
USER ptg-user

EXPOSE 8080

# Entrypoint time (aka runtime)
ENTRYPOINT ["/bin/bash","/opt/manager/entrypoint.sh"]