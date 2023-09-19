# dockerfiles

A collection of Dockerfiles.

## Description

This is a collection of dockerfiles that keep clean code.

Available dockerfiles are supported the following tools:

- **prettier**: It's an opinionated code formatter, see the [documents](https://prettier.io/docs/en/).
- **yamllint**: It's a linter for YAML files, see the [documents](https://yamllint.readthedocs.io/en/stable/).
- **markdownlint**: It's a style checker and lint tool for Markdown files, see the [documents](https://github.com/DavidAnson/markdownlint).
- **jsonlint**: It's a JSON parser and validator, see the [documents](https://github.com/zaach/jsonlint).

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

### jsonlint

```shell
docker run --rm -v "$(pwd):/work" tmknom/jsonlint --compact --quiet foo.json
```

For more information, see [jsonlint/README.md](/jsonlint/README.md).

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

#### Testing for a new Docker Image

1. Create `.github/tests/<image_name>/` directory
2. Write test script: `test.sh`
3. Add test fixtures: `valid_<extension>.txt` and `invalid_<extension>.txt`

#### Management for releasing and updating dependencies

1. Create release action: `.github/workflows/release-<image_name>.yml`
2. Configure version updates for dependencies: `.github/dependabot.yml`

#### Documentation for users

1. Write details for the new docker image: `<image_name>/README.md`
2. Update description and append usage: `README.md`

### Test

Run the following command:

```shell
make test
```

Then pull image from Docker Hub and GitHub Packages, and run test scripts.

### CI

When create a pull request, the following workflows are executed automatically at GitHub Actions.

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

### Secrets management

Stored environment secrets for the following environments in this repository.

#### release

Reference from releasing workflows such as `.github/workflows/release-prettier.yml`.

- `DOCKERHUB_TOKEN`: Personal access token used to log against Docker Hub.

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
<!-- markdownlint-enable no-inline-html -->

## Changelog

See [CHANGELOG.md](/CHANGELOG.md).

## License

Apache 2 Licensed. See [LICENSE](/LICENSE) for full details.
