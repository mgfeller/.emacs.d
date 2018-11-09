(add-to-list 'load-path "~/.emacs.d/lisp/")

(set-face-foreground 'minibuffer-prompt "white")

;; web-mode
;; wget https://raw.githubusercontent.com/fxbois/web-mode/master/web-mode.el
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.jinja\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))


;; Ido mode
;; https://wikemacs.org/wiki/Ido

(ido-mode)
(ido-everywhere 1)
(setq ido-case-fold t)


