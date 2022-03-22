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
docker run --rm -v $(pwd):/work tmknom/prettier --write --parser=markdown **/*.md
```

### Check format markdown

```shell
docker run --rm -v $(pwd):/work tmknom/prettier --check --parser=markdown **/*.md
```

### Help

```shell
docker run --rm tmknom/prettier --help
```

## Supported platforms

- linux/amd64
- linux/arm64

## Release management

1. Update [Dockerfile](/prettier/Dockerfile) or [package.json](/prettier/package.json)
2. Commit, push, and create a pull request
3. After merged, run [Release workflow](/.github/workflows/release-prettier.yml) automatically at GitHub Actions

Then, publishes Docker images to Docker Hub and GitHub Packages. :rocket:

## Dependency management

Use Dependabot version updates.
For more information, see [dependabot.yml](/.github/dependabot.yml).

## Source repository

- [tmknom/dockerfiles](https://github.com/tmknom/dockerfiles/)

## License

Apache 2 Licensed. See [LICENSE](/LICENSE) for full details.