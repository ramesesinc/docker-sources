FROM ramesesinc/enterprise-server:255.05

COPY /modules /services/modules
COPY /datasources /services/datasources
COPY /adapters /apps/enterprise/adapters
COPY /connections /apps/enterprise/connections
COPY /modules.conf /apps/enterprise/modules.conf

RUN ln -s /apps/server/services/apps/enterprise /enterprise
