;; not display password in shell-mode
(add-hook 'comint-output-filter-functions
          'comint-watch-for-password-prompt)
