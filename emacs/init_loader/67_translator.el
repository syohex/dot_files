;; text-translator
(require 'text-translator)
(setq text-translator-auto-selection-func
      'text-translator-translate-by-auto-selection-enja)

(push '("*translated*" :stick t) popwin:special-display-config)
