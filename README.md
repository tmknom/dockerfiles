# dockerfiles

A collection of Dockerfiles.

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
