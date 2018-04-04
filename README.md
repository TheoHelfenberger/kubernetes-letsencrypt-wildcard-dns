# kubernetes-letsencrypt-wildcard-dns
Kubernetes job to obtain and renew letsencrypt certificates via dns challenge. Only dns challenge supports wildcard certificates.
Certificates will be stored in a kubernetes tls secret so they can easily be used in [ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/#tls).

Special for Google Cloud Kubernetes. 

## Prerequisites
1. Need to authenticate wiht the Goolge cloud platform to uŝe DNS. 
[Create a serive account and store the key in a secret](https://cloud.google.com/kubernetes-engine/docs/tutorials/authenticating-to-cloud-platform) to be consumed by the certbot jobs. The secret shoud be named 'google-cloud-key'
2. [Create persistence storage](https://cloud.google.com/kubernetes-engine/docs/tutorials/persistent-disk) 1 GB for the certbot data for renewal. Name the disk 'certbot-disk'


## Install
Create service account which is used to run job. Needs Edit permission to create tls secret.

`kubectl -f sa-certbot.yaml`

Create config map with certificate request data. Change to your need first!
Be aware that the [staging environment](https://letsencrypat.org/docs/staging-environment/) is activated

` kubectl -f cfg-kubecertbot.yaml`

Run the certbot job which request the letsencrypt certs for you domain via dns01 challenge

`kubectl -f job-certbot.yaml`

To renew a certificate create CronJob which checks for certs which need updates. Can be run daily. As nothing will be changed if the certificate is not due to renewal.

`kubectl -f job-renewal-certbot.yaml`

## Configuration
Change config map to your needs. After each successful job run existing secret will be removed and a new one create. 
Name of the tls secret is created from the first domain in the certbot request.

`*.example.com -> secret-tls-example-com`

