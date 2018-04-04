
#!/bin/sh


echo "Renewed domains: $RENEWED_DOMAINS" 
SECNAME="secret-tls-"$(printf $RENEWED_DOMAINS  | cut -d' ' -f1  | tr '.' '-' | sed s/^\*-//)

echo "Delete existing secret $SECNAME"
kubectl delete --ignore-not-found=true secret $SECNAME || echo "Secret does not yet exist"
kubectl create $KCTLARGS secret tls $SECNAME \
--cert $RENEWED_LINEAGE/fullchain.pem \
--key $RENEWED_LINEAGE/privkey.pem || exit 1

echo "Created secret $SECNAME for $RENEWED_DOMAINS"