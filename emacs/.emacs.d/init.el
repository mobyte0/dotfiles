;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ██╗███╗   ██╗██╗████████╗███████╗██╗      ;;
;; ██║████╗  ██║██║╚══██╔══╝██╔════╝██║      ;;
;; ██║██╔██╗ ██║██║   ██║   █████╗  ██║      ;;
;; ██║██║╚██╗██║██║   ██║   ██╔══╝  ██║      ;;
;; ██║██║ ╚████║██║   ██║██╗███████╗███████╗ ;;
;; ╚═╝╚═╝  ╚═══╝╚═╝   ╚═╝╚═╝╚══════╝╚══════╝ ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.milkbox.net/packages/"))
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
;(helm-autoresize-mode 1)
;(setq helm-autoresize-min-height 20)
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
(setq redisplay-dont-pause t
  scroll-margin 1
  scroll-step 1
  scroll-conservatively 10000
  scroll-preserve-screen-position 1)
;; Undo Tree
(load "lisp/undo-tree")
(global-undo-tree-mode)
(setq-default undo-tree-visualizer-timestamps t)
;; which-key
(load "lisp/emacs-which-key/which-key")
(which-key-mode)
(setq which-key-idle-delay 0.25)
;; neotree
(load "lisp/emacs-neotree/neotree")
(global-set-key [f6] 'neotree-toggle)
(setq neo-theme "ascii")
(setq-default neo-show-hidden-files t)

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
;; Blinking cursor
(blink-cursor-mode 1)
;; Disable menu and tool bars
(menu-bar-mode -1)
(tool-bar-mode -1)
;; Column 80 indicator
(load "lisp/Fill-Column-Indicator/fill-column-indicator")
(setq-default fci-rule-column 80)
(setq fci-handle-truncate-lines nil)
(define-globalized-minor-mode global-fci-mode fci-mode (lambda () (fci-mode 1)))
(global-fci-mode 1)
; snippet from https://www.emacswiki.org/emacs/FillColumnIndicator#toc17
(defun auto-fci-mode (&optional unused)
  (if (> (window-width) fci-rule-column)
      (fci-mode 1)
    (fci-mode 0))
  )
(add-hook 'after-change-major-mode-hook 'auto-fci-mode)
(add-hook 'window-configuration-change-hook 'auto-fci-mode)

;;; Indentation Settings
;; Enable smart tabs
(load "lisp/smart-tabs-mode")
(smart-tabs-insinuate 'c 'javascript)
(setq indent-tabs-mode t)
(setq-default tab-width 4)
(setq-default backward-delete-char-untabify-method nil)

;;; Keybindings
;; Yes to y and No to n
(defalias 'yes-or-no-p 'y-or-n-p)

;;; git packages
(load "lisp/dash.el/dash")
(load "lisp/dash.el/dash-functional")
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

;;; Syntax/spellchecking
;; Spellchecking
(add-hook 'text-mode-hook 'flyspell-mode)
(add-hook 'prog-mode-hook 'flyspell-prog-mode)
;; flycheck
(load "lisp/flycheck/flycheck")
(add-hook 'after-init-hook #'global-flycheck-mode)
; snippet from https://git.io/v7CzO
(defun toggle-flycheck-error-buffer ()
  (interactive) ;; Toggle a flycheck error buffer.
  (if (string-match-p "Flycheck errors" (format "%s" (window-list)))
      (dolist (w (window-list))
        (when (string-match-p "*Flycheck errors*"
			      (buffer-name (window-buffer w)))
          (delete-window w)
          ))
    (flycheck-list-errors)
    )
  )
(global-set-key (kbd "<f5>") 'toggle-flycheck-error-buffer)
; snippet from https://git.io/v7CzU
(defadvice flycheck-error-list-refresh (around shrink-error-list activate)
  ad-do-it
  (-when-let (window (flycheck-get-error-list-window t))
    (with-selected-window window
      (fit-window-to-buffer window 10))))

;;; Coding Modes
;; web-mode
; snippets from http://web-mode.org/
(add-to-list 'load-path "~/.emacs.d/lisp/web-mode")
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(setq web-mode-enable-auto-closing t)
(setq web-mode-enable-auto-pairing t)
(defun main-web-mode-hook ()
  "Main hooks, indentation, etc."
  (web-mode-use-tabs)
  (setq web-mode-markup-indent-offset 4)
)
(add-hook 'web-mode-hook 'main-web-mode-hook)

;;; File management
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

;;; Other various emacs packages
(load "lisp/try")
