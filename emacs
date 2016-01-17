;; General settings
(defalias 'yes-or-no-p 'y-or-n-p) ; y or n is much easier than yes or no
(global-linum-mode t) ; line numbering
(setq linum-format "%4d \u2502")
(column-number-mode 1) ; columns
(menu-bar-mode -1) ; remove the menu bar at the top
(add-to-list 'load-path "~/.emacs.d/lisp/") ; adding lisp folder to load-path
(electric-indent-mode t) ; disable the indenting...
(show-paren-mode 31) ; show matching parenthesis

;; Session history
(require 'session)
(add-hook 'after-init-hook 'session-initialize)

;; Theme
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(load-theme 'cyberpunk t)
(defun on-after-init ()
  (unless (display-graphic-p (selected-frame))
    (set-face-background 'default "unspecified-bg" (selected-frame))))
(add-hook 'window-setup-hook 'on-after-init)

;; Backup files
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; MELPA
(require 'package)
(add-to-list 'package-archives
'("melpa" . "http://melpa.org/packages/") t)
(when (< emacs-major-version 24)

;; For important compatibility libraries like cl-lib
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)

;; Python

