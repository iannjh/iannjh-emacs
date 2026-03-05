;; -*- mode: scheme; -*-
;; This is an operating system configuration template
;; for a "desktop" setup with GNOME and Xfce where the
;; root partition is encrypted with LUKS, and a swap file.

(use-modules (gnu)
             (gnu system)
             (gnu system nss)
             (guix utils) 
             (guix packages))
(use-service-modules desktop sddm xorg)
(use-package-modules gnome)

(operating-system
  (host-name "iannjh")
  (timezone "Asia/Shanghai")
  (locale "zh_CN.utf8")

  ;; Choose US English keyboard layout.  The "altgr-intl"
  ;; variant provides dead keys for accented characters.
  (keyboard-layout (keyboard-layout "cn"))

  ;; Use the UEFI variant of GRUB with the EFI System
  ;; Partition mounted on /boot/efi.
  (bootloader (bootloader-configuration
                (bootloader grub-efi-bootloader)
                (targets '("/boot/efi"))
                (keyboard-layout keyboard-layout)))

  ;; Specify a mapped device for the encrypted root partition.
  ;; The UUID is that returned by 'cryptsetup luksUUID'.
  (file-systems (append
                 (list (file-system
                         (device (uuid "e7bdfad6-8eec-4c7f-9e84-f9d7993d4e33"))
                         (mount-point "/")
                         (type "ext4"))
                       (file-system
                         (device (uuid "4BC6-3688" 'fat))
                         (mount-point "/boot/efi")
                         (type "vfat")))
                 %base-file-systems))

  ;; Specify a swap file for the system, which resides on the
  ;; root file system.

  ;; Create user `bob' with `alice' as its initial password.
  (users (cons (user-account
                (name "iannjh")
                (comment "iannjh")
                (password (crypt "20070821" "$6$abc"))
                (group "students")
                (supplementary-groups '("wheel" "netdev"
                                        "audio" "video")))
               %base-user-accounts))

  ;; Add the `students' group
  (groups (cons* (user-group
                  (name "students"))
                 %base-groups))

  ;; This is where we specify system-wide packages.
  (packages (append (list (specification->package "fcitx5")
                          (specification->package "obs")
                          (specification->package "librewolf")
                          (specification->package "git")
                          (specification->package "blender")
                          (specification->package "emacs")                          
                          (specification->package "fcitx5-gtk")
                          (specification->package "luanti")
                          (specification->package "fcitx5-chinese-addons")
                          (specification->package "fcitx5-configtool") 
                          (specification->package "fcitx5-qt")
                          (specification->package "flatpak")
                          (specification->package "font-adobe-source-han-sans"))                                                                                                                                 
                    %base-packages))

  ;; Add GNOME and Xfce---we can choose at the log-in screen
  ;; by clicking the gear.  Use the "desktop" services, which
  ;; include the X11 log-in service, networking with
  ;; NetworkManager, and more.
  (services (if (supported-package? gnome
                                    (or (and=> (%current-target-system)
                                               gnu-triplet->nix-system)
                                        (%current-system)))
                (append (list (service gnome-desktop-service-type)
                              (service xfce-desktop-service-type)
                              (set-xorg-configuration
                               (xorg-configuration
                                (keyboard-layout keyboard-layout))))
                        %desktop-services)

                ;; FIXME: Since Gnome depends on Rust and Rust is currently
                ;; unavailable on some platforms, we use MATE here instead of
                ;; GNOME.
                (append (list (service mate-desktop-service-type)
                              (service xfce-desktop-service-type)
                              (set-xorg-configuration
                               (xorg-configuration
                                (keyboard-layout keyboard-layout))))
                        %desktop-services)))

  ;; Allow resolution of '.local' host names with mDNS.
  (name-service-switch %mdns-host-lookup-nss))
