FROM python:3-alpine
RUN mkdir -vp /app/views
COPY bottle.py /app/
COPY printfarm.py /app/
COPY views/* /app/views/
COPY testdata/* /app/

WORKDIR /app
CMD ["python3", "./printfarm.py"]
