## Git

### GitHub

Finding all issues that you commented on can be very helpful
as a history view of your activity:

https://github.com/issues?q=is%3Aissue+commenter%3Asteabert

### Signing

Creating a GPG key:

```
gpg --full-generate-key 
```

Listing GPG keys with the ID to use in git config:

```shell
gpg --list-secret-keys --keyid-format LONG
```
