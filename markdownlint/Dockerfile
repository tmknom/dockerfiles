FROM node:16-alpine3.15

# Setup nonroot user
RUN set -x && \
    addgroup nonroot && \
    adduser -G nonroot -s /bin/sh -D nonroot

# Install tools
ENV ENTRYPOINT markdownlint
USER nonroot
WORKDIR /home/nonroot
COPY --chown=nonroot:nonroot package.json .
COPY --chown=nonroot:nonroot entrypoint.sh .
RUN set -x && \
    npm install && \
    npm cache clean --force

# Configure runtime
WORKDIR /work
ENV PATH "/home/nonroot/node_modules/.bin:${PATH}"
ENTRYPOINT ["/home/nonroot/entrypoint.sh"]
