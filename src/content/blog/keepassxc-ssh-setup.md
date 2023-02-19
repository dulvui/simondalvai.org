+++
title = "How to setup your ssh agent with KeePassXC"
description = "Use your KeePassXC file to so securely store your SSH keys"
date = 2023-01-29
updated = 2023-01-29
draft = true
aliases = ["kss"]
+++

[KeePassXC](https://keepassxc.org/) is a powerful password manager, that allows you to generate, save and organize your passwords in one file and sync it with all your devices, using your cloud storage service like [Nextcloud](https://nextcloud.com/) or other services of your choice.  
One of its additional key features is the `built-in ssh agent integration`.
With that you can protect your ssh keys with a passphrase and using your KeePassXC file as a backup for your keys, because with this setup, you will have only the public keys the filesystem of the machine and the private ones are saved in the KeePassXC file.
So you don't have to worry about loosing or your ssh keys and you will have them protected with a strong passphrase.  
Actually I just realized that by saving your private keys in KeePassXC file, you should be save enough and a passphrase is not needed.
But lets see anyway how the full setup works.

## Generating a ssh key with a passphrase
If you already have an ssh key you can skip this step.  
You can generate a key with the `ssh-keygen` command.
It will ask you a passphrase

```bash
dulvui@thinkpad:~$ ssh-keygen 
Generating public/private rsa key pair.
Enter file in which to save the key (/home/dulvui/.ssh/id_rsa):
Enter passphrase (empty for no passphrase): 
Enter same passphrase again: 
Your identification has been saved in my-key
Your public key has been saved in my-key.pub
SHA256:0TmdThrWxaf/zjqtv5UZkm5z2iErPz/gk7PFZ/BkbGY dulvui@thinkpad
The key s randomart image is:
+---[RSA 3072]----+
|             ..  |
|         . + o. .|
|        . * =  o |
|         o *  o. |
|        S . .o.oE|
|            ..oO=|
|            .=oO*|
|           ..*X+*|
|            o=OX*|
+----[SHA256]-----+
```