# [Lab 10 - Containers and Configuration Management](https://decal.ocf.berkeley.edu/archives/2020-fall/labs/b10)

## Running an interactive container

#### 1. What user are you logged in as by default in the container?

```root```

#### 2. If you start and then exit an interactive container, and then use the docker run -it ubuntu:latest command again; is it the same container? How can you tell?

It is not the same container; one way of telling is that any changes you made (like installing a package, configuration, creating a file, etc) will be gone.

## Dockerfiles

#### 1. Run the image you just built with no flags. What do you observe?

![Missile](./missile.png)

#### 2. Write and build a Dockerfile based on ubuntu:bionic that installs the packages fortune and fortunes-min and runs the fortune executable (located in /usr/games/fortune after you install it). Note that you won’t need to use the -it flags when you run the container as fortune doesn’t need STDIN. Submit your Dockerfile with this lab. Hint: if you’re having trouble writing your Dockerfile, try booting an interactive container and installing both packages. How can you translate what you did interactively to a Dockerfile?

```
FROM	ubuntu:bionic
RUN	apt update && apt install -y fortunes fortunes-min
CMD	["/usr/games/fortune"]
```

#### 3. Paste the output of running docker images command after completing questions 1 and 2.

```
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
fortunes            latest              930407a25363        32 minutes ago      104MB
missile             latest              e96586a191e8        54 minutes ago      545MB
hello-world         latest              d1165f221234        2 weeks ago         13.3kB
ubuntu              latest              4dd97cefde62        2 weeks ago         72.9MB
ubuntu              bionic              329ed837d508        2 weeks ago         63.3MB
fedora              latest              33c4a622f37c        4 weeks ago         177MB
```

