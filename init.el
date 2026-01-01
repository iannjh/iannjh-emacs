;; 初始化包管理器
(require 'package)

(setq package-archives '(("gnu" . "https://mirrors.ustc.edu.cn/elpa/gnu/")
                         ("melpa" . "https://mirrors.ustc.edu.cn/elpa/melpa/")
                         ("melpa-stable" . "https://stable.melpa.org/packages/")
                         ("nongnu" . "https://mirrors.ustc.edu.cn/elpa/nongnu/")))

(package-initialize)

;; 更新包缓存
(unless package-archive-contents
  (package-refresh-contents))

;; 确保 use-package 已安装
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)  ; 自动确保包已安装

;; 加载自定义主题路径（如果用了方法 C）
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")

;; 启用主题（以 gruvbox 为例）
;; 注意：你需要先安装 'fleury 主题
(if (package-installed-p 'fleury-theme)
    (load-theme 'fleury t)
  (message "Theme 'fleury not installed. Using default theme."))

;; 启用主题（以 gruvbox 为例）
(load-theme 'fleury t)

;; 设置显示行号
(setq display-line-numbers-type 'relative) 
(global-display-line-numbers-mode t)

;; 配置 neotree
(add-to-list 'load-path "~/.emacs.d/neotree")
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)

;;; No Menu Bar
(menu-bar-mode -1)
;;; No tool bar
(tool-bar-mode -1)
;;; No Scrollbar
(scroll-bar-mode -1)

;; 配置 dashboard
(use-package dashboard
  :config
  (setq dashboard-banner-logo-title "Welcome to Emacs, comrade!")
  (setq dashboard-startup-banner
        '("  _______                     __  __            _     "
          " |__   __|                   |  \\/  |          | |    "
          "    | | ___ _ __ _ __ ___  ___| \\  / | __ _  ___| |__  "
          "    | |/ _ \\ '__| '__/ _ \\/ _ \\ |\\/| |/ _` |/ __| '_ \\ "
          "    | |  __/ |  | | |  __/  __/ |  | | (_| | (__| | | |"
          "    |_|\\___|_|  |_|  \\___|\\___|_|  |_|\\__,_|\\___|_| |_|"))
  (dashboard-setup-startup-hook))

;; 安装必要的依赖包
(dolist (pkg '(compat doom-modeline markdown-mode))
  (unless (package-installed-p pkg)
    (package-install pkg)))

;; 配置 doom-modeline（在所有依赖安装后）
(use-package doom-modeline
  :init (doom-modeline-mode 1))

;; 配置 markdown-mode
(use-package markdown-mode
  :mode ("README\\.md\\'" . gfm-mode)
  :init (setq markdown-command "multimarkdown")
  :bind (:map markdown-mode-map
         ("C-c C-e" . markdown-do)))

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
