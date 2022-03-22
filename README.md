# dockerfiles

A collection of Dockerfiles.

## Description

This is a collection of dockerfiles that keep clean code.

Available dockerfiles are supported the following tools:

- **prettier**: It's an opinionated code formatter, see the [documents](https://prettier.io/docs/en/).
- **yamllint**: It's a linter for YAML files, see the [documents](https://yamllint.readthedocs.io/en/stable/).
- **markdownlint**: It's a style checker and lint tool for Markdown files, see the [documents](https://github.com/DavidAnson/markdownlint).
- **jsonlint**: It's a JSON parser and validator, see the [documents](https://github.com/zaach/jsonlint).

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
docker run --rm -v $(pwd):/work tmknom/prettier --check --parser=markdown **/*.md
```

For more information, see [prettier/README.md](/prettier/README.md).

### yamllint

```shell
docker run --rm -v $(pwd):/work tmknom/yamllint **/*.y*ml
```

For more information, see [yamllint/README.md](/yamllint/README.md).

### markdownlint

```shell
docker run --rm -v $(pwd):/work tmknom/markdownlint --dot .
```

For more information, see [markdownlint/README.md](/markdownlint/README.md).

### jsonlint

```shell
docker run --rm -v $(pwd):/work tmknom/jsonlint --compact foo.json
```

For more information, see [jsonlint/README.md](/jsonlint/README.md).

## Supported platforms

- linux/amd64
- linux/arm64

## Developer Guide

<!-- markdownlint-disable MD033 -->
<details>
<summary>Click to see details</summary>

### Requirements

- [GNU Make](https://www.gnu.org/software/make/)
- [Docker](https://docs.docker.com/get-docker/)
- [GitHub CLI](https://cli.github.com/)

### Test

```shell
make test
```

### CI

- [Lint Docker](/.github/workflows/lint-docker.yml)
- [Lint YAML](/.github/workflows/lint-yaml.yml)
- [Lint Markdown](/.github/workflows/lint-markdown.yml)
- [Lint Shell](/.github/workflows/lint-shell.yml)
- [Lint Action](/.github/workflows/lint-action.yml)

### Release management

1. Update Dockerfile or package management file
2. Commit, push, and create a pull request
3. After merged, run [Workflows](/.github/workflows) with `release-` prefix automatically at GitHub Actions

Then, publishes Docker images to Docker Hub and GitHub Packages. :rocket:

### Dependency management

Use Dependabot version updates.
For more information, see [dependabot.yml](/.github/dependabot.yml).

### Versioning of the entire repository

#### 1. Bump up to a new version

Run the following command to bump up.

```shell
make bump
```

This command will execute the following steps:

1. Update [VERSION](/VERSION)
2. Commit, push, and create a pull request
3. Open the web browser automatically for reviewing pull request

Then review and merge, so the release is ready to go.

#### 2. Publish the new version

Run the following command to publish a new tag at GitHub.

```shell
make release
```

Finally, we can use the new version! :tada:

</details>
<!-- markdownlint-enable MD033 -->

## License

Apache 2 Licensed. See [LICENSE](/LICENSE) for full details.
