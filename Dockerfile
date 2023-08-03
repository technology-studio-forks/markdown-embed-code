FROM python:3.10.5-alpine

RUN apk update && apk --no-cache add git gcc libc-dev libffi-dev

COPY ./requirements.txt ./requirements.txt

RUN pip install --no-cache -r ./requirements.txt

ENV PYTHONPATH=/

CMD ["python", "-m", "/"]
