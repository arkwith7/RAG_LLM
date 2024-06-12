Docker를 사용하여 PostgreSQL과 pgvector를 실행할 때 발생하는 이 오류는 vector 확장이 PostgreSQL 이미지에 설치되어 있지 않기 때문에 발생합니다. Docker 컨테이너에서 PostgreSQL과 pgvector를 올바르게 설정하려면 다음 단계를 따라야 합니다:

1. Docker 이미지 커스터마이징: PostgreSQL 이미지에 pgvector 확장을 포함시키기 위해 Dockerfile을 사용하여 커스텀 이미지를 만들어야 합니다.
2. Dockerfile 작성:
PostgreSQL 공식 이미지를 베이스 이미지로 사용합니다.
필요한 pgvector 패키지를 설치합니다.
예를 들어, Dockerfile은 다음과 같이 작성할 수 있습니다:

```
# Use the official PostgreSQL image from the Docker Hub
FROM postgres:latest

# Install pgvector
RUN apt-get update && apt-get install -y wget gcc libc-dev
RUN wget https://github.com/pgvector/pgvector/archive/refs/tags/v0.2.1.tar.gz
RUN tar -xzf v0.2.1.tar.gz && cd pgvector-0.2.1 && make && make install

# Make sure the extension can be loaded by PostgreSQL
RUN echo "shared_preload_libraries = 'vector'" >> /usr/share/postgresql/postgresql.conf.sample
```
3. Docker 이미지 빌드:
Dockerfile이 있는 디렉토리에서 다음 명령을 실행하여 이미지를 빌드합니다:
```
docker build -t my-custom-postgres .
```
4. Docker 컨테이너 실행:
빌드된 이미지를 사용하여 Docker 컨테이너를 실행합니다. 예를 들어:
```
docker run --name my-postgres -e POSTGRES_PASSWORD=mysecretpassword -d my-custom-postgres
```
5. 확장 설치 확인:
컨테이너 내부에서 PostgreSQL에 접속하여 pgvector 확장이 올바르게 설치되었는지 확인합니다:
```
docker exec -it my-postgres psql -U postgres
```
그리고 다음 SQL 명령을 실행하여 확장을 로드합니다:
```
CREATE EXTENSION vector;
```
이러한 단계를 통해 Docker 내에서 PostgreSQL과 pgvector 확장을 성공적으로 설정하고 실행할 수 있습니다.