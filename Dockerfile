FROM elixir:otp-27-slim

WORKDIR ./app

RUN apt-get update && \
    apt-get install -y ca-certificates iputils-ping curl dnsutils && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get -y update && \
    apt-get -y upgrade && \
    apt-get install -y --no-install-recommends ffmpeg

COPY . .

RUN mix deps.get

RUN mv /app/_build/dev/lib/rambo/priv/rambo-linux /app/_build/dev/lib/rambo/priv/rambo

EXPOSE 4000

CMD ["mix", "run", "--no-halt", "--env", "prod"]