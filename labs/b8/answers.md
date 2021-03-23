# [Lab 8 - Security Fundamentals (Fall 2020)](https://decal.ocf.berkeley.edu/archives/2020-fall/labs/b8)

## Encryption and Decryption

#### 1. Decrypt b8/file1.txt.gpg with the password ocfdecal (for real-life purposes, never store passwords in plaintext). What are the decrypted contents of b8/file1.txt.gpg?

#### 2. How does one import a key?

#### 3. How does one export a key to a file? (Add the --armor flag to ASCII-encode the key so it can be sent easily in text form)

#### 4. How does one see all of the keys on his/her keyring?

#### 5. Use this private key b8/privkey to decrypt b8/file2.txt.gpg (for real-life purposes, it is necessary to keep private keys secret). What are the decrypted contents of b8/file2.txt.gpg?

## Hashing (Checksums)

#### 1. What is the MD5 hash of b8/file3.txt?

#### 2. What is the SHA1 hash of the MD5 hash of b8/file3.txt? In other words, what is SHA1(MD5(file3.txt))?

## File Security

Run sudo setup.sh from decal-labs/b8/ before beginning this section.

#### 1. b8/file4.txt: What are the permissions of this file? Explain what they allow and disallow.

#### 2. b8/file5: Make this file executable and execute it. What is its printout?

#### 3. b8/file6.txt: Change this file to be under your ownership. What command did you use?

#### 4. b8/file7.txt: Make this file readable only to you. What command did you use?

#### 5. b8/file8.txt: Change this file’s permissions such that only root should be able to read this file and no one should be able to edit it. What command did you use?

#### 6. b8/file9.txt: Choose any method to make this file readable to you and unreadable to the previous owner. What command did you use?


