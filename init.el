;; My UI Changes
(tool-bar-mode 0)                 ;; Disable tool bar
(menu-bar-mode 0)                 ;; Disable menu bar
(scroll-bar-mode 0)               ;; Disable scroll bar
(fringe-mode 0)                   ;; Disable fringe (border area)
(global-display-line-numbers-mode 1)  ;; Enable line numbers globally
(setq display-line-numbers-type 'relative)
(set-face-attribute 'default nil :height 170)

;; No backup or autosave files
(setq make-backup-files nil)
(setq auto-save-default nil)


;; build function
(defun my-run-build ()
  "Run init_cl.bat and build.bat in a shell."
  (interactive)
  (let ((default-directory "D:/HandMadeHero/src/")) ;; <-- Important
    (shell-command "init_cl.bat && build.bat")))

;; init and build using cl
(global-set-key (kbd "C-c C-v") 'my-run-build)

;; run app in visual studio
(defun my-run-app ()
  "Open the built executable in Visual Studio."
  (interactive)
  (let ((default-directory "D:/HandMadeHero/src/"))
    (start-process "devenv-run" nil
                   "C:/Program Files/Microsoft Visual Studio/2022/Community/Common7/IDE/devenv.exe"
                   "../build/win32_handmade.exe")))
;;run in visual studio
(global-set-key (kbd "C-c C-r") 'my-run-app)


;; Tabs to spaces
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq python-indent-offset 4)
(add-hook 'prog-mode-hook (lambda () (setq tab-width 4)))

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
;; Eldoc
(global-eldoc-mode 1)  

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
 '(package-selected-packages nil)
 '(warning-suppress-types '((native-compiler))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
