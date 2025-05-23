# yamllint

A linter for YAML files.

## Description

This image is [yamllint](https://yamllint.readthedocs.io/en/stable/) wrapper.
It does not only check for syntax validity,
but for weirdnesses like key repetition and cosmetic problems such as lines length, trailing spaces, indentation, etc.

It is a useful tool, but there is no official image.
Therefore, this repository distributes a lightweight image based on alpine.

## Docker registries

You can pull from Docker Hub or GitHub Packages, whichever you prefer.

### Docker Hub

```shell
docker pull tmknom/yamllint
```

For more information, see [Docker Hub](https://hub.docker.com/repository/docker/tmknom/yamllint).

### GitHub Packages

```shell
docker pull ghcr.io/tmknom/dockerfiles/yamllint
```

For more information, see [GitHub Packages](https://github.com/tmknom/dockerfiles/pkgs/container/dockerfiles%2Fyamllint).

## Installation and Verification

For step-by-step instructions on pulling the image and verifying its authenticity,  
see the [Installation guide](/yamllint/installation.md).

## Usage

### Lint a YAML file

```shell
docker run --rm -v "$(pwd):/work" tmknom/yamllint foo.yml
```

### Lint all YAML files in a directory

```shell
docker run --rm -v "$(pwd):/work" tmknom/yamllint -- .
```

### Help

```shell
docker run --rm tmknom/yamllint --help
```

## Supported platforms

- linux/amd64
- linux/arm64

## Source repository

- [tmknom/dockerfiles](https://github.com/tmknom/dockerfiles/)
