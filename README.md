# docker-gsutil_hugo
Hugo and gsutil for Google Cloud Storage on Docker for pipeline

### bitbucket-pipeline.yml
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
          - gsutil defacl ch -u AllUsers:R gs://<bucket name>

          # copy files over
          - gsutil -m rsync -d -R public gs://<bucket name>

          # set the main page suffix
          - gsutil web set -m index.html -e 404.html gs://<bucket name>
```
