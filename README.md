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

### prettier

```shell
docker run --rm -v $(pwd):/work ghcr.io/tmknom/dockerfiles/prettier --check --parser=yaml **/*.y*ml
```

### yamllint

```shell
docker run --rm -v $(pwd):/work ghcr.io/tmknom/dockerfiles/yamllint --strict .
```

### markdownlint

```shell
docker run --rm -v $(pwd):/work ghcr.io/tmknom/dockerfiles/markdownlint --dot **/*.md
```

### jsonlint

```shell
docker run --rm -v $(pwd):/work ghcr.io/tmknom/dockerfiles/jsonlint --quiet --compact **/*.json
```

## License

Apache 2 Licensed. See LICENSE for full details.
