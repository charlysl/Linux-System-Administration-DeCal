# [Lab 8 - Security Fundamentals (Fall 2020)](https://decal.ocf.berkeley.edu/archives/2020-fall/labs/b8)

## Encryption and Decryption

Used [Quick'n easy gpg cheatsheet](http://irtfweb.ifa.hawaii.edu/~lockhart/gpg/)

#### 1. Decrypt b8/file1.txt.gpg with the password ocfdecal (for real-life purposes, never store passwords in plaintext). What are the decrypted contents of b8/file1.txt.gpg?

```
$ gpg --decrypt file1.txt.gpg 
gpg: AES encrypted data
gpg: encrypted with 1 passphrase
Quack
```

#### 2. How does one import a key?

```
gpg --import *public.key*
```

#### 3. How does one export a key to a file? (Add the --armor flag to ASCII-encode the key so it can be sent easily in text form)

```
gpg --export -a "*User Name*" >*public.key*
```

#### 4. How does one see all of the keys on his/her keyring?

```
gpg --list-keys
```

#### 5. Use this private key b8/privkey to decrypt b8/file2.txt.gpg (for real-life purposes, it is necessary to keep private keys secret). What are the decrypted contents of b8/file2.txt.gpg?

```
$ gpg --import lab8privkey 
gpg: key 869E6CEC: secret key imported
gpg: key 869E6CEC: public key "lab8privkey" imported
gpg: Total number processed: 1
gpg:               imported: 1  (RSA: 1)
gpg:       secret keys read: 1
gpg:   secret keys imported: 1
$ gpg --decrypt file2.txt.gpg 
gpg: NOTE: secret key 21C1D38D expired at Sat Oct 31 02:00:59 2020 +07
gpg: encrypted with 2048-bit RSA key, ID 21C1D38D, created 2018-10-31
      "lab8privkey"
Woof
```

## Hashing (Checksums)

#### 1. What is the MD5 hash of b8/file3.txt?

```
$ md5sum file3.txt
ddbefc9c1d8a8d9195a420a7181352e9  file3.txt
```

#### 2. What is the SHA1 hash of the MD5 hash of b8/file3.txt? In other words, what is SHA1(MD5(file3.txt))?

```
$ md5sum file3.txt | awk '{ print $1 }' | sha1sum
15c3d7fa41fcc2ed98c2fda065e3248047a048f4
```


## File Security

Run sudo setup.sh from decal-labs/b8/ before beginning this section.

#### 1. b8/file4.txt: What are the permissions of this file? Explain what they allow and disallow.

```
$ ls -l file4.txt 
-rw-r--r-- 1 nobody user 15 Mar 23 12:25 file4.txt
```

Everybody can read the file, nobody can write it (except for root).

#### 2. b8/file5: Make this file executable and execute it. What is its printout?

```
$ ls -l file5 
-rw-rw-r-- 1 user user 8640 Mar 22 12:49 file5
$ chmod +x file5
$ ./file5
aching flair
```

#### 3. b8/file6.txt: Change this file to be under your ownership. What command did you use?

```
$ ls -l file6.txt 
-r-------- 1 nobody user 21 Mar 23 12:25 file6.txt
$ sudo chown user file6.txt
$ cat file6.txt
heuristic adventurer
```

#### 4. b8/file7.txt: Make this file readable only to you. What command did you use?

```
$ ls -l file7.txt 
-r-------- 1 nobody user 21 Mar 23 12:25 file7.txt
$ sudo chown user:nogroup file7.txt
$ ls -l file7.txt 
-r-------- 1 user nogroup 21 Mar 23 12:25 file7.txt
$ cat file7.txt 
astute interrogation
```

#### 5. b8/file8.txt: Change this file’s permissions such that only root should be able to read this file and no one should be able to edit it. What command did you use?

```
$ ls -l file8.txt 
-rwxrwxrwx 1 nobody user 20 Mar 23 12:25 file8.txt
$ sudo chown root:root file8.txt
$ sudo chmod 400 file8.txt
$ ls -l file8.txt 
-r-------- 1 root root 20 Mar 23 12:25 file8.txt
$ sudo cat file8.txt 
furious scaffolding
```
#### 6. b8/file9.txt: Choose any method to make this file readable to you and unreadable to the previous owner. What command did you use?

```
$ ls -l file9.txt 
-rwxrwxrwx 1 nobody user 19 Mar 23 12:25 file9.txt
$ sudo chmod 040 file9.txt
$ ls -l file9.txt 
----r----- 1 nobody user 19 Mar 23 12:25 file9.txt
$ cat file9.txt 
abrupt compunction
```

