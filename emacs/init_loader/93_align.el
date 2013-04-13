;; setting alignment
(eval-after-load "align"
  '(progn
     (add-to-list 'align-rules-list
                  '(camma-assignment
                    (regexp . ",\\( *\\)")
                    (repeat . t)
                    (modes  . '(cperl-mode))))))
