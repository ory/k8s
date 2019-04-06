# Using Hydra Helm chart for Kubernetes

## Requirements

Pass the following values to Helm runtime when deploying your Hydra service:

- `db.secretName` of a `Secret` resource `username` and `password`
  keys (base64 encoded; using `kubectl` or [manually][k8s-base64])
- `systemSecret` name of a `Secret` resource with a `system` key
  containing Hydra system secret.

TODO: Describe the deployment process and requirements

## Security

TODO: Describe the security measures

## Deployment

Use `strategy.autoMigrate` to add an `initContainer` that will run `hydra sql migrate` on startup.

Choose between singleton (admin & public in one) and separate deployment by setting `strategy.singleton` to `true` or `false` accordingly.

[k8s-base64]: https://kubernetes.io/docs/concepts/configuration/secret/#creating-a-secret-manually
