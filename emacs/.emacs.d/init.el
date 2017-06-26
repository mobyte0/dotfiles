(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(add-to-list 'load-path "~/.emacs.d")
(package-initialize)

;;; Interface Settings
;; Load helm and its dependencies
(load "lisp/popup")
(load "lisp/emacs-async/async")
(load "lisp/emacs-async/dired-async")
(autoload 'dired-async-mode "lisp/emacs-async/dired-async.el" nil t)
(dired-async-mode 1)
(add-to-list 'load-path "~/.emacs.d/lisp/helm")
(require 'helm-config)
;; Display line numbers
(load "lisp/nlinum-1.7")
(global-nlinum-mode)
;; Display row and column numbers in the mode line
(setq-default column-number-mode t)
;; Smooth scrolling
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; scroll one line at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
(setq scroll-step 1) ;; keyboard scroll one line at a time

;;; Setup Appearance
;; Enable color theme
(load "themes/nord/nord-theme")
;; Enable color theme for new frames
(add-hook 'after-make-frame-functions
	  (lambda (frame)
	    (select-frame frame)
	    (load-theme 'nord t)))
;; Disable visual scroll bar
(add-to-list 'default-frame-alist
             '(vertical-scroll-bars . nil))
;; Disable menu and tool bars
(menu-bar-mode -1)
(tool-bar-mode -1)

;;; Indentation Settings
;; Enable smart tabs
(load "lisp/smart-tabs-mode")
(smart-tabs-insinuate 'c 'javascript)
(setq-default backward-delete-char-untabify-method nil)

;;; Keybindings
;; Yes to y and No to n
(defalias 'yes-or-no-p 'y-or-n-p)

;;; Loading magit and its dependencies
(load "lisp/dash.el/dash")
(load "lisp/dash.el/dash-functional.el")
(load "lisp/with-editor/with-editor")
(add-to-list 'load-path "~/.emacs.d/lisp/magit/lisp")
(require 'magit)
(with-eval-after-load 'info
  (info-initialize)
  (add-to-list 'Info-directory-list
               "~/.emacs.d/lisp/magit/Documentation/"))

;;; File management
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

;;; Other various emacs packages
(load "lisp/try.el")

