# markdownlint

A style checker and lint tool for Markdown files.

## Description

This image is [markdownlint](https://github.com/DavidAnson/markdownlint) and
[markdownlint-cli](https://github.com/igorshubovych/markdownlint-cli) wrapper.
It is a static analysis tool for Node.js with a library of rules
to enforce standards and consistency for Markdown files.

It is a useful tool, but there is no official image.
Therefore, this repository distributes a lightweight image based on alpine.

## Docker registries

You can pull from Docker Hub or GitHub Packages, whichever you prefer.

### Docker Hub

```shell
docker pull tmknom/markdownlint
```

For more information, see [Docker Hub](https://hub.docker.com/repository/docker/tmknom/markdownlint).

### GitHub Packages

```shell
docker pull ghcr.io/tmknom/dockerfiles/markdownlint
```

For more information, see [GitHub Packages](https://github.com/tmknom/dockerfiles/pkgs/container/dockerfiles%2Fmarkdownlint).

## Usage

### Lint a Markdown file

```shell
docker run --rm -v $(pwd):/work tmknom/markdownlint README.md
```

### Lint all Markdown files in a directory

```shell
docker run --rm -v $(pwd):/work tmknom/markdownlint --dot .
```

### Help

```shell
docker run --rm tmknom/markdownlint --help
```

## Supported platforms

- linux/amd64
- linux/arm64

## Release management

1. Update [Dockerfile](/markdownlint/Dockerfile) or [package.json](/markdownlint/package.json)
2. Commit, push, and create a pull request
3. After merged, run [Release workflow](/.github/workflows/release-markdownlint.yml) automatically at GitHub Actions

Then, publishes Docker images to Docker Hub and GitHub Packages. :rocket:

## Dependency management

Use Dependabot version updates.
For more information, see [dependabot.yml](/.github/dependabot.yml).

## Source repository

- [tmknom/dockerfiles](https://github.com/tmknom/dockerfiles/)

## License

Apache 2 Licensed. See [LICENSE](/LICENSE) for full details.
