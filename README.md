# GCP gsutil+hugo+docker
Hugo and gsutil for Google Cloud Storage on Docker for Bitbucket's pipeline.

## Prerequisites

* Bitbucket Account
* GCP Account
* Boto conf file

### Dockerfile

The Dockerfile has the information to build the container for the pipeline. You can get the image from [DockerHub](https://hub.docker.com/r/lunardellir/gsutil-hugo).

```
docker pull lunardellir/gsutil-hugo
```

### Boto config file

* Location: /.boto

```
[Credentials]
gs_access_key_id = XXXXXXXXXX
gs_secret_access_key = XXXXXXXXXX
```

### bitbucket-pipeline.yaml

This is a sample bitbucket-pipeline.yaml file.

```
image: lunardellir/gsutil-hugo

pipelines:
  default:
    - step:
        script:
          #
          # Move gsutil credentials
          #
          - mv .boto ~/.boto

          #
          # Build Hugo Site
          #
          hugo

          #
          # Deploy site to Google Cloud Storage.
          #
          # update bucket permissions
          - gsutil -m defacl ch -u AllUsers:R gs://<bucket name>

          # copy files over
          - gsutil -m rsync -d -R public gs://<bucket name>

          # set the main page suffix
          - gsutil web set -m index.html -e 404.html gs://<bucket name>
```

## License

This project is licensed under the Apache-2.0 License - see the [LICENSE](LICENSE) file for details
