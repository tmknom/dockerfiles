# dockerfiles

A collection of Dockerfiles.

## Description

This is a collection of dockerfiles that keep clean code.

Available dockerfiles are supported the following tools:

- **prettier**: It's an opinionated code formatter, see the [documents](https://prettier.io/docs/en/).
- **yamllint**: It's a linter for YAML files, see the [documents](https://yamllint.readthedocs.io/en/stable/).
- **markdownlint**: It's a style checker and lint tool for Markdown files, see the [documents](https://github.com/DavidAnson/markdownlint).

These are useful tools, but there is no official image.
Therefore, this repository creates and distributes these lightweight images.

## Usage

### Pull

You can pull from Docker Hub or GitHub Packages, whichever you prefer.
Using prettier as an example, pull as the following commands.

**Docker Hub:**

```shell
docker pull tmknom/prettier
```

**GitHub Packages:**

```shell
docker pull ghcr.io/tmknom/dockerfiles/prettier
```

The following shows how to use it when pulled from Docker Hub.

### prettier

```shell
docker run --rm -v "$(pwd):/work" tmknom/prettier --check --parser=markdown README.md
```

For more information, see [prettier/README.md](/prettier/README.md).

### yamllint

```shell
docker run --rm -v "$(pwd):/work" tmknom/yamllint -- .
```

For more information, see [yamllint/README.md](/yamllint/README.md).

### markdownlint

```shell
docker run --rm -v "$(pwd):/work" tmknom/markdownlint -- .
```

For more information, see [markdownlint/README.md](/markdownlint/README.md).

## Supported platforms

- linux/amd64
- linux/arm64

## Developer Guide

<!-- markdownlint-disable no-inline-html -->
<details>
<summary>Click to see details</summary>

### Requirements

- [GNU Make](https://www.gnu.org/software/make/)
- [Docker](https://docs.docker.com/get-docker/)
- [GitHub CLI](https://cli.github.com/)

### Development

#### Creating a new Dockerfile

1. Create `<image_name>/` directory
2. Define docker image: `Dockerfile`, `entrypoint.sh`, `.dockerignore`
3. Manage package file: `package.json` or `requirements.txt`

#### Management for releasing and updating dependencies

1. Create release action: `.github/workflows/release-<image_name>.yml`
2. Configure version updates for dependencies: `.github/dependabot.yml`

#### Documentation for users

1. Write details for the new docker image: `<image_name>/README.md`
2. Update description and append usage: `README.md`

### Release management

1. Update Dockerfile or package management file
2. Commit, push, and create a pull request
3. After merged, run [Workflows](/.github/workflows) with `release-` prefix automatically at GitHub Actions

Then, publishes Docker images to Docker Hub and GitHub Packages. :rocket:

### Dependency management

Use Dependabot version updates.
For more information, see [dependabot.yml](/.github/dependabot.yml).

### Secrets management

Stored following secrets in Repository Secrets.

- `DOCKERHUB_TOKEN`: Personal access token used to log against Docker Hub.

<!-- markdownlint-enable no-inline-html -->
