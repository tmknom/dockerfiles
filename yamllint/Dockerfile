ARG PYTHON_VERSION=3.13

FROM python:${PYTHON_VERSION}-alpine3.20

# Setup nonroot user
RUN set -x && \
    addgroup nonroot && \
    adduser -G nonroot -s /bin/sh -D nonroot

# Install tools
ENV ENTRYPOINT="yamllint"
USER nonroot
WORKDIR /home/nonroot
COPY --chown=nonroot:nonroot requirements.txt .
COPY --chown=nonroot:nonroot entrypoint.sh .
RUN set -x && \
    pip install --no-cache-dir --user -r ./requirements.txt

# Configure runtime
WORKDIR /work
ENV PATH="/home/nonroot/.local/bin:${PATH}"
ENV PYTHONPATH="/home/nonroot/.local/lib/python${PYTHON_VERSION}/site-packages"
ENTRYPOINT ["/home/nonroot/entrypoint.sh"]
