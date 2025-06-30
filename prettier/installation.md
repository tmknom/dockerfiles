# Installation

We provide lightweight container images for **prettier**,  
which are available from [Docker Hub][docker_hub] or [GitHub Container Registry][ghcr].
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
docker pull tmknom/prettier:latest
```

**GitHub Container Registry:**

```shell
docker pull ghcr.io/tmknom/dockerfiles/prettier:latest
```

### Specify version

**Docker Hub:**

```shell
docker pull tmknom/prettier:3.6.2
```

**GitHub Container Registry:**

```shell
docker pull ghcr.io/tmknom/dockerfiles/prettier:3.6.2
```

### Specify digest

**Docker Hub:**

```shell
docker pull tmknom/prettier@sha256:31684fd957f78ddebd0fc003f2790da08bd7a41cfe1146912da43a114fbeebf9
```

**GitHub Container Registry:**

```shell
docker pull ghcr.io/tmknom/dockerfiles/prettier@sha256:31684fd957f78ddebd0fc003f2790da08bd7a41cfe1146912da43a114fbeebf9
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
  --certificate-oidc-issuer "https://token.actions.githubusercontent.com" \
  --certificate-identity "https://github.com/tmknom/dockerfiles/.github/workflows/reusable-release.yml@refs/heads/main" \
  --certificate-github-workflow-repository "tmknom/dockerfiles" \
  --certificate-github-workflow-sha "b2f82591b33718f5e0514ca659ff79a219439b41" \
  tmknom/prettier@sha256:31684fd957f78ddebd0fc003f2790da08bd7a41cfe1146912da43a114fbeebf9
```

**GitHub Container Registry:**

```shell
cosign verify \
  --certificate-oidc-issuer "https://token.actions.githubusercontent.com" \
  --certificate-identity "https://github.com/tmknom/dockerfiles/.github/workflows/reusable-release.yml@refs/heads/main" \
  --certificate-github-workflow-repository "tmknom/dockerfiles" \
  --certificate-github-workflow-sha "b2f82591b33718f5e0514ca659ff79a219439b41" \
  ghcr.io/tmknom/dockerfiles/prettier@sha256:31684fd957f78ddebd0fc003f2790da08bd7a41cfe1146912da43a114fbeebf9
```

<details>
<summary>Example output: verification succeeded</summary>

```shell

Verification for ghcr.io/tmknom/dockerfiles/prettier@sha256:31684fd957f78ddebd0fc003f2790da08bd7a41cfe1146912da43a114fbeebf9 --
The following checks were performed on each of these signatures:
  - The cosign claims were validated
  - Existence of the claims in the transparency log was verified offline
  - The code-signing certificate was verified using trusted certificate authority certificates

[{"critical":{"identity":{"docker-reference":"ghcr.io/tmknom/dockerfiles/prettier"},"image":{"docker...
```
</details>

### GitHub Artifact Attestations

To verify provenance using [GitHub CLI](https://cli.github.com/), make sure it is installed.
GitHub Artifact Attestations allows you to confirm that the image was built by a trusted workflow and published by the specified repository.

**Docker Hub:**

```shell
gh attestation verify oci://tmknom/prettier@sha256:31684fd957f78ddebd0fc003f2790da08bd7a41cfe1146912da43a114fbeebf9 \
  --deny-self-hosted-runners \
  --repo "tmknom/dockerfiles" \
  --cert-oidc-issuer "https://token.actions.githubusercontent.com" \
  --cert-identity "https://github.com/tmknom/dockerfiles/.github/workflows/reusable-release.yml@refs/heads/main"
```

**GitHub Container Registry:**

```shell
gh attestation verify oci://ghcr.io/tmknom/dockerfiles/prettier@sha256:31684fd957f78ddebd0fc003f2790da08bd7a41cfe1146912da43a114fbeebf9 \
  --deny-self-hosted-runners \
  --repo "tmknom/dockerfiles" \
  --cert-oidc-issuer "https://token.actions.githubusercontent.com" \
  --cert-identity "https://github.com/tmknom/dockerfiles/.github/workflows/reusable-release.yml@refs/heads/main"
```

<details>
<summary>Example output: verification succeeded</summary>

```shell
Loaded digest sha256:31684fd957f78ddebd0fc003f2790da08bd7a41cfe1146912da43a114fbeebf9 for oci://ghcr.io/tmknom/dockerfiles/prettier@sha256:31684fd957f78ddebd0fc003f2790da08bd7a41cfe1146912da43a114fbeebf9
Loaded 2 attestations from GitHub API
✓ Verification succeeded!
...
```
</details>

[docker_hub]: https://hub.docker.com/r/tmknom/prettier
[ghcr]: https://github.com/tmknom/dockerfiles/pkgs/container/dockerfiles%2Fprettier
