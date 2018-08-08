# k8s

An (experimental) collection of kubernetes configuration files for the ORY ecosystem.

## ORY Oathkeeper

### Simple: API-only with in-memory backend

This deployment example uses a very basic ORY Oathkeeper configuration with the `HS256` ID Token Credentials Issuer
and `DATABASE_URL=memory`.

Before you create it, you need to create the secret that will be used for `CREDENTIALS_ISSUER_ID_TOKEN_HS256_SECRET`:

```
$ kubectl create secret generic ory-oathkeeper --from-literal=CREDENTIALS_ISSUER_ID_TOKEN_HS256_SECRET=<your-secret>
# For example:
# $ kubectl create secret generic ory-oathkeeper --from-literal=CREDENTIALS_ISSUER_ID_TOKEN_HS256_SECRET=dYmTueb6zg8TphfZbOUpOewd0gt7u0SH
```

Then, create the `oathkeeper serve api` service and deployment:

```
kubectl apply -f yaml/oathkeeper/memory/oathkeeper-api.yaml
```

This example does not include setting up the oathkeeper proxy right now.
