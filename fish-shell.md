## Install, set and configure fish as the default shell
Install the `fish` shell.
```
run0 dnf install -y fish
```

Set `fish` as the default shell for current user.
```
echo "$USER" > username.txt
run0 usermod -s /usr/bin/fish $(cat username.txt)
rm -f username.txt
```

Configure `fish`
- Open `config.fish` : `kwrite ~/.config/fish/config.fish`
- Add/Change the following values.
```
if status is-interactive
# Commands to run in interactive sessions can go here

# Change the welcome message
set fish_greeting

# Replace nsudo with run0
alias nsudo '/usr/bin/run0'

end
```