FROM python:3.10.5-alpine

RUN apk update && apk --no-cache add git gcc libc-dev libffi-dev

COPY ./requirements.txt ./requirements.txt

RUN pip install --no-cache -r ./requirements.txt

ENV PYTHONPATH=markdown_embed_code

RUN env
RUN ls -la

CMD ["python", "-m", "markdown_embed_code"]
