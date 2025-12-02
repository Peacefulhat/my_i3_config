;; My UI Changes
(tool-bar-mode 0)                 ;; Disable tool bar
(menu-bar-mode 0)                 ;; Disable menu bar
(scroll-bar-mode 0)               ;; Disable scroll bar
(fringe-mode 0)                   ;; Disable fringe (border area)
(global-display-line-numbers-mode 1)  ;; Enable line numbers globally
(setq display-line-numbers-type 'relative)
(set-face-attribute 'default nil :height 170)
(add-hook 'dired-mode-hook (lambda () (dired-hide-details-mode 1)))

;; No backup or autosave files
(setq make-backup-files nil)
(setq auto-save-default nil)

;; Tabs to spaces
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq python-indent-offset 4)
(add-hook 'prog-mode-hook (lambda () (setq tab-width 4)))

;; Line/column info
(column-number-mode 1)

;; emacs cursor fix windows
(setq w32-use-visible-system-caret nil)
(setq w32-pass-multimedia-buttons-to-system nil)
(setq w32-recognize-altgr nil)
(blink-cursor-mode -1)
(setq-default cursor-type 'box)

(set-frame-font "Consolas-17" t t)

;; runing compiled program in msvc

(defun my/debug-handmade-in-msvc ()
  (interactive)
  (let* ((exe-path "C:/HandMadeHero/build/win32_handmade.exe")
         (devenv-path "C:/Program Files/Microsoft Visual Studio/2022/Community/Common7/IDE/devenv.exe"))
   (cond
    ((not (file-exists-p devenv-path))
     (message "Visual Studio (devenv.exe) not found: %s" devenv-path))
     ((not (file-exists-p exe-path))
      (message "Executable not found: %s" exe-path))
     (t
      ;; Use `w32-shell-execute` instead of `start-process`
      ;; This avoids the command/quoting issues completely.
      (w32-shell-execute
       "open"
       devenv-path
       (format "/debugexe \"%s\"" exe-path))
      (message "Visual Studio launched for debugging.")))))

(defun my/original-debug-handmade-in-msvc ()
  (interactive)
  (let* ((exe-path "C:/handmade/build/win32_handmade.exe")
         (devenv-path "C:/Program Files/Microsoft Visual Studio/2022/Community/Common7/IDE/devenv.exe"))
    (cond
     ((not (file-exists-p devenv-path))
      (message "Visual Studio (devenv.exe) not found: %s" devenv-path))
     ((not (file-exists-p exe-path))
      (message "Executable not found: %s" exe-path))
     (t
      ;; Use `w32-shell-execute` instead of `start-process`
      ;; This avoids the command/quoting issues completely.
      (w32-shell-execute
       "open"
       devenv-path
       (format "/debugexe \"%s\"" exe-path))
      (message "Visual Studio launched for debugging.")))))

;; cm code.
(global-set-key (kbd "C-c C-t") #'my/original-debug-handmade-in-msvc)
;; my code.
(global-set-key (kbd "C-c C-r") #'my/debug-handmade-in-msvc)
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

;; Multiple cursors
(use-package multiple-cursors
  :bind
  (("C-c C-c" . mc/edit-lines)
   ("C->"     . mc/mark-next-like-this)
   ("C-<"     . mc/mark-previous-like-this)
   ("C-|" . mc/mark-all-like-this)
   ("C-\""    . mc/skip-to-next-like-this)
   ("C-:"     . mc/skip-to-previous-like-this)))

;; Move-text
(use-package move-text
  :bind
  (("M-n" . move-text-down)
   ("M-p" . move-text-up)))

;; Eldoc
(global-eldoc-mode 1)

;; Simp-C mode
(add-to-list 'load-path "~/.emacs.d/.emacs.local/")
(require 'simpc-mode)
(add-to-list 'auto-mode-alist '("\\.[hc]\\(pp\\)?\\'" . simpc-mode))
(add-to-list 'auto-mode-alist '("\\.[b]\\'" . simpc-mode))

(add-to-list 'exec-path "C:/Program Files/Microsoft Visual Studio/2022/Community/VC/Tools/MSVC/14.44.35207/bin/Hostx64/x64")



;;rust mode
(use-package rust-mode
  :mode ("\\.rs\\'" . rust-mode))
  
;; go-mode
(use-package go-mode
  :mode ("\\.go\\'" . go-mode))

;; go-eldoc
(use-package go-eldoc
  :init
  (add-hook 'go-mode-hook 'go-eldoc-setup))


;; C / ASM: associate files with modes
(use-package nasm-mode
  :mode ("\\.asm\\'" . nasm-mode))

(use-package php-mode
  :mode ("\\.php\\'" . php-mode))

(use-package php-eldoc
  :hook (php-mode . php-eldoc-enable))

(use-package web-mode
  :mode ("\\.blade\\.php\\'" . web-mode)
  :config
  (setq web-mode-enable-auto-pairing t
        web-mode-enable-auto-closing t
        web-mode-enable-auto-quoting t))

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
   '(company go-eldoc gruber-darker-theme magit move-text
             multiple-cursors nasm-mode php-eldoc php-mode rust-mode
             smex web-mode))
 '(warning-suppress-types '((native-compiler))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
