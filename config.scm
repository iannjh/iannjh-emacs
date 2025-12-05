;; This is an operating system configuration generated
;; by the graphical installer.
;;
;; Once installation is complete, you can learn and modify
;; this file to tweak the system configuration, and pass it
;; to the 'guix system reconfigure' command to effect your
;; changes.


;; Indicate which modules to import to access the variables
;; used in this configuration.
(use-modules (gnu))
(use-service-modules cups desktop networking ssh xorg)

(operating-system
  (locale "zh_CN.utf8")
  (timezone "Asia/Shanghai")
  (keyboard-layout (keyboard-layout "cn"))
  (host-name "iannjh")

  ;; The list of user accounts ('root' is implicit).
  (users (cons* (user-account
                  (name "iannjh")
                  (comment "Iannjh")
                  (group "users")
                  (home-directory "/home/iannjh")
                  (supplementary-groups '("wheel" "netdev" "audio" "video")))
                %base-user-accounts))

  ;; Packages installed system-wide.  Users can also install packages
  ;; under their own account: use 'guix search KEYWORD' to search
  ;; for packages and 'guix install PACKAGE' to install a package.
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

  ;; Below is the list of system services.  To search for available
  ;; services, run 'guix system search KEYWORD' in a terminal.
  (services
   (append (list (service gnome-desktop-service-type)
                 (service cups-service-type))
           ;; This is the default list of services we
           ;; are appending to.
           (modify-services %desktop-services
             (gdm-service-type config =>
               (gdm-configuration
                 (inherit config)
                 (wayland? #t)
                 (auto-suspend? #f))))))

  ;; --- 修改部分开始 ---
  ;; 使用 nvme0n1 的 EFI 分区作为引导目标
  ;; (注：虽然指定了整个磁盘，但 Grub 会自动在其中寻找 EFI 分区)
  (bootloader (bootloader-configuration
                (bootloader grub-bootloader)
                (targets (list "/dev/nvme0n1")) ; 保持为 /dev/nvme0n1 是可接受的
                (keyboard-layout keyboard-layout)))

  ;; 更新交换分区的设备标识符
  (swap-devices (list (swap-space
                        (target (uuid
                                 "c26c3f70-d623-2347-8c4c-b56dca9f4e2f"))))) ; 根据图片更新为正确的 UUID

  ;; 更新文件系统挂载点
  (file-systems (cons* (file-system
                         (mount-point "/")
                         (device (uuid
                                  "40aa123d-e8d7-624c-9b29-80c5418b8da1" ; 根据图片更新为正确的 UUID
                                  'ext4))
                         (type "ext4"))
                       ;; 如果 /home 是一个独立的分区，请取消下面的注释并填写正确的 UUID。
                       ;; (file-system
                       ;;   (mount-point "/home")
                       ;;   (device (uuid
                       ;;            "YOUR_HOME_PARTITION_UUID_HERE"
                       ;;            'ext4))
                       ;;   (type "ext4"))
                       %base-file-systems)))