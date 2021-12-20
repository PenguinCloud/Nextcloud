FROM penguintech/core-ansible
LABEL maintainer="Penguinz Tech Group LLC"
COPY . /opt/manager/
ENV DATABASE_NAME="nextcloud"
ENV DATABASE_USER="nextcloud"
ENV DATABASE_PASSWORD="p@ssword"
ENV DATABASE_HOST="localhost"
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
ENV TRUSTED_DOMAIN="127.0.0.1"
ENV URL="https://127.0.0.1"
ENV CPU_COUNT="2"
ENV FILE_LIMIT="1042"
RUN ansible-playbook /opt/manager/upstart.yml -c local --tags build
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
	&& ln -sf /dev/stderr /var/log/nginx/error.log
ENTRYPOINT ["ansible-playbook", "/opt/manager/upstart.yml", "-c", "local", "--tags", "run,exec"]