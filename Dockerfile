FROM opensearchproject/opensearch:latest

# analysis-nori 플러그인 설치
RUN /usr/share/opensearch/bin/opensearch-plugin install analysis-nori
