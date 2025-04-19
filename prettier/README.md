# Prettier

An opinionated code formatter.

## Description

This image is [Prettier](https://prettier.io/docs/en/) wrapper.
It enforces a consistent style by parsing your code and re-printing it with its own rules
that take the maximum line length into account, wrapping code when necessary.

It is a useful tool, but there is no official image.
Therefore, this repository distributes a lightweight image based on alpine.

## Docker registries

You can pull from Docker Hub or GitHub Packages, whichever you prefer.

### Docker Hub

```shell
docker pull tmknom/prettier
```

For more information, see [Docker Hub](https://hub.docker.com/repository/docker/tmknom/prettier).

### GitHub Packages

```shell
docker pull ghcr.io/tmknom/dockerfiles/prettier
```

For more information, see [GitHub Packages](https://github.com/tmknom/dockerfiles/pkgs/container/dockerfiles%2Fprettier).

## Usage

### Format markdown

```shell
docker run --rm -v "$(pwd):/work" tmknom/prettier --write --parser=markdown README.md
```

### Check format markdown

```shell
docker run --rm -v "$(pwd):/work" tmknom/prettier --check --parser=markdown README.md
```

### Help

```shell
docker run --rm tmknom/prettier --help
```

## Supported platforms

- linux/amd64
- linux/arm64

## Source repository

- [tmknom/dockerfiles](https://github.com/tmknom/dockerfiles/)
