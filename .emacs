;;------------------
;; Mac Version ( with zsh and screen )
;; Isao Nakamura ( 0x0082@gmail.com )
;; Last Modified: 08/5/24
;;------------------
;; Keybind
(define-key global-map "\C-h" 'delete-backward-char) ; 削除
(define-key global-map "\C-z" 'undo)                 ; undo
(define-key global-map "\C-c;" 'comment-region)      ; コメントアウト
(define-key global-map "\C-c:" 'uncomment-region)    ; コメント解除

;; 一つ後のウィンドウ
(global-set-key "\C-x\C-n" 'other-window)
;; 一つ前のウィンドウ
(global-set-key "\C-x\C-p" 'other-window-backward)
(defun other-window-backward (&optional n)
  "Select Nth previous window."
  (interactive "p")
  (other-window (- (prefix-numeric-value n))))

; バッファ移動 (terminal内で起動のcarbon emacsでは,とか.のショートカットが動作せず
(defun my-select-visible (blst n)
  (let ((buf (nth n blst)))
    (cond ((= n (- (length blst) 1)) (other-buffer))
	  ((not (= (aref (buffer-name buf) 0) ? )) buf)
	  (t (my-select-visible blst (+ n 1))))))
(defun my-grub-buffer ()
  (interactive)
  (switch-to-buffer (my-select-visible
		     (reverse (cdr (assq 'buffer-list (frame-parameters)))) 0)))
(global-set-key [?\C-,] 'my-grub-buffer)
(global-set-key [?\C-.] 'bury-buffer)

;;------------------
;; zsh
;;------------------
;; shell-mode でエスケープを綺麗に表示
(autoload 'ansi-color-for-comint-mode-on "ansi-color"
     "Set `ansi-color-for-comint-mode' to t." t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; shell-modeで上下でヒストリ補完 < 効いてない?
(add-hook 'shell-mode-hook
	  (function (lambda ()
		      (define-key shell-mode-map [up] 'comint-previous-input)
		      (define-key shell-mode-map [down] 'comint-next-input))))

;;------------------
;; Mac
;;------------------
;; Mac Keybind
(setq mac-command-key-is-meta nil)
(setq mac-option-modifier 'meta)

;;transparents for carbonEmacs　
;(set-alpha 98)

;; Fullscreen
;;(mac-toggle-max-window)
;;(setq default-frame-alist
;;      (append (list
;;	       '(height . 50)
;;	       )))

;;------------------
;; Color
;;------------------
;; Color
(if window-system (progn
;    (setq initial-frame-alist '((width . 150) (height . 42) (top . 0) (left . 0)))
    (setq initial-frame-alist '((width . 180)))
    (set-background-color "gray21")
    (set-foreground-color "LightGray")
    (set-cursor-color "SteelBlue")
    )
)

;; 色を付ける
;(global-font-lock-mode t)
;(setq font-lock-support-mode 'fast-lock-mode)
;(setq font-lock-maximum-decoration t)
;(setq fast-lock-cache-directories '("~/.emacs-flc" "."))

(show-paren-mode 1)  ; 対応する括弧を光らせる
(transient-mark-mode 1) ; マーク範囲に色をつける

;;------------------
;; Extensions
;;------------------
;; abbrev
(require 'auto-complete)
(global-auto-complete-mode t)

;; Tramp(ssh file access)
(require 'tramp)
(add-to-list
 'tramp-multi-connection-function-alist
 '("sshp7022" tramp-multi-connect-rlogin "ssh %h -l %u -p 7022%n")) ; port 7022

;; make svn the default version control system
(add-to-list 'vc-handled-backends 'SVN)

;; screen like
;;(load "elscreen")
;;(elscreen-set-prefix-key "\C-t")
;;(setq elscreen-display-tab nil)

;; save file session (auto create .session)(C-x C-f M-p
(require 'session)
(add-hook 'after-init-hook 'session-initialize)
(setq session-undo-check -1) ;前回閉じた位置にカーソルを復帰

;; inf-ruby run-ruby C-c C-s C-c C-l
(autoload 'ruby-mode "ruby-mode"
  "Mode for editing ruby source files" t)
(setq auto-mode-alist
      (append '((".rb$" . ruby-mode)) auto-mode-alist))
(setq interpreter-mode-alist (append '(("ruby" . ruby-mode))
				     interpreter-mode-alist))
(autoload 'run-ruby "inf-ruby"
  "Run an inferior Ruby process")
(autoload 'inf-ruby-keys "inf-ruby"
  "Set local key defs for inf-ruby in ruby-mode")
(add-hook 'ruby-mode-hook
	            '(lambda ()
		       (inf-ruby-keys)))

;;to use scheme
;(autoload 'run-scheme "cmuscheme" "Run an inferior Scheme process." t)
;(defun run-guile ()(interactive) (run-scheme "guile"))
;(defun run-gauche ()(interactive) (run-scheme "gosh"))

;;------------------
;; Misc
;;------------------
;; uncomment this line to disable loading of "default.el" at startup
; (setq inhibit-default-init t)

(setq inhibit-startup-message t)  ; 起動画面消去

(setq visible-bell t) ; visible beep

;; enable visual feedback on selections
;(setq transient-mark-mode t)

;; turn on font-lock mode
;(when (fboundp 'global-font-lock-mode)
;  (global-font-lock-mode t))

;; default to better frame titles
(setq frame-title-format
      (concat  "%b - emacs@" (system-name)))

(setq diff-switches "-u")  ; default to unified diffs

(setq backup-inhibited t)  ; バックアップファイルを作らない
(setq delete-auto-save-files t)  ; 終了時にオートセーブファイルを消す
;(setq make-backup-files nil)  ; dont create ~ file for backup
;(setq auto-save-default nil)  ; dont create # file for backup

(iswitchb-mode 1) ; バッファ一覧を表示 C-x b
(tool-bar-mode 0)  ; ツールバーを消す
(toggle-scroll-bar nil) ; スクロールバーを消す

(setq completion-ignore-case t)  ; 補完時に大文字小文字を区別しない

;; 強力な補完機能を使う
;; p-bでprint-bufferとか
;(load "complete")
(partial-completion-mode 1)

(icomplete-mode 1)  ; 補完可能なものを随時表示(少しうるさい)

(column-number-mode t)  ; カーソルの位置が何文字目かを表示
(line-number-mode t)  ; カーソルの位置が何行目かを表示

(setq scroll-step 1)  ; スクロールを一行ずつに

(setq kill-whole-line t)  ; 行の先頭でC-kを一回押すだけで行全体を消去

(setq require-final-newline t)  ; 最終行に必ず一行挿入
;(setq require-final-newline 'query)  ; always end a file with a newline

(if window-system (menu-bar-mode 1) (menu-bar-mode -1))  ; emacs -nw で起動した時にメニューバーを消す

;;------------------
;; Experiment
;;------------------
;;; migemo (failed)
;; (setq exec-path
;;         (append
;;             (list "/usr/local/bin" "/opt/local/bin" "/sw/bin" "/usr/bin")exec-path)) 
;; (setenv "PATH";;          (concat '"/usr/local/bin:/opt/local/bin:/sw/bin:" (getenv "PATH")))
;; (add-to-list 'load-path "~/.emacs.d/")
;; ;;(setq load-path (cons (expand-file-name "~/.emacs.d/") load-path))
;; (load "migemo")
;; (setq migemo-command "cmigemo")
;; (setq migemo-options '("-q" "--emacs" "-i" "\a"))
;; (setq migemo-dictionary "/usr/local/share/migemo/utf-8/migemo-dict")
;; (setq migemo-user-dictionary nil)
;; (setq migemo-regex-dictionary nil)

;;;
;;; ECB
;;;
;; (setq load-path (cons (expand-file-name "~/.emacs.d/") load-path))
;; (defun try-complete-abbrev (old)
;;        (if (expand-abbrev) t nil))
;; (setq hippie-expand-try-functions-list
;;       '(try-complete-abbrev
;;         try-complete-file-name
;;         try-expand-dabbrev))
;; (require 'cl)
;; (require 'rails)

;;; 
;;;  Ruby and Rails
;; 
;; (autoload 'ruby-mode "ruby-mode" "Mode for editing ruby source files" t)
;; (setq auto-mode-alist
;;       (append '(("\\.rb$" . ruby-mode)) auto-mode-alist))
;; (setq interpreter-mode-alist (append '(("ruby" . ruby-mode))
;;                                           interpreter-mode-alist))
;; (autoload 'run-ruby "inf-ruby" "Run an inferior Ruby process")
;; (autoload 'inf-ruby-keys "inf-ruby" "Set local key defs for inf-ruby in ruby-mode")
;; (add-hook 'ruby-mode-hook
;;           '(lambda ()
;;             (inf-ruby-keys)))
;; (modify-coding-system-alist 'file "\\.rb$" 'utf-8)
;; (modify-coding-system-alist 'file "\\.rhtml$" 'utf-8)
;; (require 'cl)
;; (require 'rails)
;; (define-key rails-minor-mode-map "\C-c,"  'rails-nav:goto-controllers)
;; (define-key rails-minor-mode-map "\C-c."  'rails-nav:goto-models)
;; (define-key rails-minor-mode-map "\C-c/"  'rails-nav:goto-helpers)
;; (define-key rails-minor-mode-map "\C-cv"  'rails-find-view)
