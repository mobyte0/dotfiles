;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ██╗███╗   ██╗██╗████████╗███████╗██╗      ;;
;; ██║████╗  ██║██║╚══██╔══╝██╔════╝██║      ;;
;; ██║██╔██╗ ██║██║   ██║   █████╗  ██║      ;;
;; ██║██║╚██╗██║██║   ██║   ██╔══╝  ██║      ;;
;; ██║██║ ╚████║██║   ██║██╗███████╗███████╗ ;;
;; ╚═╝╚═╝  ╚═══╝╚═╝   ╚═╝╚═╝╚══════╝╚══════╝ ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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
(global-set-key (kbd "M-x") #'helm-M-x)
(global-set-key (kbd "C-x r b") #'helm-filtered-bookmarks)
(global-set-key (kbd "C-x C-f") #'helm-find-files)
(helm-mode 1)
;; Display line numbers
(load "lisp/nlinum-1.7")
(global-nlinum-mode)
;; Display current line number
(global-hl-line-mode t)
;; Display row and column numbers in the mode line
(setq-default column-number-mode t)
;; Smooth scrolling
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; scroll one line at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
(setq scroll-step 1) ;; keyboard scroll one line at a time
;; Undo Tree
(load "lisp/undo-tree")
(global-undo-tree-mode)
(setq-default undo-tree-visualizer-timestamps t)

;;; Setup Appearance
;; Enable color theme
(load "themes/monokai-emacs/monokai-theme")
;; Enable color theme for new frames
(add-hook 'after-make-frame-functions
	  (lambda (frame)
	    (select-frame frame)
	    (load-theme 'monokai t)))
;; Disable visual scroll bar
(add-to-list 'default-frame-alist
             '(vertical-scroll-bars . nil))
;; Disable menu and tool bars
(menu-bar-mode -1)
(tool-bar-mode -1)
;; Highlight tail
;(load "lisp/highlight-tail")
;(require 'highlight-tail)
;(setq highlight-tail-colors '(
;			      ("#434c5e" . 0)
;			      ("#3b4252" . 40)
;			      ("#2e3440" . 80)
;			      ))
;(setq highlight-tail-steps 150
;      highlight-tail-timer 0.01)
;(setq highlight-tail-posterior-type 't)
;(highlight-tail-mode)
;(highlight-tail-reload)

;;; Indentation Settings
;; Enable smart tabs
(load "lisp/smart-tabs-mode")
(smart-tabs-insinuate 'c 'javascript)
(setq-default backward-delete-char-untabify-method nil)

;;; Keybindings
;; Yes to y and No to n
(defalias 'yes-or-no-p 'y-or-n-p)

;;; git packages
(load "lisp/dash.el/dash")
(load "lisp/dash.el/dash-functional.el")
(load "lisp/with-editor/with-editor")
(load "lisp/diff-hl/diff-hl")
(load "lisp/diff-hl/diff-hl-flydiff")
(add-to-list 'load-path "~/.emacs.d/lisp/magit/lisp")
(require 'magit)
(with-eval-after-load 'info
  (info-initialize)
  (add-to-list 'Info-directory-list
               "~/.emacs.d/lisp/magit/Documentation/"))
(global-diff-hl-mode t)
(diff-hl-flydiff-mode t)
(setq diff-hl-side 'right)
(setq diff-hl-fringe-bmp-function 'diff-hl-fringe-bmp-from-type)
(custom-set-faces
 '(diff-hl-change ((t (:foreground "background"))))
 '(diff-hl-insert ((t (:foreground "background"))))
 '(diff-hl-delete ((t (:foreground "background")))))
(add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh)

;;; File management
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

;;; Other various emacs packages
(load "lisp/try.el")
