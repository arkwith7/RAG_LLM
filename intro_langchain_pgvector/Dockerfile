# Use the official PostgreSQL image from the Docker Hub
FROM postgres:latest

# Install pgvector
RUN apt-get update && apt-get install -y wget gcc libc-dev
RUN wget https://github.com/pgvector/pgvector/archive/refs/tags/v0.2.1.tar.gz
RUN tar -xzf v0.2.1.tar.gz && cd pgvector-0.2.1 && make && make install

# Make sure the extension can be loaded by PostgreSQL
RUN echo "shared_preload_libraries = 'vector'" >> /usr/share/postgresql/postgresql.conf.sample