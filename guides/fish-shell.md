## Configure fish
Set `fish` as the default shell for current user.
```
echo "$USER" > username.txt
sudo usermod -s /usr/bin/fish $(cat username.txt)
rm -f username.txt
```

Configure `fish`
- run `fish_config` while in the fish shell.
- `set -U fish_greeting` to disable the default greeting.