# My Emacs Configuration Files

## Requirements

- Emacs 24.5 or higher
- [curl](http://curl.haxx.se/)
- [cask](http://cask.github.io/)


## Launch Emacs same as my configuration

Please execute following command

```bash
% git clone https://github.com/syohex/dot_files.git
% cd dot_files/emacs
% curl -fsSL https://raw.githubusercontent.com/cask/cask/master/go | python
% cask install
% emacs -Q -l setup.el
```
