FROM python:3.10.5-alpine

RUN apk update && apk --no-cache add git gcc libc-dev libffi-dev shadow

COPY ./requirements.txt /app/requirements.txt

RUN pip install --no-cache -r /app/requirements.txt

COPY ./markdown_embed_code /app/markdown_embed_code

ENV PYTHONPATH=/app

RUN adduser -D -u 1001 runner \
    && adduser runner wheel \
    && adduser runner $(getent group 123 | cut -d: -f1) \
    && apk add --no-cache sudo \
    && mkdir -p /etc/sudoers.d \
    && echo "%wheel ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/runner \
    && chmod 0440 /etc/sudoers.d/runner \
    && echo "includedir /etc/sudoers.d" >> /etc/sudoers

CMD ["python", "-m", "markdown_embed_code"]
