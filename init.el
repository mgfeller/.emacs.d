; some from https://realpython.com/emacs-the-best-python-editor/
;; https://dougie.io/emacs/indentation/#highlighting-tabs-and-spaces-differently
(require 'package)

(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")
        ("gnu" . "https://elpa.gnu.org/packages/")
        ("org" . "https://orgmode.org/elpa/")))
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
    adoc-mode
    clojure-mode
    use-package
    smooth-scrolling
;;    material-theme
    powerline
    moe-theme
    ))

(mapc #'(lambda (package)
    (unless (package-installed-p package)
      (package-install package)))
      myPackages)

;; emacs-lis-mode
(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            (setq indent-tabs-mode nil)
            (setq tab-width 2)))

;; copy paste stuff
;; no effect in terminal, there kill/yank and copy/paste are completely divorced
(setq select-enable-clipboard t)

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

(setq org-todo-keywords
      '((sequence "TODO" "DOING" "|" "DONE" "CANCELLED")))

(setq org-agenda-files
      (cl-remove-if (lambda (k)
                      (string-match "/horizon/templates/" k))
                    (directory-files-recursively "~/horizon/" "\\.org$")))
(setq org-directory "~/horizon")
(setq org-tag-persistent-alist
      '(
        ("anthos")
        ("apigateway")
        ("aquasec")
        ("architecture")
        ("aspenmesh")
        ("association")
        ("automation")
        ("aws")
        ("azure")
        ("blog")
        ("book")
        ("brag")
        ("certificate")
        ("chaos")
        ("climate")
        ("coe")
        ("community")
        ("compliance")
        ("confluence")
        ("consul")
        ("cst")
        ("datamesh")
        ("definition")
        ("devops")
        ("dfds")
        ("documentation")
        ("environment")
        ("eventmesh")
        ("fagnett")
        ("food")
        ("gke")
        ("gke-on-prem")
        ("google")
        ("iac") ;; infrastructure as code
        ("ikea")
        ("istio")
        ("kong")
        ("kubernetes")
        ("k8s")
        ("kuma")
        ("linkerd")
        ("logging")
        ("mesh")
        ("meshery")
        ("metrics")
        ("monitoring")
        ("mtls")
        ("networking")
        ("nginx-sm")
        ("nsm") ;; network service mesh
        ("note")
        ("observability")
        ("osm") ;; open service mesh
        ("performance")
        ("personal")
        ("poc")
        ("private")
        ("product")
        ("publication")
        ("quote")
        ("raspberrypi")
        ("resource")
        ("security")
        ("servicemesh")
        ("soloio")
        ("term")
        ("technology")
        ("terraform")
        ("video")
        ("vsphere")
        ("zerotrust")
        )
)

;; set encoding to utf-8
(set-language-environment "UTF-8")

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

;; theme
;; (load-theme 'material-light t) ;; load material theme
;; https://github.com/kuanyui/moe-theme.el
(require 'powerline)
(require 'moe-theme)
(load-theme 'moe-dark t)
(powerline-moe-theme)
;;or
;;(load-theme 'moe-light t)

;; general config
(setq inhibit-startup-message t) ;; hide the startup message
(setq linum-format "%4d ")
(global-linum-mode t) ;; enable line numbers globally
(show-paren-mode t)
(setq show-paren-style 'expression)

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

;; asciidoc mode
(require 'adoc-mode)
(add-to-list 'auto-mode-alist '("\\.asc\\'" . adoc-mode))

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
 '(custom-safe-themes
   '("27a1dd6378f3782a593cc83e108a35c2b93e5ecc3bd9057313e1d88462701fcd" default))
 '(org-agenda-files
   '("~/horizon/gcp/sre.org" "~/horizon/gcp/stb.org" "~/horizon/ikea/ccoe-confluence-structure.org" "~/horizon/ikea/ikea.org" "~/horizon/ikea/service-mesh-poc.org" "~/horizon/log/archive/2019-12.org" "~/horizon/log/archive/2020-01.org" "~/horizon/log/archive/2020-02.org" "~/horizon/log/2021-01.org" "~/horizon/ssb/ssb.org" "~/horizon/stb/deployment.org" "~/horizon/stb/mesh.org" "~/horizon/Birthdays.org" "~/horizon/CheatSheet.org" "~/horizon/DevOps.org" "~/horizon/EmacsProgramming.org" "~/horizon/Fagnettverk.org" "~/horizon/InfrastructureTesting.org" "~/horizon/ToDo.org" "~/horizon/WorkMethods.org" "~/horizon/Zero0Trust.org" "~/horizon/a-devops-landscape.org" "~/horizon/architecture.org" "~/horizon/books.org" "~/horizon/career.org" "~/horizon/climate.org" "~/horizon/command-line.org" "~/horizon/drone-k3s-linkerd.org" "~/horizon/go-prog.org" "~/horizon/ideas.org" "~/horizon/kubernetes.org" "~/horizon/meshery-consul.org" "~/horizon/monitoring.org" "~/horizon/quizz.org" "~/horizon/quotes.org" "~/horizon/service-mesh.org" "~/horizon/sre.org" "~/horizon/terraform.org" "~/horizon/tools.org"))
 '(package-selected-packages
   '(moe-theme darktooth-theme org magit yaml-mode use-package smooth-scrolling scala-mode py-autopep8 origami material-theme markdown-mode json-mode groovy-mode flycheck elpy better-defaults)))
