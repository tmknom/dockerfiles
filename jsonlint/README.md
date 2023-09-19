# jsonlint

A JSON parser and validator with a CLI.

## Description

This image is [jsonlint](https://github.com/zaach/jsonlint) wrapper.

It is a useful tool, but there is no official image.
Therefore, this repository distributes a lightweight image based on alpine.

## Docker registries

You can pull from Docker Hub or GitHub Packages, whichever you prefer.

### Docker Hub

```shell
docker pull tmknom/jsonlint
```

For more information, see [Docker Hub](https://hub.docker.com/repository/docker/tmknom/jsonlint).

### GitHub Packages

```shell
docker pull ghcr.io/tmknom/dockerfiles/jsonlint
```

For more information, see [GitHub Packages](https://github.com/tmknom/dockerfiles/pkgs/container/dockerfiles%2Fjsonlint).

## Usage

### Lint a JSON file

```shell
docker run --rm -v "$(pwd):/work" tmknom/jsonlint --compact --quiet foo.json
```

### Help

```shell
docker run --rm tmknom/jsonlint --help
```

## Supported platforms

- linux/amd64
- linux/arm64

## Source repository

- [tmknom/dockerfiles](https://github.com/tmknom/dockerfiles/)

## License

Apache 2 Licensed. See [LICENSE](/LICENSE) for full details.
