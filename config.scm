(use-modules (gnu))
(use-service-modules cups desktop networking ssh xorg)

(operating-system
  (locale "zh_CN.utf8")
  (timezone "Asia/Shanghai")
  (keyboard-layout (keyboard-layout "cn"))
  (host-name "iannjh")

  (users (cons* (user-account
                  (name "iannjh")
                  (comment "Iannjh")
                  (group "users")
                  (home-directory "/home/iannjh")
                  (supplementary-groups '("wheel" "netdev" "audio" "video")))
                %base-user-accounts))

  (packages (append (list (specification->package "nss-certs")
                          (specification->package "gnome")
                          (specification->package "fcitx5")
                          (specification->package "fcitx5-qt")
                          (specification->package "fcitx5-gtk")
                          (specification->package "fcitx5-chinese-addons")
                          (specification->package "fcitx5-configtool")
                          (specification->package "emacs")
                          (specification->package "font-adobe-source-han-sans")
                          (specification->package "libinput")
                          (specification->package "mesa")
                          (specification->package "wayland-utils")
                          (specification->package "wayland"))
                    %base-packages))

  (services
   (append (list (service gnome-desktop-service-type)
                 (service cups-service-type))
           (modify-services %desktop-services
             (gdm-service-type config =>
               (gdm-configuration
                 (inherit config)
                 (wayland? #t)
                 (auto-suspend? #f))))))

  ;; 修正引导配置
  (bootloader (bootloader-configuration
                (bootloader grub-efi-bootloader)  ; 使用EFI版本的GRUB
                (targets (list "/boot/efi"))      ; 指定EFI分区挂载点
                (keyboard-layout keyboard-layout)))

  ;; 文件系统配置
  (file-systems (cons* (file-system
                         (mount-point "/")
                         (device (uuid
                                  "7e0f7d68-6c8b-47c7-bbde-d63d5e3216c4"
                                  'ext4))
                         (type "ext4"))
                       ;; 必须添加EFI分区
                       (file-system
                         (mount-point "/boot/efi")
                         (device (uuid
                                  "764E-1DA9" ; 需要替换
                                  'fat32))
                         (type "vfat")
                         (options "umask=0002"))
                       %base-file-systems)))
