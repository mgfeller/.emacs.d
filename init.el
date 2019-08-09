;; some from https://realpython.com/emacs-the-best-python-editor/
;; https://dougie.io/emacs/indentation/#highlighting-tabs-and-spaces-differently
(require 'package)

(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")
        ("gnu" . "https://elpa.gnu.org/packages/")
        ("org" . "http://orgmode.org/elpa/")))
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
    magit
    org
    kubernetes
    yaml-mode
    use-package
    smooth-scrolling
    material-theme))

(mapc #'(lambda (package)
    (unless (package-installed-p package)
      (package-install package)))
      myPackages)

;; emacs-lis-mode
(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            (setq indent-tabs-mode nil)
            (setq tab-width 2)))


;; file stuff
;; recent files
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(setq recentf-max-saved-items 25)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)
(run-at-time nil (* 5 60) 'recentf-save-list)

;; tab stuff
(setq default-tab-width 2)

(global-whitespace-mode)
(setq whitespace-style '(face tabs tab-mark trailing))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(whitespace-tab ((t (:foreground "#636363")))))

(setq whitespace-display-mappings
  '((tab-mark 9 [124 9] [92 9])))

;; (setq tab-stop-list (number-sequence 4 120 4))

;; org mode
;; The following lines are always needed.  Choose your own keys.
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)
(global-set-key (kbd "C-c b") 'org-switchb)
(add-hook 'org-mode-hook
          (lambda ()
            (setq indent-tabs-mode nil)
            (setq tab-width 2)))


(setq org-agenda-files (directory-files-recursively "~/horizon/" "\\.org$"))
(setq org-directory "~/horizon")

;; magit
(global-set-key (kbd "C-x g") 'magit-status)

;; kubernetes
(use-package kubernetes
  :ensure t
  :commands (kubernetes-overview))

;; scala-mode
(require 'use-package)

(use-package scala-mode
  :interpreter
  ("scala" . scala-mode))

;; general config
(setq inhibit-startup-message t) ;; hide the startup message
(load-theme 'material t) ;; load material theme

(setq linum-format "%4d ")
(global-linum-mode t) ;; enable line numbers globally

;; show cursor position within line
(column-number-mode 1)

(setq-default fill-column 132)

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

(setq indent-tabs-mode nil
      js-indent-level 2)
;;

(add-to-list 'load-path "~/.emacs.d/lisp/")

(set-face-foreground 'minibuffer-prompt "white")

(when (fboundp 'electric-indent-mode) (electric-indent-mode -1))

;; groovy-mode
(require 'groovy-mode)
(add-to-list 'auto-mode-alist '("Jenkinsfile" . groovy-mode))
(setq groovy-indent-offset 2) ;; was 4, meaning 4 tabs to next indent level

;; bats-mode
(require 'bats-mode)
(add-to-list 'auto-mode-alist '("\\.bats\\'" . bats-mode))

;; yaml-mode
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.yaml\\'" . yaml-mode))
(add-hook 'yaml-mode-hook
      (lambda ()
        (setq indent-tabs-mode nil)
        (setq tab-width 2)))

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

;; smooth scrolling (not by page)
(require 'smooth-scrolling)
(smooth-scrolling-mode 1)
(setq smooth-scrolling-margin 5)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
	 (quote
		(org magit yaml-mode use-package smooth-scrolling scala-mode py-autopep8 origami material-theme markdown-mode json-mode groovy-mode flycheck elpy better-defaults))))
