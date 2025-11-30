(setq package-archives '(("gnu" . "https://mirrors.ustc.edu.cn/elpa/gnu/")
                         ("melpa" . "https://mirrors.ustc.edu.cn/elpa/melpa/")
                         ("nongnu" . "https://mirrors.ustc.edu.cn/elpa/nongnu/")))

;; 加载自定义主题路径（如果用了方法 C）
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")

;; 启用主题（以 gruvbox 为例）
(load-theme 'fleury t)

(use-package emacs
  :ensure t
    :config 
    (setq display-line-numbers-type 'relative) 
    (global-display-line-numbers-mode t)
)

(add-to-list 'load-path "~/.emacs.d/neotree")
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)

;; 禁用工具栏和滚动条
(tool-bar-mode -1)
(scroll-bar-mode -1)

(setq dashboard-banner-logo-title "Welcome to Emacs, comrade!")
(setq dashboard-startup-banner
      '("  _______                     __  __            _     "
        " |__   __|                   |  \\/  |          | |    "
        "    | | ___ _ __ _ __ ___  ___| \\  / | __ _  ___| |__  "
        "    | |/ _ \\ '__| '__/ _ \\/ _ \\ |\\/| |/ _` |/ __| '_ \\ "
        "    | |  __/ |  | | |  __/  __/ |  | | (_| | (__| | | |"
        "    |_|\\___|_|  |_|  \\___|\\___|_|  |_|\\__,_|\\___|_| |_|"))

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook))

