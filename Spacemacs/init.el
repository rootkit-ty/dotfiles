;; -*- mode: emacs-lisp -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  "Configuration Layers declaration.
You should not put any user code in this function besides modifying the variable
values."
  (setq-default
   ;; Base distribution to use. This is a layer contained in the directory
   ;; `+distribution'. For now available distributions are `spacemacs-base'
   ;; or `spacemacs'. (default 'spacemacs)
   dotspacemacs-distribution 'spacemacs

   ;; Lazy installation of layers (i.e. layers are installed only when a file
   ;; with a supported type is opened). Possible values are `all', `unused'
   ;; and `nil'. `unused' will lazy install only unused layers (i.e. layers
   ;; not listed in variable `dotspacemacs-configuration-layers'), `all' will
   ;; lazy install any layer that support lazy installation even the layers
   ;; listed in `dotspacemacs-configuration-layers'. `nil' disable the lazy
   ;; installation feature and you have to explicitly list a layer in the
   ;; variable `dotspacemacs-configuration-layers' to install it.
   ;; (default 'unused)
   dotspacemacs-enable-lazy-installation 'unused
   ;; If non-nil then Spacemacs will ask for confirmation before installing
   ;; a layer lazily. (default t)
   dotspacemacs-ask-for-lazy-installation t
   ;; If non-nil layers with lazy install support are lazy installed.
   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '()
   ;; List of configuration layers to load.
   dotspacemacs-configuration-layers
   '(
     ;; ----------------------------------------------------------------
     ;; Example of useful layers you may want to use right away.
     ;; Uncomment some layer names and press <SPC f e R> (Vim style) or
     ;; <M-m f e R> (Emacs style) to install them.
     ;; ----------------------------------------------------------------

     helm
     elfeed
     git
     finance
     fasd
     (mu4e :variables
           mu4e-installation-path "/usr/local/Cellar/mu/1.0/share/emacs/site-lisp/mu/mu4e"
           mu4e-enable-notifications t
           mu4e-enable-mode-line t
           )
     (shell :variables
            shell-default-height 30
            shell-default-position 'bottom
            shell-default-shell 'eshell)

     auto-completion
     spell-checking
     shell-scripts
     syntax-checking
     version-control
     nlinum


     (evil-snipe :variables evil-snipe-enable-alternate-f-and-t-behaviors t)
     evil-commentary

     yaml
     csv

     html
     markdown
     org

     emacs-lisp
     python
     javascript
     )
   ;; List of additional packages that will be installed without being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages, then consider creating a layer. You can also put the
   ;; configuration in `dotspacemacs/user-config'.
   dotspacemacs-additional-packages '(fzf org-bullets ranger smart-tab helm-org-rifle epresent ob-async org-super-agenda real-auto-save doom-themes org-board bbdb helm-bbdb bbdb-handy)
   ;; A list of packages that cannot be updated.
   dotspacemacs-frozen-packages '()
   ;; A list of packages that will not be installed and loaded.
   dotspacemacs-excluded-packages '()
   ;; Defines the behaviour of Spacemacs when installing packages.
   ;; Possible values are `used-only', `used-but-keep-unused' and `all'.
   ;; `used-only' installs only explicitly used packages and uninstall any
   ;; unused packages as well as their unused dependencies.
   ;; `used-but-keep-unused' installs only the used packages but won't uninstall
   ;; them if they become unused. `all' installs *all* packages supported by
   ;; Spacemacs and never uninstall them. (default is `used-only')
   dotspacemacs-install-packages 'used-only))

(defun dotspacemacs/init ()
  "Initialization function.
This function is called at the very startup of Spacemacs initialization
before layers configuration.
You should not put any user code in there besides modifying the variable
values."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; If non nil ELPA repositories are contacted via HTTPS whenever it's
   ;; possible. Set it to nil if you have no way to use HTTPS in your
   ;; environment, otherwise it is strongly recommended to let it set to t.
   ;; This variable has no effect if Emacs is launched with the parameter
   ;; `--insecure' which forces the value of this variable to nil.
   ;; (default t)
   dotspacemacs-elpa-https t
   ;; Maximum allowed time in seconds to contact an ELPA repository.
   dotspacemacs-elpa-timeout 5
   ;; If non nil then spacemacs will check for updates at startup
   ;; when the current branch is not `develop'. Note that checking for
   ;; new versions works via git commands, thus it calls GitHub services
   ;; whenever you start Emacs. (default nil)
   dotspacemacs-check-for-update nil
   ;; If non-nil, a form that evaluates to a package directory. For example, to
   ;; use different package directories for different Emacs versions, set this
   ;; to `emacs-version'.
   dotspacemacs-elpa-subdirectory nil
   ;; One of `vim', `emacs' or `hybrid'.
   ;; `hybrid' is like `vim' except that `insert state' is replaced by the
   ;; `hybrid state' with `emacs' key bindings. The value can also be a list
   ;; with `:variables' keyword (similar to layers). Check the editing styles
   ;; section of the documentation for details on available variables.
   ;; (default 'vim

   dotspacemacs-editing-style 'vim
   ;; If non nil output loading progress in `*Messages*' buffer. (default nil)
   dotspacemacs-verbose-loading nil
   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to an image format supported
   ;; by your Emacs build.
   ;; If the value is nil then no banner is displayed. (default 'official)
   dotspacemacs-startup-banner 'official
   ;; List of items to show in startup buffer or an association list of
   ;; the form `(list-type . list-size)`. If nil then it is disabled.
   ;; Possible values for list-type are:
   ;; `recents' `bookmarks' `projects' `agenda' `todos'."
   ;; List sizes may be nil, in which case
   ;; `spacemacs-buffer-startup-lists-length' takes effect.
   dotspacemacs-startup-lists '((agenda . 5)
                                (todos . 10)
                                (recents . 5)
                                (projects . 7))
   ;; True if the home buffer should respond to resize events.
   dotspacemacs-startup-buffer-responsive t
   ;; Default major mode of the scratch buffer (default `text-mode')
   dotspacemacs-scratch-mode 'org-mode
   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press <SPC> T n to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(spacemacs-dark
                         spacemacs-light)
   ;; If non nil the cursor color matches the state color in GUI Emacs.
   dotspacemacs-colorize-cursor-according-to-state t
   ;; Default font, or prioritized list of fonts. `powerline-scale' allows to
   ;; quickly tweak the mode-line size to make separators look not too crappy.
   dotspacemacs-default-font '("Source Code Pro"
                               :size 15
                               :weight normal
                               :width normal
                               :powerline-scale 1.1)
   ;; The leader key
   dotspacemacs-leader-key "SPC"
   ;; The key used for Emacs commands (M-x) (after pressing on the leader key).
   ;; (default "SPC")
   dotspacemacs-emacs-command-key "SPC"
   ;; The key used for Vim Ex commands (default ":")
   dotspacemacs-ex-command-key ":"
   ;; The leader key accessible in `emacs state' and `insert state'
   ;; (default "M-m")
   dotspacemacs-emacs-leader-key "M-m"
   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it. (default ",")
   dotspacemacs-major-mode-leader-key ","
   ;; Major mode leader key accessible in `emacs state' and `insert state'.
   ;; (default "C-M-m")
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   ;; These variables control whether separate commands are bound in the GUI to
   ;; the key pairs C-i, TAB and C-m, RET.
   ;; Setting it to a non-nil value, allows for separate commands under <C-i>
   ;; and TAB or <C-m> and RET.
   ;; In the terminal, these pairs are generally indistinguishable, so this only
   ;; works in the GUI. (default nil)
   dotspacemacs-distinguish-gui-tab nil
   ;; If non nil `Y' is remapped to `y$' in Evil states. (default nil)
   dotspacemacs-remap-Y-to-y$ nil
   ;; If non-nil, the shift mappings `<' and `>' retain visual state if used
   ;; there. (default t)
   dotspacemacs-retain-visual-state-on-shift t
   ;; If non-nil, J and K move lines up and down when in visual mode.
   ;; (default nil)
   dotspacemacs-visual-line-move-text nil
   ;; If non nil, inverse the meaning of `g' in `:substitute' Evil ex-command.
   ;; (default nil)
   dotspacemacs-ex-substitute-global nil
   ;; Name of the default layout (default "Default")
   dotspacemacs-default-layout-name "Default"
   ;; If non nil the default layout name is displayed in the mode-line.
   ;; (default nil)
   dotspacemacs-display-default-layout nil
   ;; If non nil then the last auto saved layouts are resume automatically upon
   ;; start. (default nil)
   dotspacemacs-auto-resume-layouts nil
   ;; Size (in MB) above which spacemacs will prompt to open the large file
   ;; literally to avoid performance issues. Opening a file literally means that
   ;; no major mode or minor modes are active. (default is 1)
   dotspacemacs-large-file-size 1
   ;; Location where to auto-save files. Possible values are `original' to
   ;; auto-save the file in-place, `cache' to auto-save the file to another
   ;; file stored in the cache directory and `nil' to disable auto-saving.
   ;; (default 'cache)
   dotspacemacs-auto-save-file-location 'cache
   ;; Maximum number of rollback slots to keep in the cache. (default 5)
   dotspacemacs-max-rollback-slots 5
   ;; If non nil, `helm' will try to minimize the space it uses. (default nil)
   dotspacemacs-helm-resize nil
   ;; if non nil, the helm header is hidden when there is only one source.
   ;; (default nil)
   dotspacemacs-helm-no-header nil
   ;; define the position to display `helm', options are `bottom', `top',
   ;; `left', or `right'. (default 'bottom)
   dotspacemacs-helm-position 'bottom
   ;; Controls fuzzy matching in helm. If set to `always', force fuzzy matching
   ;; in all non-asynchronous sources. If set to `source', preserve individual
   ;; source settings. Else, disable fuzzy matching in all sources.
   ;; (default 'always)
   dotspacemacs-helm-use-fuzzy 'always
   ;; If non nil the paste micro-state is enabled. When enabled pressing `p`
   ;; several times cycle between the kill ring content. (default nil)
   dotspacemacs-enable-paste-transient-state nil
   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0.4
   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom
   ;; If non nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar t
   ;; If non nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil
   ;; If non nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native nil
   ;; If non nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (default nil) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup nil
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 90
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 90
   ;; If non nil show the titles of transient states. (default t)
   dotspacemacs-show-transient-state-title t
   ;; If non nil show the color guide hint for transient state keys. (default t)
   dotspacemacs-show-transient-state-color-guide t
   ;; If non nil unicode symbols are displayed in the mode line. (default t)
   dotspacemacs-mode-line-unicode-symbols t
   ;; If non nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters point
   ;; when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling t
   ;; Control line numbers activation.
   ;; If set to `t' or `relative' line numbers are turned on in all `prog-mode' and
   ;; `text-mode' derivatives. If set to `relative', line numbers are relative.
   ;; This variable can also be set to a property list for finer control:
   ;; '(:relative nil
   ;;   :disabled-for-modes dired-mode
   ;;                       doc-view-mode
   ;;                       markdown-mode
   ;;                       org-mode
   ;;                       pdf-view-mode
   ;;                       text-mode
   ;;   :size-limit-kb 1000)
   ;; (default nil)
   dotspacemacs-line-numbers nil
   ;; Code folding method. Possible values are `evil' and `origami'.
   ;; (default 'evil)
   dotspacemacs-folding-method 'evil
   ;; If non-nil smartparens-strict-mode will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode nil
   ;; If non-nil pressing the closing parenthesis `)' key in insert mode passes
   ;; over any automatically added closing parenthesis, bracket, quote, etc…
   ;; This can be temporary disabled by pressing `C-q' before `)'. (default nil)
   dotspacemacs-smart-closing-parenthesis nil
   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)
   dotspacemacs-highlight-delimiters 'all
   ;; If non nil, advise quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server nil
   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `ag', `pt', `ack' and `grep'.
   ;; (default '("ag" "pt" "ack" "grep"))
   dotspacemacs-search-tools '("ag" "pt" "ack" "grep")
   ;; The default package repository used if no explicit repository has been
   ;; specified with an installed package.
   ;; Not used for now. (default nil)
   dotspacemacs-default-package-repository nil
   ;; Delete whitespace while saving buffer. Possible values are `all'
   ;; to aggressively delete empty line and long sequences of whitespace,
   ;; `trailing' to delete only the whitespace at end of lines, `changed'to
   ;; delete only whitespace for changed lines or `nil' to disable cleanup.
   ;; (default nil)
   dotspacemacs-whitespace-cleanup nil
   ))

(defun dotspacemacs/user-init ()                                       :test:
  "Initialization function for user code.
It is called immediately after `dotspacemacs/init', before layer configuration
executes.
 This function is mostly useful for variables that need to be set
before packages are loaded. If you are unsure, you should try in setting them in
`dotspacemacs/user-config' first."
  )

(defun dotspacemacs/user-config ()
  "Configuration function for user code.
This function is called at the very end of Spacemacs initialization after
layers configuration.
This is the place where most of your configurations should be done. Unless it is
explicitly specified that a variable should be set before a package is loaded,
you should place your code here."

  (server-start)


  (add-to-list 'load-path "/Applications/org-protocol.app/")
  (require 'org-protocol)

  (setq undo-tree-auto-save-history t
        undo-tree-history-directory-alist
        `(("." . ,(concat spacemacs-cache-directory "undo"))))
  (unless (file-exists-p (concat spacemacs-cache-directory "undo"))
    (make-directory (concat spacemacs-cache-directory "undo")))


  (defun mu4e-compose-org-mail ()
    (interactive)
    (mu4e-compose-new)
    (org-mu4e-compose-org-mode))

  (defun htmlize-and-send ()
    "When in an org-mu4e-compose-org-mode message, htmlize and send it."
    (interactive)
    (when (member 'org~mu4e-mime-switch-headers-or-body post-command-hook)
      (org-mime-htmlize) 
      (message-send-and-exit)))

  (add-hook 'org-ctrl-c-ctrl-c-hook 'htmlize-and-send t)

  (defun my-org-screenshot-attach ()
    "Take a screenshot into a time stamped unique-named file in the
same directory as the org-buffer and insert a link to this file."
    (interactive)
    (org-display-inline-images)
    (setq filename
          (concat
           (make-temp-name
            (concat "/tmp/"
                    (format-time-string "%Y%m%d_%H%M%S_")) ) ".png"))
                                        ; take screenshot
    (if (eq system-type 'darwin)
        (call-process "screencapture" nil nil nil "-i" filename))
    (if (eq system-type 'gnu/linux)
        (call-process "import" nil nil nil filename))
                                        ; insert into file if correctly taken
    (if (file-exists-p filename)
        (org-attach-attach filename nil 'mv)))
  (defun my-org-screenshot-insert ()
    "Take a screenshot into a time stamped unique-named file in the
same directory as the org-buffer and insert a link to this file."
    (interactive)
    (org-display-inline-images)
    (setq filename
          (concat
           (make-temp-name
            (concat (file-name-nondirectory (buffer-file-name))
                    "_imgs/"
                    (format-time-string "%Y%m%d_%H%M%S_")) ) ".png"))
    (unless (file-exists-p (file-name-directory filename))
      (make-directory (file-name-directory filename)))
                                        ; take screenshot
    (if (eq system-type 'darwin)
        (call-process "screencapture" nil nil nil "-i" filename))
    (if (eq system-type 'gnu/linux)
        (call-process "import" nil nil nil filename))
                                        ; insert into file if correctly taken
    (if (file-exists-p filename)
        (insert (concat "[[file:" filename "]]"))))

  (defun do-org-board-dl-hook ()
    (when
	  (and (equal (buffer-name)
                 (concat "CAPTURE-" "inbox.org"))
		   (org-entry-properties nil "URL")
		   )
    (org-board-archive)))

  (custom-set-faces
   ;; custom-set-faces was added by Custom.
   ;; If you edit it by hand, you could mess it up, so be careful.
   ;; Your init file should contain only one such instance.
   ;; If there is more than one, they won't work right.
   '(org-mode-line-clock ((t (:foreground "red" :box (:line-width -1 :style released-button)))) t))

  (add-hook 'org-capture-before-finalize-hook 'do-org-board-dl-hook)

  (require 'org-habit)
  ;; Terminal buffer configuration.
  (add-hook 'term-mode-hook 'ltr-term-mode-speed-hack-hook)
  (defun ltr-term-mode-speed-hack-hook ()
    ;; https://debbugs.gnu.org/cgi/bugreport.cgi?bug=20611
    (setq bidi-paragraph-direction 'left-to-right))

  (require 'org-bullets)
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

  (require 'package)
  (add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)

  ;; Autosave orgmode documents
  (require 'real-auto-save)
  (add-hook 'org-mode-hook 'real-auto-save-mode)

  (require 'doom-themes)

  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled

  ;; Load the theme (doom-one, doom-molokai, etc); keep in mind that each theme
  ;; may have their own settings.
  (load-theme 'doom-one t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)

  ;; Enable custom neotree theme (all-the-icons must be installed!)
  (doom-themes-neotree-config)
  ;; or for treemacs users
  (doom-themes-treemacs-config)

  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config)

  (setq display-line-numbers 'visual)

  ;; TODO Make this not macos reliant
  (setq multi-term-program "/usr/local/bin/fish")

  (if (eq system-type 'darwin) (setq helm-locate-fuzzy-match nil))


  (setq org-directory "~/Documents/Notes/")
  (setq org-archive-location "~/Documents/Notes/Archive/%s_archive::")
  (setq org-default-notes-file (concat org-directory "/inbox.org"))
  (setq org-agenda-files (directory-files-recursively org-directory "^[A-Za-z\/~_-]*\.org$"))
  (setq org-refile-targets
        '((nil :maxlevel . 9)
          (org-agenda-files :maxlevel . 5)))

  (setq org-todo-keywords
        '((sequence "TODO(t)" "WAIT(w@/!)" "STARTED(s@/!)" "APPOINTMENT(a)" "RECURRING(r)" "NEXT(n)" "|" "DONE(d@/!)" "CANCELED(c@)" "DEFFERED(D@)")))
  (setq org-agenda-dim-blocked-tasks t)
  (setq org-capture-templates
        (quote
         (("M" "Meeting minutes" entry
           (file+olp+datetree "~/Documents/Notes/work.org" "Minutes")
           "* TODO %? - %U\n** Attendees\n** Notes" :clock-in t :clock-resume t)
          ("p" "Phone call" entry
           (file+headline "~/Documents/Notes/inbox.org" "Phone")
           "* PHONE %?  :PHONE:\n%U" :clock-in t :clock-resume t)
          ("i" "Interruption" entry
           (file+olp+datetree "~/Documents/Notes/Personal/interruptions.org" "Interruptions")
           "* %?  \n%U" :clock-in t :clock-resume t)
          ("t" "Task to be refiled later" entry
           (file+headline "~/Documents/Notes/inbox.org" "Tasks")
           "* TODO %?
 %a" :clock-in t :clock-resume t)
          ("I" "Ideas" entry
           (file "~/Documents/Notes/Personal/ideas.org")
           "* %?
 %i")
          ("s" "Snippets" entry
           (file+headline "~/Documents/Notes/inbox.org" "Snippets")
           "* %^{Title}
Source: %u, %c
 #+BEGIN_QUOTE
%i
#+END_QUOTE
[[%:link][%:description]]
%?")
     ("q" "Quotes" entry
      (file+headline "~/Documents/Notes/inbox.org" "Quotes")
      "* %^{Title}
:PROPERTIES:
:URL: %:link
:END:

Source: %u, [[%:link][%:description]]
#+BEGIN_QUOTE
%i
#+END_QUOTE
%?")
     ("b" "Bookmarks" entry
      (file+headline "~/Documents/Notes/inbox.org" "Bookmarks")
      "* %?[[%:link][%:description]]
:PROPERTIES:
:URL: %:link
:END:
Captured On: %U" :immediate-finish t)
     ("j" "Journal Entries" entry
      (file+olp+datetree "~/Documents/Notes/personal.org" "Journal")
      "* %U - %^{Title}
%i
%?")
     ("T" "TIL" entry
      (file+olp+datetree "~/Documents/Notes/personal.org" "TIL")
      "* %U - Today I learnt: %^{Title}
%i
Today I learnt %?")
     )))
  (setq org-todo-keyword-faces
        (quote (("TODO" :foreground "orange" :weight bold)
                ("NEXT" :foreground "red" :weight bold)
                ("WAIT" :foreground "deep sky blue" :weight bold)
                ("DONE" :foreground "forest green" :weight bold)
                ("STARTED" :foreground "Blue" :weight bold)
                ("APPOINTMENT" :foreground "magenta" :weight bold)
                ("RECURRING" :foreground "magenta" :weight bold)
                ("DEFFERED" :foreground "forest green" :weight bold)
                ("CANCELLED" :foreground "forest green" :weight bold))))


 (setq org-confirm-babel-evaluate nil)
 (setq org-enforce-todo-dependencies t)
 (setq org-export-backends (quote (ascii beamer html icalendar latex md odt)))
 (setq org-goto-interface (quote outline-path-completion))
 (setq org-habit-graph-column 60)
 (setq org-habit-preceding-days 14)
 (setq org-outline-path-complete-in-steps nil)
 (setq org-refile-allow-creating-parent-nodes (quote confirm))
 (setq org-refile-use-outline-path (quote file))
 (setq org-todo-repeat-to-state "RECURRING")

  (setq org-agenda-custom-commands
        '(
          ("w" "Super Work Daily agenda"(
                                         (agenda "" ((org-super-agenda-groups
                                                      '((:log t)  ; Automatically named "Log"
                                                        (:name "Schedule"
                                                               :time-grid t)
                                                        (:name "Overdue"
                                                               :deadline past)
                                                        (:name "Due today"
                                                               :deadline today)
                                                        (:name "Today"
                                                               :scheduled today)
                                                        (:habit t)
                                                        (:name "Scheduled earlier"
                                                               :scheduled past)))
                                                     (org-agenda-span 1)))
                                         (tags-todo "+@work-STYLE=\"habit\""
                                                    ((org-super-agenda-groups
                                                      '(
                                                        (:name "Important"
                                                               :priority "A")
                                                        (:name "Inbox"
                                                               :tag "INBOX")
                                                        (:name "Waiting"
                                                               :todo "WAIT")
                                                        (:name "Next"
                                                               :time-grid t
                                                               :todo "NEXT")
                                                        (:name "Projects"
                                                               :children t)
                                                        (:name "Quick Picks"
                                                               :effort< "0:30")
                                                        (:discard (:anything t))
                                                        ))
                                                     (org-agenda-overriding-header "")))
                                         (tags-todo "+{@computer\\|@laptop\\|@phone\\|@melbourne\\|@online}-{@work\\|work}-STYLE=\"habit\""
                                                    ((org-super-agenda-groups
                                                      '(
                                                        (:name "Important"
                                                               :priority "A")
                                                        (:name "Inbox"
                                                               :tag "INBOX")
                                                        (:name "Waiting"
                                                               :todo "WAIT")
                                                        (:name "Next"
                                                               :time-grid t
                                                               :todo "NEXT")
                                                        (:name "Projects"
                                                               :children t)
                                                        (:name "Quick Picks"
                                                               :effort< "0:30")
                                                        (:discard (:anything t))
                                                        ))
                                                     (org-agenda-overriding-header "")))
                                         ))
          ("p" "Super Work Daily agenda"(
                                         (agenda "" ((org-super-agenda-groups
                                                      '((:log t)  ; Automatically named "Log"
                                                        (:name "Schedule"
                                                               :time-grid t)
                                                        (:name "Overdue"
                                                               :deadline past)
                                                        (:name "Due today"
                                                               :deadline today)
                                                        (:name "Today"
                                                               :scheduled today)
                                                        (:habit t)
                                                        (:name "Scheduled earlier"
                                                               :scheduled past)))
                                                     (org-agenda-span 1)))
                                         (tags-todo "+{@computer\\|@laptop\\|@phone\\|@melbourne\\|@online\\|@home}-{@work\\|work}-STYLE=\"habit\""
                                                    ((org-super-agenda-groups
                                                      '(
                                                        (:name "Important"
                                                               :priority "A")
                                                        (:name "Inbox"
                                                               :tag "INBOX")
                                                        (:name "Waiting"
                                                               :todo "WAIT")
                                                        (:name "Next"
                                                               :time-grid t
                                                               :todo "NEXT")
                                                        (:name "Projects"
                                                               :children t)
                                                        (:name "Quick Picks"
                                                               :effort< "0:30")
                                                        (:discard (:anything t))
                                                        ))
                                                     (org-agenda-overriding-header "")))
                                         ))
        ))

  (spacemacs/set-leader-keys
    "bq" 'kill-buffer-and-window)


  (org-babel-do-load-languages
   'org-babel-load-languages
   '((shell         . t)
     (python        . t)
     ))

  (setq custom-file "~/.spacemacs.d/custom.el")
  (load-file custom-file)
  (load-file "~/.spacemacs.d/private.el")

  (add-hook 'python-mode-hook 'anaconda-mode)
  (add-hook 'sauron-event-added-functions 'sauron-alert-el-adapter)
  (sauron-start-hidden)
  (pinentry-start)

)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (magit ghub treepy graphql zoom yapfify yaml-mode xterm-color ws-butler winum which-key web-mode web-beautify volatile-highlights vi-tilde-fringe uuidgen use-package toc-org tagedit spaceline smeargle smart-tab slim-mode shell-pop scss-mode sauron sass-mode restart-emacs real-auto-save ranger rainbow-delimiters q4 pyvenv pytest pyenv-mode py-isort pug-mode pip-requirements pinentry persp-mode pcre2el paradox orgit org-super-agenda org-projectile org-present org-pomodoro org-mime org-download org-bullets org-board open-junk-file ob-async nlinum-relative neotree multi-term mu4e-maildirs-extension mu4e-alert move-text mmm-mode markdown-toc magit-gitflow macrostep lorem-ipsum livid-mode live-py-mode link-hint less-css-mode ledger-mode json-mode js2-refactor js-doc insert-shebang indent-guide hy-mode hungry-delete htmlize hl-todo highlight-parentheses highlight-numbers highlight-indentation helm-themes helm-swoop helm-pydoc helm-projectile helm-org-rifle helm-mode-manager helm-make helm-gitignore helm-flx helm-descbinds helm-css-scss helm-company helm-c-yasnippet helm-bbdb helm-ag google-translate golden-ratio gnuplot gitconfig-mode gitattributes-mode git-timemachine git-messenger git-link git-gutter-fringe git-gutter-fringe+ gh-md fzf fuzzy flyspell-correct-helm flycheck-pos-tip flycheck-ledger flx-ido fish-mode fill-column-indicator fasd fancy-battery eyebrowse expand-region exec-path-from-shell evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-surround evil-snipe evil-search-highlight-persist evil-numbers evil-mc evil-matchit evil-magit evil-lisp-state evil-indent-plus evil-iedit-state evil-exchange evil-escape evil-ediff evil-commentary evil-args evil-anzu eval-sexp-fu eshell-z eshell-prompt-extras esh-help epresent emmet-mode elisp-slime-nav elfeed-web elfeed-protocol elfeed-org elfeed-goodies dumb-jump doom-themes diminish diff-hl define-word cython-mode csv-mode company-web company-tern company-statistics company-shell company-anaconda column-enforce-mode coffee-mode clean-aindent-mode auto-yasnippet auto-highlight-symbol auto-dictionary auto-compile aggressive-indent adaptive-wrap ace-window ace-link ace-jump-helm-line ac-ispell))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
