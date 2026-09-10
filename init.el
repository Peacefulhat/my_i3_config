;; My UI Changes
(tool-bar-mode 0)                 ;; Disable tool bar
(menu-bar-mode 0)                 ;; Disable menu bar
(scroll-bar-mode 0)               ;; Disable scroll bar
(fringe-mode 0)                   ;; Disable fringe (border area)
(global-hl-line-mode 1)
(global-display-line-numbers-mode 1)  ;; Enable line numbers globally
(setq display-line-numbers-type 'relative)
(set-face-attribute 'default nil :height 160)
(add-hook 'dired-mode-hook (lambda () (dired-hide-details-mode 0)))
;; dired mode copy
(setq dired-recursive-copies 'always)
(setq dired-dwim-target t)
;; keysound disable
(setq ring-bell-function 'ignore)

;; No backup or autosave files
(setq make-backup-files nil)
(setq auto-save-default nil)

;; Tabs to spaces
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq python-indent-offset 4)
(add-hook 'prog-mode-hook (lambda () (setq tab-width 4)))

;; font
(set-frame-font "Fira Code" t t)
;; Line/column info
(column-number-mode 1)

;; Enable IDO 
(ido-mode 1)  
(ido-everywhere 1)

;; Package setup
(require 'package)
(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")
        ("gnu" . "https://elpa.gnu.org/packages/")))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Ensure use-package is installed
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

;; gruber-darker-theme (by Mr. Tsoding)
(use-package gruber-darker-theme
  :config
  (load-theme 'gruber-darker t))

;; Smex
(use-package smex
  :config
  (smex-initialize)
  (global-set-key (kbd "M-x") 'smex))

;; Company mode (autocomplete)
(use-package company
  :config
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 3)
  (global-company-mode 1))

;; Rainbow mode
(use-package rainbow-mode
  :hook ((css-mode
          html-mode
          web-mode)
         . rainbow-mode)
  :bind
  ("C-c c" . rainbow-mode))

;; Multiple cursors
(use-package multiple-cursors
  :bind
  (("C-c C-c" . mc/edit-lines)
   ("C->"     . mc/mark-next-like-this)
   ("C-<"     . mc/mark-previous-like-this)
   ("C-c C-<" . mc/mark-all-like-this)
   ("C-\""    . mc/skip-to-next-like-this)
   ("C-:"     . mc/skip-to-previous-like-this)))


;; Move-text
(use-package move-text
  :bind
  (("M-n" . move-text-down)
   ("M-p" . move-text-up)))


;; local .el files
(add-to-list 'load-path "~/.emacs.d/emacs.local/")

;; Simp-C mode
(require 'simpc-mode)
(add-to-list 'auto-mode-alist '("\\.[hc]\\(pp\\)?\\'" . simpc-mode))
(add-to-list 'auto-mode-alist '("\\.[b]\\'" . simpc-mode))

;; download formatter system wide dev-util/astyle on gentoo
;; for windows put astyle.exe to your path env 
;; astyle-formatter
(defun astyle-buffer ()
  (interactive)
  (let ((saved-line-number (line-number-at-pos)))
    (shell-command-on-region
     (point-min)
     (point-max)
     "astyle --style=kr"
     nil
     t)
    (goto-line saved-line-number)))

(global-set-key (kbd "C-c i") #'astyle-buffer)

;;rust mode
(use-package rust-mode
  :mode ("\\.rs\\'" . rust-mode))
  
;; go-mode
(use-package go-mode
  :mode ("\\.go\\'" . go-mode))

;; C / ASM: associate files with modes
(use-package nasm-mode
  :mode ("\\.asm\\'" . nasm-mode))

(use-package web-mode
  :ensure t
  :mode "\\.html?\\'" 
  :mode "\\.css\\'"
  :mode "\\.phtml\\'"
  :mode "\\.tpl\\.php\\'"
  :mode "\\.[agj]sp\\'"
  :mode "\\.as[cp]x\\'"
  :mode "\\.erb\\'"
  :mode "\\.mustache\\'"
  :mode "\\.djhtml\\'"
  :config
  (setq web-mode-markup-indent-offser 2
        web-mode-css-indent-offset 2
        web-mode-code-indent-offset 2))

(use-package emmet-mode
  :ensure t
  :hook (web-mode . emmet-mode)
  :config
  (setq emmet-indent-after-insert nil
        emmet-indentation 2))

;; quick manpage lookup under cursor
(global-set-key (kbd "C-c m") (lambda ()
  (interactive)
  (man (current-word))))

;;quick program run under cursor using emacs.

(global-set-key (kbd "C-c r")
  (lambda ()
    (interactive)
    (let* ((arg (thing-at-point 'word t))
           (program (read-shell-command "Run program: "))
           (cmd (concat program " " arg)))
      (compile cmd))))

(require 'ansi-color)
(defun my/apply-ansi-color-to-compilation-buffer ()
  "Apply ANSI colors to the compilation buffer."
  (let ((inhibit-read-only t))
    (ansi-color-apply-on-region (point-min) (point-max))))
(add-hook 'compilation-filter-hook #'my/apply-ansi-color-to-compilation-buffer)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(gruber-darker))
 '(custom-safe-themes
   '("e13beeb34b932f309fb2c360a04a460821ca99fe58f69e65557d6c1b10ba18c7"
     default))
 '(display-line-numbers-type 'relative)
 '(inhibit-startup-screen t)
 '(package-selected-packages
   '(astyle company emmet-mode gruber-darker-theme magit move-text
            multiple-cursors nasm-mode rainbow-mode rfc-mode rust-mode
            smex tuareg web-mode))
 '(warning-suppress-types '((native-compiler))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
