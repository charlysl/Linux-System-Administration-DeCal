# [Lab 10 - Containers and Configuration Management](https://decal.ocf.berkeley.edu/archives/2020-fall/labs/b10)

## Getting started with Docker

### Running an interactive container

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

## Dockerizing a Web Server

#### 1. While your three containerized Apache web servers are running in detached mode, paste the output of docker ps.

```
CONTAINER ID        IMAGE               COMMAND              CREATED             STATUS              PORTS                  NAMES
2d77f08eca23        httpd:latest        "httpd-foreground"   2 minutes ago       Up 2 minutes        0.0.0.0:4002->80/tcp   adoring_buck
386a2752f34c        httpd:latest        "httpd-foreground"   2 minutes ago       Up 2 minutes        0.0.0.0:4001->80/tcp   cool_hopper
572afdcdf88d        httpd:latest        "httpd-foreground"   2 minutes ago       Up 2 minutes        0.0.0.0:4000->80/tcp   crazy_kapitsa
```

#### 2. Observe that in the output of docker ps, each container has an associated container ID. Explain why containers have IDs/Names rather than being named after the image, for example httpd.

A same image can be ran any number of times, so naming containers after them would be ambigious.

In a way, container ids are a like process ids, they have to be unique inside a particular system, whereas image names are bit like binary paths.

#### 3. Now go ahead and stop your containers. Paste the command you used to stop one of the containers.

```
sudo docker stop 2d77f08eca23
```

## Getting started with Puppet

#### 1. Submit your completed quotes.pp file.

```
package { 'curl': } # What package is required for this script to run?

group { 'quotegather':
  ensure  => present, # Do we want the group on this system?
}
user { 'quotes':
  ensure  => present, # Do we want the user on this system?
  gid     => 'quotegather', # Note that we can pass a group name to gid
  home    => '/tmp',
  shell   => '/bin/false',
  # Do not create the user quotes unless the quotegather group exists
  require => Group['quotegather'],
}


cron { 'getquote':
  user     => 'quotes', # Which user do we want to run this cron job?
  # You can ignore this, it pulls the quotes from an API and appends
  # them to a file.
  command  => "curl 'https://api.kanye.rest/?format=text' >> quotes && echo >> quotes",
  minute   => '0-58/2', # Hint: passing * means this runs every minute
}
```

##### Extra: also wrote ```rm-puppet.pp```, to undo the above.

```
group { 'quotegather':
  ensure  => absent
}
user { 'quotes':
  ensure  => absent
}

cron { 'getquote':
  ensure => absent
}
```

