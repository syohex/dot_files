# My Emacs Configuration Files

## Requirements

- Emacs 24.3 or higher
- [curl](http://curl.haxx.se/)
- [cask](http://cask.github.io/)


## Launch Emacs same as my configuration

Please execute following command

```
% git clone git@github.com/syohex/dot_files.git
% cd dot_files/emacs
% curl -fsSkL https://raw.github.com/cask/cask/master/go | python
% cask install
% emacs -Q -l setup.el
```
