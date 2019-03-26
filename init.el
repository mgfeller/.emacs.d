;; some from https://realpython.com/emacs-the-best-python-editor/
(require 'package)

(add-to-list 'package-archives
       '("melpa" . "http://melpa.org/packages/") t)

(package-initialize)

(package-refresh-contents)

(defvar myPackages
  '(better-defaults
    flycheck
    elpy ;; python https://elpy.readthedocs.io/en/latest/ide.html
    py-autopep8 ;; requires autopep8 installed using e.g. pip
    json-mode
    groovy-mode
    markdown-mode
    yaml-mode
    use-package
    smooth-scrolling
    material-theme))

(mapc #'(lambda (package)
    (unless (package-installed-p package)
      (package-install package)))
      myPackages)

(require 'use-package)

(use-package scala-mode
  :interpreter
  ("scala" . scala-mode))

(setq inhibit-startup-message t) ;; hide the startup message
(load-theme 'material t) ;; load material theme

(setq linum-format "%4d ")
(global-linum-mode t) ;; enable line numbers globally

;; show cursor position within line
(column-number-mode 1)

;; enable elpy python and related packages
(elpy-enable)

(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

;; https://elpy.readthedocs.io/en/latest/ide.html#interpreter-setup
(setq python-shell-interpreter "ipython"
      python-shell-interpreter-args "-i --simple-prompt")

(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)
(setq py-autopep8-options '("--max-line-length=132"))

(add-hook 'python-mode-hook
      (lambda ()
        (setq indent-tabs-mode nil)
        (setq tab-width 4)
        (setq python-indent-offset 4)))

;; 

(add-to-list 'load-path "~/.emacs.d/lisp/")

(set-face-foreground 'minibuffer-prompt "white")

(when (fboundp 'electric-indent-mode) (electric-indent-mode -1))

;; groovy-mode
(require 'groovy-mode)
(add-to-list 'auto-mode-alist '("Jenkinsfile" . groovy-mode))

;; bats-mode
(require 'bats-mode)
(add-to-list 'auto-mode-alist '("\\.bats\\'" . bats-mode))

;; yaml-mode
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.yaml\\'" . yaml-mode))

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
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (material-theme py-autopep8 elpy flycheck better-defaults))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; smooth scrolling (not by page)
(require 'smooth-scrolling)
(smooth-scrolling-mode 1)
(setq smooth-scrolling-margin 5)
