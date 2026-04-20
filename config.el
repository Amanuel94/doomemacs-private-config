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
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:

;; Fantasque Sans Mono
;; Iosevaka Term SS07
;; Iosevaka Fixed SS02
;; Iosevka Fixed SS08
;; Myna
;; JetBrains Mono
;; Hasklug Nerd Font
;; CascdiaCode

(setq home-dir "/home/dirichletian")
(setq doom-variable-pitch-font (font-spec :family "JetBrains Mono" :size 14)
      doom-serif-font (font-spec :family "JetBrains Mono" :size 14)
      doom-font (font-spec :family "CascadiaCode" :size 12))

(setq doom-fontsets `("Fantasque Sans Mono"
                       "Iosevka Term SS07"
                       "Iosevka Fixed SS02"
                       "Iosevka Fixed SS08"
                       "Myna"
                       "JetBrains Mono"
                       "Hasklug Nerd Font"
                       "Iosevka NFM"
                       "Fira Code"
                       "0x Proto Nerd Font"
                       "Agave Nerd Font"
                       "EnvyCodeR Nerd Font"
                       "Monoid Nerd Font Mono"
                       "Monaspace Argon Var"
                       "Monaspace Xenon Var"
                       "CascadiaCode"))

(defun doom/set-font ()
  (interactive)
  (let* ((font-name (completing-read "Select Font: " doom-fontsets nil 'confirm)))
  (setq doom-font (font-spec :family font-name :size 10 :weight 'Regular)))
  (doom-init-fonts-h 'reload)
 )

;;ligatures
;; Enable the www ligature in every possible major mode
(ligature-set-ligatures 't '("www"))

;; Enable ligatures in programming modes                                                           
(ligature-set-ligatures 'prog-mode '("www" "**" "***" "**/" "*>" "*/" "\\\\" "\\\\\\" "{-" "::"
                                     ":::" ":=" "!!" "!=" "!==" "-}" "----" "-->" "->" "->>"
                                     "-<" "-<<" "-~" "#{" "#[" "##" "###" "####" "#(" "#?" "#_"
                                     "#_(" ".-" ".=" ".." "..<" "..." "?=" "??" ";;" "/*" "/**"
                                     "/=" "/==" "/>" "//" "///" "&&" "||" "||=" "|=" "|>" "^=" "$>"
                                     "++" "+++" "+>" "=:=" "==" "===" "==>" "=>" "=>>" "<="
                                     "=<<" "=/=" ">-" ">=" ">=>" ">>" ">>-" ">>=" ">>>" "<*"
                                     "<*>" "<|" "<|>" "<$" "<$>" "<!--" "<-" "<--" "<->" "<+"
                                     "<+>" "<=" "<==" "<=>" "<=<" "<>" "<<" "<<-" "<<=" "<<<"
                                     "<~" "<~~" "</" "</>" "~@" "~-" "~>" "~~" "~~>" "%%"))

(global-ligature-mode 't)
;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (setq doom-theme 'doom-one)
;; (setq doom-theme 'modus-vivendi-tinted)
;; (setq doom-theme 'modus-vivendi-tritanopia)
;; (setq doom-theme 'doom-ir-black)
;; (setq doom-theme 'gruber-darker)
;; (setq doom-theme 'doom-horizon)
;; (setq doom-theme 'doom-henna)
;; (setq doom-theme 'doom-moonlight)
;; (setq doom-theme 'doom-wilmersdorf)
;; (setq doom-theme 'doom-acario-light)
;; (setq light-theme 'doom-tomorrow-day)

;; (setq light-theme 'doom-acario-light)
;; (setq light-theme 'hemera)
;; (setq light-theme 'dakrone-light)
;; (setq light-theme 'parchment)
(setq light-theme 'modus-operandi-tritanopia)

;; (setq dark-theme 'doom-wilmersdorf)
;; (setq dark-theme 'dakrone)
;; (setq dark-theme 'doom-monokai-machine)
;; (setq dark-theme 'doom-monokai-octagon)
;; (setq dark-theme 'kaolin-dark)
(setq dark-theme 'kaolin-mono-dark)


(let ((time-now (string-to-number (format-time-string "%H" (current-time)))))
 (if (> (mod (- time-now 6) 24) 12) ;; 19 - 06 use dark mode
     (setq doom-theme dark-theme)
   (setq doom-theme light-theme)
))


(defun customize-dired-theme (theme color)
  "Customize dired faces with less contrast."
  (custom-theme-set-faces!
   theme
   `(diredfl-dir-name :foreground ,color)
   `(diredfl-file-suffix :foreground ,color)
   `(diredfl-mode :foreground ,color)
   `(diredfl-number :foreground ,color)
   `(diredfl-read-priv :foreground unspecified)
   `(diredfl-write-priv :foreground unspecified)
   `(diredfl-exec-priv :foreground unspecified)
   `(diredfl-date-time :foreground unspecified)
   `(diredfl-no-priv :foreground unspecified)
   `(diredfl-file-name :foreground unspecified)
   `(diredfl-dir-heading :underline unspecified)
   `(diredfl-dir-priv :foreground unspecified))

  (set-face-attribute 'doom-dashboard-menu-title nil :weight 'normal))

;; (customize-dired-theme 'gruber-darker "#708090")
;; (customize-dired-theme 'hemera "#000000")
(customize-dired-theme 'dakrone-light "#007700")

(custom-theme-set-faces! 'dakrone-light
'(org-agenda-structure :family (font-spec :family "MathJax_SansSerif" :weight 'Regular))
'(font-lock-string-face :background "#f5f5f5" :foreground "#440044"))

(custom-theme-set-faces! 'kaolin-mono-dark
  '(org-code :foreground "#00ee00")
  '(org-document-info-keyword :foreground "#90ee90"))
 

;; paths
(add-to-list 'load-path "~/.config/doom/lisp/") 
(load-env-vars "~/.config/doom/.env")

;; gcalendar google
(setq plstore-cache-passphrase-for-symmetric-encryption t)

(setq GCAL_CLIENT_ID (getenv "GCAL_CLIENT_ID")) 
(setq GCAL_CLIENT_SECRET (getenv "GCAL_CLIENT_SECRET")) 

(setq org-gcal-client-id GCAL_CLIENT_ID
      org-gcal-client-secret GCAL_CLIENT_SECRET 
      org-gcal-fetch-file-alist '(("amanueltewodros94@gmail.com" .  "~/org/cal.org")))
(setq org-gcal-down-days 15)
(setq org-gcal-up-days 15)
(setq org-gcal-recurring-events-mode 'top-level)
(define-key evil-normal-state-map (kbd "SPC h r c") #'org-gcal-sync)
(define-key evil-normal-state-map (kbd "SPC h r o") #'org-gcal-post-at-point)


;; require
(require 'acp)
(require 'agent-shell)
(require 'org-gcal)

(use-package org-bullets
  :load-path "~/.config/doom/lisp/"
  :hook (org-mode . org-bullets-mode)
  :config
  ;; (setq org-bullets-bullet-list '(">" "⮞" "🟄" "⪢")))
  (setq org-bullets-bullet-list '(">" ">" ">" ">")))

;; c-lsp
(after! c-ts-mode
  (setq major-mode-remap-alist '((c-mode . c-ts-mode))))

;; display-side-numbers
(setq display-line-numbers-width 2)
(set-face-attribute 'line-number nil :background nil)


;; doom-acario-ligth
(after! org
  (custom-theme-set-faces! 'doom-acario-light
    '(org-document-info-keyword :foreground "#000000")
))

;; org
;; make org-headlines weight normal
(defun customize-org-headlines ()
  (interactive)
    (set-face-attribute 'org-level-1 nil :weight 'normal)
    (set-face-attribute 'org-level-2 nil :weight 'normal)
    (set-face-attribute 'org-level-3 nil :weight 'normal)
    (set-face-attribute 'org-level-4 nil :weight 'normal)
    (set-face-attribute 'org-level-5 nil :weight 'normal)
    (set-face-attribute 'org-level-6 nil :weight 'normal)
    (set-face-attribute 'org-level-7 nil :weight 'normal)
    (set-face-attribute 'org-level-8 nil :weight 'normal)
    (set-face-attribute 'org-meta-line nil :foreground "#708090")
    (set-face-attribute 'org-document-info-keyword nil :foreground "#f5f5dc")
    (set-face-attribute 'org-headline-done nil :foreground "#008b8b")
    (set-face-attribute 'org-code nil :foreground "#6a5acd")
    (setq org-latex-create-formula-image-program 'dvisvgm)
    (setq org-format-latex-options (plist-put org-format-latex-options :scale 1.0))
)

(defun increase-org-frag-mode-font-size ()
  (interactive)
        (setq cur-size (plist-get org-format-latex-options :scale))
        (if (eq major-mode 'org-mode)
        (setq org-format-latex-options (plist-put org-format-latex-options :scale (+ cur-size 0.5))))
)

(defun decrease-org-frag-mode-font-size ()
  (interactive)
        (setq cur-size (plist-get org-format-latex-options :scale))
        (if (eq major-mode 'org-mode)
        (setq org-format-latex-options (plist-put org-format-latex-options :scale (- cur-size 0.5))))
)


(defun set-org-frag-mode-font-size (a)
  (interactive "N")
        (if (eq major-mode 'org-mode)
        (setq org-format-latex-options (plist-put org-format-latex-options :scale a))
))


(defun collapse-org-headings ()
  (org-cycle-global 1)
)
(add-hook 'org-mode-hook 'collapse-org-headings)

;; turn to org src block
(defun turn-to-org-src-block (a)
  (interactive "s")
  (let* ((reg-s (region-beginning))
        (reg-e (region-end)))
        (goto-char reg-e)
        (insert "\n#+END_SRC")
        (goto-char reg-s)
        (forward-line -1)
        (insert (concat "#+BEGIN_SRC " a "\n")))
  )

(setq display-line-numbers-type 'relative)
;; (setq opacity 95)
;; (let* ((opacity-parameter-name
;;         (if (eq window-system 'pgtk)
;;         'alpha-background
;;         'alpha))
;;         (param-list `((,opacity-parameter-name . ,opacity)))
;; (modify-all-frames-parameters param-list))

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")
(defun capture-next-task-with-text (text)
  "Capture a 'Next' task with TEXT pre-filled."
  (interactive "sTask description: ")
  ;; Temporarily override the template
  (let ((org-capture-templates
         `(("N" "Next" entry
            (file+headline "~/org/gtd.org" "Next")
            ,(concat "* [ ] " text "\n")))))
    (org-capture nil "N")))



(defun capture-current-todo-as-next ()
  "Capture the current TODO headline as a 'Next' task."
  (interactive)
  (let* ((headline (org-get-heading t t t t)) ; gets heading without TODO keyword, tags, etc.
         (text headline))
    (capture-next-task-with-text text)))

;; Example keybinding: C-c C-n
(global-set-key (kbd "M-n") 'capture-current-todo-as-next)


;; kbd for gtd file
(defun org-open-gtd () (interactive) (org-open-file (concat org-directory "gtd.org")))
(define-key evil-normal-state-map (kbd "SPC e t")  #'org-open-gtd)

(after! org
  (dolist (tpl
           '(("i" "Idea" entry
              (file+headline "~/org/ideas.org" "Ideas")
              "* %? \n  Entered on %t\n")

             ("T" "Todo with TS" entry
              (file+datetree "~/org/todo.ts.org")
              "* %?\n SCHEDULED: %^t")

             ("I" "Inbox" entry
              (file+headline "~/org/gtd.org" "Inbox")
              "* [ ] %?")

             ("J" "Inbox with cursor" entry
              (file+headline "~/org/gtd.org" "Inbox")
              "* [ ] %?\n %a")

             ("N" "Next" entry
              (file+headline "~/org/gtd.org" "Next")
              "* [ ] %?")

             ("S" "Store" entry
              (file "~/org/store.org")
              "* %?")

             ("R" "Read" entry
              (file+headline "~/org/reading.list.org" "inbox")
              "* %?")
             ))
    (add-to-list 'org-capture-templates tpl)))

(defun archive-all-done-tasks ()
  "Move all TODO headlines to a 'Done' heading with timestamp."
  (interactive)
  (let ((org-files '("~/org/gtd.org"))) ;; add more files if needed
    (dolist (file org-files)
      (with-current-buffer (find-file-noselect file)
        (goto-char (point-min))
        ;; Iterate over all TODO entries safely
        (org-map-entries
         (lambda ()
           (let ((state (org-get-todo-state)))
             (when (and state (string= state "TODO"))
               ;; Save heading text before cutting
               (let ((heading (org-get-heading t t t t)))
                 (org-cut-subtree)
                 ;; Go to or create 'Done' heading
                 (goto-char (point-min))
                 (unless (re-search-forward "^* Done" nil t)
                   (goto-char (point-max))
                   (insert "* Done\n"))
                 ;; Move to end of 'Done' heading
                 (goto-char (point-max))
                 ;; Insert the task as done with CLOSED timestamp
                 (insert (format "* [X] %s  :archived:\n  CLOSED: %s\n"
                                 heading
                                 (format-time-string "[%Y-%m-%d %a %H:%M]"))))))))
         "TODO")
        (save-buffer))))


(defun org-archive-heading ()
  (interactive)
  (when (eq major-mode 'org-mode)
      ((let ((archive "Archived"))
        (save-excursion
        (org-cut-subtree)

        (goto-char (point-min))
        (unless (org-find-exact-headline-in-buffer archive)
            (goto-char (point-max))
            (insert (format "* %s\n" archive)))

        (org-goto-marker-or-bmk
        (org-find-exact-headline-in-buffer archive))
        (forward-line)
        (org-paste-subtree))))))

(define-key evil-normal-state-map (kbd "SPC v a") #'org-archive-vb-heading)
;; collect bullets to org-table

(defun time-until (time)
  "Return the time remaining until TIME.
TIME should be either a time value or a date-time string."
  (when (stringp time)
    ;; Convert date strings to internal time.
    (setq time (date-to-time time)))
  (ceiling (time-to-number-of-days (time-subtract time nil))))

(defun quantify (quantity  unit)
  (concat (int-to-string quantity) " " unit (and (not (eq quantity 1)) "s"))
  )

(defun grad-tracker-repopulate-table ()
    (interactive)
    (setq table-top-regex "^|[-]+")
    (setq table-pos (or (re-search-forward table-top-regex nil t) (re-search-backward table-top-regex nil t)))
    (goto-char table-pos)

    (setq row 2)
    (setq entries (org-map-entries 'org-entry-properties "+/TODO"))
    (while entries
        (setq entry (car entries))
        (org-table-put row 1 (cdr (assoc "ITEM" entry)))
        (org-table-put row 2 (cdr (assoc "TODO" entry)))
        (org-table-put row 3 (cdr (assoc "PRIORITY" entry)))

        (setq ts (cdr (assoc "SCHEDULED" entry)))
        (org-table-put row 4 (concat "in " (quantify (time-until ts) "day")))

        (setq deadline (cdr (assoc "DEADLINE" entry)))
        (org-table-put row 5 (concat "in " (quantify (time-until deadline) "day")))

        (setq ref (concat (cdr (assoc "FILE" entry)) "::*" (cdr (assoc "ITEM" entry))))
        (org-table-put row 6 (concat "[[" ref "][org-bullet]]" ))

        (setq row (+ row 1))
        (and (not (org-table-goto-line (+ row 1)))
                (and (org-table-goto-line row)
                (org-table-insert-row)))
        (setq entries (cdr entries
    ))
    )
    (while (org-table-goto-line (+ row 1)) (org-table-kill-row))

   (org-table-align)
)

(defun hook-grad-tracker ()
  (if (string-equal (c-get-current-file) "grad.tracker") (grad-tracker-repopulate-table))
)
;; (remove-hook 'write-file-functions 'hook-grad-tracker)
;; (remove-hook 'after-save-hook 'hook-grad-tracker)

;; (add-hook 'after-save-hook 'grad-tracker-repopulate-table)
 (define-key global-map (kbd "C-c C-r") #'grad-tracker-repopulate-table)


(define-minor-mode org-count-words-mode "Org Word Counter Mode" :init-value nil)
(define-minor-mode org-live-babel-mode "Execute Babel on Change" :init-value nil)

;; mainining word count for essays
;; TODO: move the cursor back to the editing position instead of the heading

(defun org-count-words ()
  (interactive)
  (when (and (eq major-mode 'org-mode) (-contains? (doom-active-minor-modes) 'org-count-words-mode))
    (org-set-property "WORD-COUNT" (int-to-string
                                  (apply 'count-words-region (take 2 (evil-org-inner-subtree))))))
  )

(defun org-exec-babel-on-change ()
  (interactive)
  (when (and (eq major-mode 'org-mode) (-contains? (doom-active-minor-modes) 'org-live-babel-mode))
  (org-babel-execute-buffer)
))

(add-hook 'after-save-hook #'org-count-words)
(add-hook 'after-save-hook #'org-exec-babel-on-change)



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
;; alternatively, use `c-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
;; latex configuration


(setq +latex-viewers '(zathura))
(map! :map cdlatex-mode-map :i "TAB" #'cdlatex-tab) ;; for latex snippets
(setq TeX-PDF-mode t)
;; for displaying diagrams


;; OdooERP configs
(defun odoo/replace_attrs_18 ()
  (interactive)
  (evil-ex "%s/attrs=\"\\{'\\(.*\\)': \\[('\\(.*\\)', '\\(.*\\)', \\(.*\\))\\]\\}\"/\\1=\"\\2 \\3 \\4\"/g"))


;; Custom Key Bindings
;; ace-window
(use-package general
  :ensure t
  :config
  (general-create-definer my/leader-keys
    :prefix "SPC"
    :states '(normal visual motion))

  (my/leader-keys
    "w a" 'ace-window))

;; embark
;; The default C-; is used for switching xfce workspaces
(define-key global-map (kbd "C-:") #'embark-act)
(define-key global-map (kbd "C-\"") #'embark-export)
(after! embark
 (eval-when-compile
   (defmacro my/embark-ace-action (fn)
     `(defun ,(intern (concat "my/embark-ace-" (symbol-name fn))) ()
        (interactive)
        (with-demoted-errors "%s"
          (require 'ace-window)
          (let ((aw-dispatch-always t))
            (aw-switch-to-window (aw-select nil))
            (call-interactively (symbol-function ',fn)))))))

 (define-key embark-file-map     (kbd "o") (my/embark-ace-action find-file))
 (define-key embark-buffer-map   (kbd "o") (my/embark-ace-action switch-to-buffer))
 (define-key embark-bookmark-map (kbd "o") (my/embark-ace-action bookmark-jump))
)

;; clones buffer without buffer-local minor modes
(after! org
(defun clone-buffer-new-window-with-modes (modes-to-enable)
  (interactive
   (list (completing-read-multiple
          "Minor modes to enable in clone (comma-separated): "
          (mapcar #'symbol-name minor-mode-list))))
  ;; generate the clone
  (let ((clone (clone-indirect-buffer
                (generate-new-buffer-name (buffer-name))
                t))) ;; t = display in new window
    (with-current-buffer clone
      ;; disable all buffer-local minor modes initially
      (dolist (mode minor-mode-list)
        (when (and (boundp mode)
                   (symbol-value mode)
                   (local-variable-p mode))
          (funcall mode 0)))
      ;; enable only selected modes
      (dolist (mode-name modes-to-enable)
        (let ((mode (intern mode-name)))
          (when (fboundp mode)
            (funcall mode 1)))))
    clone))
 )

(after! projectile
  (setq projectile-globally-ignored-files
        (append '(".DS_Store" "*.log" "*.tmp" "*.bak" "*.po")
                projectile-globally-ignored-files))

  (setq projectile-globally-ignored-directories
        (append '("node_modules" ".git" ".vscode" "dist" "build" ".cache")
                projectile-globally-ignored-directories)))

;; for literate programming
(after! org
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((python . t))))

(setq org-babel-python-command "python3")

;; ============ agentic ============
(setq GEMINI_API_KEY (getenv "GEMINI_API_KEY"))
(setq agent-shell-google-authentication
      (agent-shell-google-make-authentication :api-key GEMINI_API_KEY))

;; qwen code
(setq agent-shell-qwen-authentication
      (agent-shell-qwen-make-authentication :login t))

;; goose
(setq OPENROUTER_API_KEY (getenv "OPENROUTER_API_KEY"))
(setq agent-shell-goose-authentication
        (agent-shell-make-goose-authentication :openai-api-key OPENROUTER_API_KEY)) 

;; misral
(setq MISTRAL_API_KEY (getenv "MISTRAL_API_KEY"))
(setq agent-shell-mistral-authentication
      (agent-shell-mistral-make-authentication :api-key MISTRAL_API_KEY))

;; ============ misc ============
;; timer
(setq chronos-notification-wav "~/thirdparty/sounds/timer.wav")
(add-hook! 'chronos-expiry-functions #'chronos-sound-notify #'chronos-desktop-notifications-notify)

;; python
;; (setq lsp-disabled-clients '(pylsp))

;; misc
;; ==========
(blink-cursor-mode t)
(setq +zen-text-scale 1.1)

;; fix W293 pylsp
(defun fix-pylsp-W293-warning ()
  (interactive)
  (if (eq major-mode 'python-mode)
      (doom-file-write (buffer-file-name) (s-join "\n" (mapcar #'s-trim-right
                                                (vc--read-lines (buffer-file-name))))
                       :append nil
      )))

(defun fix-noqa (a) 
        (interactive "s")
        (end-of-line)
        (let* ((x a)
               (args (append '("  # noqa: ") (list x))))
        (insert (s-join "" args)))
)

(defun copy-line-above ()
  (interactive)
  (forward-line -1)
  (setq line (buffer-substring (line-beginning-position) (line-end-position)))
  (open-line 1)
  (insert line)
  (forward-line 1)
  (beginning-of-line)
)
(keymap-global-set "C-x l" #'copy-line-above)

(define-key evil-normal-state-map (kbd "SPC i n") #'fix-noqa) 
(define-key evil-normal-state-map (kbd "SPC i g") #'golden-ratio-mode)
(define-key evil-insert-state-map (kbd "C-x C-s") #'save-buffer)
(define-key evil-insert-state-map (kbd "C-S-f") #'forward-line)
(define-key evil-insert-state-map (kbd "C-S-b") #'ibuffer-backward-line)
(define-key evil-normal-state-map (kbd "SPC e e d") #'powerthesaurus-hydra/powerthesaurus-lookup-definitions-dwim-and-exit)
(define-key evil-normal-state-map (kbd "SPC e l") #'avy-copy-line)
(define-key evil-normal-state-map (kbd "SPC e r") #'avy-copy-region)
(define-key evil-normal-state-map (kbd "SPC h r F") #'doom/set-font)
;; (define-key evil-normal-state-map (kbd "SPC t F") #'(lambda ()
;;                                                       (setq global-flycheck-mode
;;                                                             (xor global-flycheck-mode t))))


(define-key evil-normal-state-map (kbd "SPC p t")
            #'(lambda ()
                (interactive)
                (org-capture-goto-target "pt")))

(define-key evil-normal-state-map (kbd "SPC p n")
            #'(lambda ()
                (interactive)
                (org-capture-goto-target "pn")))
(define-key evil-normal-state-map (kbd "SPC z f") #'consult-flycheck)
(define-key evil-normal-state-map (kbd "SPC z m") #'consult-man)
(define-key evil-normal-state-map (kbd "SPC z g") #'consult-gh)
(define-key evil-normal-state-map (kbd "SPC z i") #'consult-info)

;; magit/forge
;; (with-eval-after-load 'magit
;;   (require 'forge))
(setq auth-sources '("~/.authinfo"))
(setq-default vterm-shell "/usr/bin/fish")
(setq-default explicit-shell-file-name "/usr/bin/fish")


;; mail
(autoload 'wl "wl" "Wanderlust" t)
