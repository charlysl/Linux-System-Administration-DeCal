My answers to [Beginner Lab 1 - Unix, the Shell, OSS](https://decal.ocf.berkeley.edu/archives/2020-fall/labs/b1)
## Shell spelunking

### 3. Go into the b01 directory. Make sure you’re in there by running pwd (Present working directory). **What does pwd give you (conceptually)?**

The process' working directory (the process in this particular case would be the shell) 

### 4. There’s a hidden file in the b01 directory. What is the secret?

```
$ ls -a b01
$ cat b01/.secret 
hunter2
```

### 5. A malicious user made its way into my computer and created a message split across all the files in nonsense/. What does it say? **How did you find the message?** (Hint: xargs and ls will be helpful here.)

```
% cd b01/nonsense
% ls | xargs cat | xargs
s t a n f o r d > b e r k e l e y
```

### 6. Go ahead and delete everything in nonsense/ with one command. **How did you do it?**

```
% rm *
```

### 7. There’s a file in b01 called big_data.txt. It’s 80 megabytes worth of random text. For reference, Leo Tolstoy’s “War and Peace”, the novel with a whopping 57,287 words depicting the French invasion of Russia and the impact of the Napoleonic era on Tsarist society through the stories of five Russian aristocratic families with several chapters solely dedicated to philosophical prose, is only 3.2 megabytes large.

### For that reason, I don’t recommend using cat to print the file. You can try it, but you’ll be sitting there for a while. There’s some text you need to find in there! Go find it without actually opening up the file itself!

### Two lines above the only URL in the file is a secret solution. **What is that solution?**

### Hints: What makes up a URL (https…)? What is Context Line Control?

[Context lines are non-matching lines that are near a matching line.](https://www.gnu.org/software/grep/manual/html_node/Context-Line-Control.html)

```
% grep -B 2 https big_data.txt 
=================== THE SOLUTION IS MORE COFFEE ===============================
hl)V:}mntUS4;iC':uH|G(;y6Ir;4uNLLRC?GDfRP%o+g]s$NCL9zM'SK[IV.e<i&_3&7L7NBL41N#f
;=:P0viNjebvs<+^Ae.SZYG'F}\> https://xkcd.com/705 e[a3]vF;Ny,*rpyC?3OA$Nm<.iH8M
```

### 8. Try executing ./a_script. You should get something back that says permission denied: ./a_script. This is because files have three different permissions: read, write, and execute. **Which one does a_script need?** Change the file permissions so that you can run the script. **How did you do it?**

It needs execute permissions.

```
% chmod +x a_script
./a_script 
Hello World!
```

### 9. Finally, there’s an empty file called hello_world in the directory. Write your name in it! **How did you do it?**

```
% echo your name > hello_world
% cat hello_world 
your name
```

## General Questions

### 1. What differentiates Linux/OSX from operating systems like Windows?

They are UNIX-like

## 2. What are some differences between the command line and normal (graphical) usage of an OS?

The command line is more efficient and scriptable, better for advanced users, whereas GUIs are easier to use for novices.

### 3. What is the root directory in Linux filesystems? Answer conceptually, as in depth as you would like,

It is the only directory that doesn't have a parent directory.

### 4. ls has a lot of cool arguments. Try using them to get extra information such as file permissions, owner name, owner group, file size, and late date edited. In addition, I want to be able to see the size and have the files ordered by last date edited, with the oldest files on top. **How would I do this?**

```
% ls -lrt
```

### 5. Instead of showing the first 10 lines of the file big_data.txt, I want to use the head command to show the first 4. How would I do that?

```
head -4 big_data.txt | wc -l
```

### 6. What’s the difference between cat foo > out.txt and cat foo >> out.txt?

The former will create (or clobber) a file; whereas the latter will append to a file.

## Culture Questions

### Briefly, what is the difference between permissive and copyleft licenses?

The latter requires that any changes must be shared with the same license.

### Give an example of a permissive license.

MIT

### Give an example of (a) open-source software and (b) free, but closed-source software that you use.

(a) Linux

(b) VMWare Fusion Player
 

