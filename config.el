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
;; (setq doom-theme 'doom-one)
;; (setq doom-theme 'modus-vivendi-tinted)
;; (setq doom-theme 'modus-vivendi-tritanopia)
(setq doom-theme 'gruber-darker)
;; (setq doom-theme 'doom-horizon)
;; (setq doom-theme 'doom-henna)

;; paths
(add-to-list 'load-path "~/.config/doom/lisp/") 

;; require
(require 'acp)
(require 'agent-shell)
(require 'org-bullets)
(use-package org-bullets
  :load-path "~/.config/doom/lisp/"
  )

;; c-lsp
(after! c-ts-mode
  ;; Remap traditional major modes to Tree-sitter versions
  (setq major-mode-remap-alist '((c-mode . c-ts-mode))))

;; display-side-numbers
(setq display-line-numbers-width 2)
(set-face-attribute 'line-number nil :background nil)

(custom-theme-set-faces! 'gruber-darker
     '(diredfl-dir-name :foreground "#708090")
     '(diredfl-file-suffix :foreground "#708090")
     '(diredfl-mode :foreground "#708090")
     '(diredfl-number :foreground "#708090")
     '(diredfl-read-priv :foreground unspecified)
     '(diredfl-write-priv :foreground unspecified)
     '(diredfl-exec-priv :foreground unspecified)
     '(diredfl-date-time :foreground unspecified)
     '(diredfl-no-priv :foreground unspecified)
     '(diredfl-file-name :foreground unspecified)
     '(diredfl-dir-heading :underline unspecified)
     '(diredfl-dir-priv :foreground unspecified)

     (set-face-attribute 'doom-dashboard-menu-title nil :weight 'normal)
)

;; org
;; make org-headlines unbold
(after! org
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

(defun collapse-org-headings ()
  (org-cycle-global 1)
)
(add-hook 'org-mode-hook 'collapse-org-headings)


(setq opacity 95)
(setq display-line-numbers-type 'relative)
(let* ((opacity-parameter-name
        (if (eq window-system 'pgtk)
        'alpha-background
        'alpha))
        (param-list `((,opacity-parameter-name . ,opacity))))

(modify-all-frames-parameters param-list))

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

             ("R" "Read" entry
              (file+headline "~/org/reading.list.org" "inbox")
              "* %?")
             ))
    (add-to-list 'org-capture-templates tpl))

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

  )

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
(after! embark
 (define-key global-map (kbd "C-:") #'embark-act)
 (define-key global-map (kbd "C-\"") #'embark-export)
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

;; agentic
(defun agent-shell-start-gemini-agent ()
  "Start an interactive Gemini CLI agent shell."
  (interactive)
  (agent-shell--start
   :new-session t
   :mode-line-name "Gemini"
   :buffer-name "Gemini"
   :shell-prompt "Gemini> "
   :shell-prompt-regexp "Gemini> "
   :needs-authentication t
   :authenticate-request-maker (lambda ()
                                 (acp-make-authenticate-request :method-id "gemini-api-key"))
   :client-maker (lambda ()
                   (acp-make-client :command "gemini"
                                    :command-params '("--experimental-acp")
                                    :environment-variables (list (format "GEMINI_API_KEY=%s" (agent-shell-google-key)))))))

;; misc
(setq blink-cursor-mode t);
