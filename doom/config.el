;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)
(add-to-list 'default-frame-alist '(undecorated . t))
;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Personal/Org/")
;; (setq org-roam-directory (file-truename "~/Personal/Org/"))
;; (setq find-file-visit-truename t)
(use-package! org-roam
  :custom
  (org-roam-directory "~/Personal/Org/")
  :config
  (org-roam-db-autosync-enable))
(use-package! websocket
    :after org-roam-ui)

(use-package! org-roam-ui
    :after org-roam ;; or :after org
;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
;;         a hookable mode anymore, you're advised to pick something yourself
;;         if you don't care about startup time, use
    :hook (after-init . org-roam-ui-mode)
    :config
    (setq org-roam-ui-sync-theme t
          org-roam-ui-follow t
          org-roam-ui-update-on-save t
          org-roam-ui-open-on-start nil))

(font-lock-add-keywords
 'org-mode '(("\\<\\(NOTE\\):" 1 font-lock-warning-face prepend)))
;; (use-package! org-super-agenda
;;   :after org-agenda
;;   :config
;;   (setq org-super-agenda-groups '((:auto-dir-name nil)))
;;   (org-super-agenda-mode))

(after! org
  (setq org-todo-keywords '((sequence "IDEA(i)" "TODO(t)" "ACTIVE(a)" "WAITING(w)" "BACKLOG(b)" "|" "DONE(d)" "CANCELLED(c)"))))

(setq deft-directory "~/Personal/Org"
      deft-extensions '("org")
      deft-recursive t
      deft-use-filename-as-title t)

;; (use-package! org-fragtog
;; :after org
;; ;;:hook (org-mode . org-fragtog) ; this auto-enables it when you enter an org-buffer, remove if you do not want this
;; :config
;; (add-hook 'org-mode-hook 'org-fragtog-mode)
;; ;; whatever you want
;; )
(setq warning-suppress-types (append warning-suppress-types '((org-element-cache))))
(global-visual-line-mode t)

(use-package org-fragtog
  :hook (org-mode . org-fragtog-mode)
  :config
  (setq org-fragtog-preview-delay 0.25))

(use-package olivetti-mode
  :hook (org-mode . olivetti-mode)
  )

(setq olivetti-body-width 90)

(setq org-gcal-client-id "709693057275-g26av97u32cklm0936irob96rcv7g42k.apps.googleusercontent.com"
      org-gcal-client-secret "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"
      ;; My calendars - they are, in order: Social, Chores/Errands, Health/Fitness, Reminders, Studies
      org-gcal-fetch-file-alist '(("cory.gipson@gmail.com" .  "~/Personal/Org/Calendar/gcal.org")
                                  ("b5fb924cfcbdae838c59e655a07593033e273ec9febbbbc04f4ff89c86605ac0@group.calendar.google.com" . "~/Personal/Org/Calendar/gcal.org")
                                  ("981f4effe613b14a5433f295932f465b6eb33e841dd6a6c13fe13aac4b0393b0@group.calendar.google.com" .  "~/Personal/Org/Calendar/gcal.org")
                                  ("d74de426d75ad73aaade4d6c8ba8370714d6a89e2b7679b5fe908c1acbb8ca92@group.calendar.google.com" . "~/Personal/Org/Calendar/gcal.org")
                                  ("51d2d5bf8bb8649f260daa44c7d6a1ecd97c6f8034e7294a75f73ee530a0feae@group.calendar.google.com" .  "~/Personal/Org/Calendar/gcal.org")
                                  ("0d907f287892af61058510f69c74eae7e7cfce24da94516ea6c36318e852e84e@group.calendar.google.com" . "~/Personal/Org/Calendar/gcal.org")))
(require 'org-gcal)
(require 'epa-file)
(setq epg-pinentry-mode 'loopback)
(epa-file-enable)
(setq plstore-cache-passphrase-for-symmetric-encryption t)
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")
(use-package org-gcal
:init
(setq org-gcal-client-id "709693057275-g26av97u32cklm0936irob96rcv7g42k.apps.googleusercontent.com"
        org-gcal-client-secret "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"))
(setq org-gcal-up-days 7)

(setq org-capture-templates
 '(("j" "Journal" entry
  (file+olp+datetree +org-capture-journal-file)
  "* %U %?\n%i\n" :prepend t)))

(defcustom org-roam-dailies-capture-templates
  `(("d" "default" plain
     "- %^U %?\n%i\n" :prepend nil
     :target (file+head+olp "%<%Y-%m-%d>.org"
                        "#+title: %<%Y-%m-%d>\n* Journal\n* TODOs\n"
                        ("Logs")))
    ("j" "journal" plain
     "%?" :prepend nil
     :target (file+head+olp "%<%Y-%m-%d>.org"
                            "#+title: %<%Y-%m-%d>"
                            ("Journal")))
    ("t" "todo" plain
     "** TODO %?" :prepend nil
     :target (file+head+olp "%<%Y-%m-%d>.org"
                            "#+title: %<%Y-%m-%d>"
                            ("TODOs"))))
  "Capture templates for daily-notes in Org-roam.
Note that for daily files to show up in the calendar, they have to be of format
\"org-time-string.org\".
See `org-roam-capture-templates' for the template documentation."
  :group 'org-roam
  :type '(repeat
          (choice (list :tag "Multikey description"
                        (string :tag "Keys       ")
                        (string :tag "Description"))
                  (list :tag "Template entry"
                        (string :tag "Keys           ")
                        (string :tag "Description    ")
                        (choice :tag "Capture Type   " :value entry
                                (const :tag "Org entry" entry)
                                (const :tag "Plain list item" item)
                                (const :tag "Checkbox item" checkitem)
                                (const :tag "Plain text" plain)
                                (const :tag "Table line" table-line))
                        (choice :tag "Template       "
                                (string)
                                (list :tag "File"
                                      (const :format "" file)
                                      (file :tag "Template file"))
                                (list :tag "Function"
                                      (const :format "" function)
                                      (function :tag "Template function")))
                        (plist :inline t
                               ;; Give the most common options as checkboxes
                               :options (((const :format "%v " :target)
                                          (choice :tag "Node location"
                                                  (list :tag "File"
                                                        (const :format "" file)
                                                        (string :tag "  File"))
                                                  (list :tag "File & Head Content"
                                                        (const :format "" file+head)
                                                        (string :tag "  File")
                                                        (string :tag "  Head Content"))
                                                  (list :tag "File & Outline path"
                                                        (const :format "" file+olp)
                                                        (string :tag "  File")
                                                        (list :tag "Outline path"
                                                              (repeat (string :tag "Headline"))))
                                                  (list :tag "File & Head Content & Outline path"
                                                        (const :format "" file+head+olp)
                                                        (string :tag "  File")
                                                        (string :tag "  Head Content")
                                                        (list :tag "Outline path"
                                                              (repeat (string :tag "Headline"))))))
                                         ((const :format "%v " :prepend) (const t))
                                         ((const :format "%v " :immediate-finish) (const t))
                                         ((const :format "%v " :jump-to-captured) (const t))
                                         ((const :format "%v " :empty-lines) (const 1))
                                         ((const :format "%v " :empty-lines-before) (const 1))
                                         ((const :format "%v " :empty-lines-after) (const 1))
                                         ((const :format "%v " :clock-in) (const t))
                                         ((const :format "%v " :clock-keep) (const t))
                                         ((const :format "%v " :clock-resume) (const t))
                                         ((const :format "%v " :time-prompt) (const t))
                                         ((const :format "%v " :tree-type) (const week))
                                         ((const :format "%v " :unnarrowed) (const t))
                                         ((const :format "%v " :table-line-pos) (string))
                                         ((const :format "%v " :kill-buffer) (const t))))))))
(setq ranger-cleanup-on-disable t)
(ranger-override-dired-mode t)
;; (setq peep-dired-cleanup-eagerly t)
;; (setq peep-dired-enable-on-directories t)

(map! :leader
      (:prefix ("d" . "dired")
               :desc "Open dired" "d" #'dired
               :desc "Open ranger" "r" #'ranger)
      (:prefix ("e" . "excalidraw")
               :desc "Create drawing" "x" #'org-excalidraw-create-drawing
               :desc "Toggle inline image at point" "t" #'+org-toggle-inline-image-at-point)
      (:prefix ("r" . "roam")
               :desc "Capture today" "t" #'org-roam-dailies-capture-today
               :desc "Go to today" "g t" #'org-roam-dailies-goto-today
               :desc "Capture tomorrow" "m" #'org-roam-dailies-capture-tomorrow)
      (:prefix ("z" . "zen")
               :desc "Writeroom mode" "w" #'writeroom-mode
               :desc "Global writeroom" "g" #'global-writeroom-mode))

(use-package! org-excalidraw
  :after org
  :config
  (setq org-excalidraw-directory "~/Personal/Org/excalidraw")
)

(use-package! calfw-blocks
  :after calfw)

(use-package! org-transclusion
  :after org
  :init
  (map!
   :map global-map "<f12>" #'org-transclusion-add
   :leader
   :prefix "n"
   :desc "Org Transclusion Mode" "t" #'org-transclusion-mode))

;; (defun +org-toggle-inline-image-at-point ()
;;   "Toggle inline image at point."
;;   (interactive)
;;   (if-let* ((bounds (and (not org-inline-image-overlays)
;;                          (org-in-regexp org-link-any-re nil t)))
;;             (beg (car bounds))
;;             (end (cdr bounds)))
;;       (org-display-inline-images nil nil beg end)
;;     (org-toggle-inline-images)))
;;
;;       :after dired
;;       (:map dired-mode-map
;;             :desc "Peep-dired" "d p" #'peep-dired))
;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
