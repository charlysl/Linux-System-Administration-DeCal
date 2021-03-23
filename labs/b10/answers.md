# [Lab 10 - Containers and Configuration Management](https://decal.ocf.berkeley.edu/archives/2020-fall/labs/b10)

## Running an interactive container

#### 1. What user are you logged in as by default in the container?

```root```

#### 2. If you start and then exit an interactive container, and then use the docker run -it ubuntu:latest command again; is it the same container? How can you tell?

It is not the same container; one way of telling is that any changes you made (like installing a package, configuration, creating a file, etc) will be gone.


