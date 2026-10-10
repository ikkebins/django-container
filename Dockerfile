FROM python:3.13-slim-bookworm

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1 \
    PORT=8080 \
    APP_DIR=/app

WORKDIR /opt/webapp

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
COPY placeholder.py /opt/webapp/placeholder.py

RUN chmod 0555 /usr/local/bin/entrypoint.sh \
    && mkdir -p /app /tmp/django \
    && chmod -R a+rX /opt/webapp \
    && chmod 0777 /app /tmp/django

EXPOSE 8080

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["serve"]
