# [Lab 6 - Processes and Services](https://decal.ocf.berkeley.edu/archives/2020-fall/labs/b6)

## Which processes are running on my system?

#### (Exercise 1) Why do you think this behavior occurs?

```ps``` seems to list only the current shell process and its children

## htop

#### (Exercise 2) What resource specifically does the yes command exhaust?

CPU

## Orphan processes

#### (Exercise 3) What is its parent?

bash

## Cron

#### (Exercise 4) Open the cron editor by running crontab -e (if the editor of your choice isn’t being launched, set the EDITOR environment variable), which will create a crontab for your user. Below is a sample task. Put this in your crontab:

```* * * * * date +"\%T" >> $HOME/timestamps.txt```

Right now this runs every minute. Modify it to run every five minutes and make a note of the line you wrote. Then, quit out of the editor.


```0-59 * * * * date +"\%T" >> $HOME/timestamps.txt```

## Job Control

#### (Exercise 5) What happens when you suspend the job command?

The job was stopped by the OS, so the ```count``` file also stopped changing.

#### (Exercise 6) What happens after running the bg command?

The process continues executing, but now in the background, which means that it doesn't accept input from the command line, but it will still send its output (and errors) to the terminal.

#### (Exercise 7) What is another way we can kill the job (Hint: kill also recognizes the % syntax)?

```kill %1```

