# Installation

Official container images can be downloaded from [Docker Hub][docker_hub] or [GitHub Container Registry][ghcr].
We support popular CPU architectures like `amd64` and `arm64`.

## Pull

You can pull images by specifying the `latest` tag, a specific version, or a digest.

> [!NOTE]
>
> For production use or verification purposes, it is strongly recommended to pull by **digest** to ensure immutability.
> A digest is a unique, content-based identifier for the image.

### Specify latest

**Docker Hub:**

```shell
docker pull ${DOCKER_HUB_IMAGE}:latest
```

**GitHub Container Registry:**

```shell
docker pull ${GHCR_IMAGE}:latest
```

### Specify version

**Docker Hub:**

```shell
docker pull ${DOCKER_HUB_IMAGE}:${VERSION}
```

**GitHub Container Registry:**

```shell
docker pull ${GHCR_IMAGE}:${VERSION}
```

### Specify digest

**Docker Hub:**

```shell
docker pull ${DOCKER_HUB_IMAGE}@${IMAGE_DIGEST}
```

**GitHub Container Registry:**

```shell
docker pull ${GHCR_IMAGE}@${IMAGE_DIGEST}
```

> [!TIP]
>
> The digest shown above is real and can be used as-is.
> If you need the digest for a different tag or version, you can find it on [Docker Hub][docker_hub] or [GitHub Container Registry][ghcr].
> You can find the digest in the image details section, usually labeled as `Digest` or starting with `sha256:`.

## Verify

To ensure the container image is authentic and has not been tampered with, we provide cryptographic verification methods.
Verification confirms it was published from a trusted GitHub Actions workflow.

You can choose one of the following methods:

### Cosign

To verify the signature of an image using [Cosign](https://github.com/sigstore/cosign), make sure it is installed.
Cosign allows you to confirm not only the publisher but also the exact commit used to build the image.

**Docker Hub:**

```shell
cosign verify \
  --certificate-oidc-issuer "${CERTIFICATE_OIDC_ISSUER}" \
  --certificate-identity "${CERTIFICATE_IDENTITY}" \
  --certificate-github-workflow-repository "${GITHUB_REPOSITORY}" \
  --certificate-github-workflow-sha "${GITHUB_SHA}" \
  ${DOCKER_HUB_IMAGE}@${IMAGE_DIGEST}
```

**GitHub Container Registry:**

```shell
cosign verify \
  --certificate-oidc-issuer "${CERTIFICATE_OIDC_ISSUER}" \
  --certificate-identity "${CERTIFICATE_IDENTITY}" \
  --certificate-github-workflow-repository "${GITHUB_REPOSITORY}" \
  --certificate-github-workflow-sha "${GITHUB_SHA}" \
  ${GHCR_IMAGE}@${IMAGE_DIGEST}
```

<details>
<summary>Example output: verification succeeded</summary>

```shell
${COSIGN_VERIFY_SUCCEEDED}
```
</details>

### GitHub Artifact Attestations

To verify provenance using [GitHub CLI](https://cli.github.com/), make sure it is installed.
GitHub Artifact Attestations allows you to confirm that the image was built by a trusted workflow and published by the specified repository.

**Docker Hub:**

```shell
gh attestation verify oci://${DOCKER_HUB_IMAGE}@${IMAGE_DIGEST} \
  --deny-self-hosted-runners \
  --repo "${GITHUB_REPOSITORY}" \
  --cert-oidc-issuer "${CERTIFICATE_OIDC_ISSUER}" \
  --cert-identity "${CERTIFICATE_IDENTITY}"
```

**GitHub Container Registry:**

```shell
gh attestation verify oci://${GHCR_IMAGE}@${IMAGE_DIGEST} \
  --deny-self-hosted-runners \
  --repo "${GITHUB_REPOSITORY}" \
  --cert-oidc-issuer "${CERTIFICATE_OIDC_ISSUER}" \
  --cert-identity "${CERTIFICATE_IDENTITY}"
```

<details>
<summary>Example output: verification succeeded</summary>

```shell
${GH_ATTESTATION_SUCCEEDED}
```
</details>

[docker_hub]: https://hub.docker.com/r/${GITHUB_REPOSITORY_OWNER}/${NAME}
[ghcr]: https://github.com/${GITHUB_REPOSITORY}/pkgs/container/dockerfiles%2F${NAME}
