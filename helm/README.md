# Helm Charts

## Development

To test a chart locally without applying it to kubernetes, do:

```sh
$ helm install --debug --dry-run .
```

### Testing

To run helm test, to:

```sh
$ helm lint .
$ helm install .
$ helm test --cleanup <name>
```

### Remove all releases

To remove **all releases (only in test environments)**, do:

```sh
$ helm del $(helm ls --all --short) --purge
```
