FROM python:3.10.5-alpine

RUN apk update && apk --no-cache add git gcc libc-dev libffi-dev

COPY ./requirements.txt /app/requirements.txt

RUN pip install --no-cache -r /app/requirements.txt

COPY ./markdown_embed_code /app/markdown_embed_code

ENV PYTHONPATH=/app

RUN adduser --disabled-password --gecos "" --uid 1001 runner \
    && groupadd docker --gid 123 \
    && usermod -aG sudo runner \
    && usermod -aG docker runner \
    && echo "%sudo   ALL=(ALL:ALL) NOPASSWD:ALL" > /etc/sudoers \
    && echo "Defaults env_keep += \"DEBIAN_FRONTEND\"" >> /etc/sudoers

CMD ["python", "-m", "markdown_embed_code"]
