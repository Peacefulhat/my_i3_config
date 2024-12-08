;;disable tool bar.
(tool-bar-mode 0)

;; disable menu bar.
(menu-bar-mode 0)

;; disable scroll bar.
(scroll-bar-mode 0)

;; disable border
(fringe-mode 0)

;; enable global line number.
(global-display-line-numbers-mode 1)

;; enable ido mode.
(ido-mode 1)
(ido-everywhere 1)

;; set font size
(set-face-attribute 'default nil :height 170)

;; Disable backup files
(setq make-backup-files nil)
(setq auto-save-default nil)

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

;; extesion for ido.
(load "~/smex/smex.el")
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)

;;(column-number-mode (custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(gruber-darker))
 '(package-selected-packages '(gruber-darker-theme))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(gruber-darker))
 '(custom-safe-themes
   '("e13beeb34b932f309fb2c360a04a460821ca99fe58f69e65557d6c1b10ba18c7" default))
 '(display-line-numbers-type 'relative)
 '(inhibit-startup-screen t)
 '(package-selected-packages
   '(company move-text web-mode multiple-cursors magit gruber-darker-theme)))

;; company mode
(global-company-mode 1)
(setq company-idle-delay 0)
(setq company-minimum-prefix-length 3)


;; mulitple cursor
;;(global-set-key (kbd "C->") 'mc/mark-next-like-this)
;;(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
;;(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
(global-set-key (kbd "C-c C-c") 'mc/edit-lines)
(global-set-key (kbd "C->")         'mc/mark-next-like-this)
(global-set-key (kbd "C-<")         'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<")     'mc/mark-all-like-this)
(global-set-key (kbd "C-\"")        'mc/skip-to-next-like-this)
(global-set-key (kbd "C-:")         'mc/skip-to-previous-like-this)


;; move-text
(global-set-key (kbd "M-n") 'move-text-down)
(global-set-key (kbd "M-p") 'move-text-up)

