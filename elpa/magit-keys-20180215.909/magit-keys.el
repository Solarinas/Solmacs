;;; magit-keys.el --- Keyboard shortcuts for magit functions. -*- lexical-binding: t -*-

;; Filename: magit-keys.el
;; Description: Keyboard shortcuts for magit functions.
;; Author: Dmitry K. <beerandhot@gmail.com>
;; Package-Requires: ((emacs "24.4") (magit "2.8"))
;; Package-Version: 20180215.909
;; Version: 0.0.1
;; Keywords: keys
;; Homepage: https://github.com/a13/magit-keys.el

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; For a full copy of the GNU General Public License
;; see <http://www.gnu.org/licenses/>.

;;; Commentary:
;; This package adds default bindings to some frequently used magit (and, optionally, magithub) functions.
;; Usage: (magit-keys-mode 1) or M-x magit-keys-mode

;;; Code:

(require 'magit)

(defgroup magit-keys nil
  "Manage and navigate projects easily."
  :group 'magit
  :link '(url-link :tag "Github" "https://github.com/a13/magit-keys.el"))

(defcustom magit-keys-keymap-prefix (kbd "C-c m")
  "Projectile keymap prefix."
  :group 'magit-keys
  :type 'key-sequence)

(defvar magit-keys-keymap-alist
  '(("a" . magit-stage-file) ; the closest analog to git add
    ("b" . magit-blame)
    ("B" . magit-branch)
    ("c" . magit-checkout)
    ("C" . magit-commit)
    ("d" . magit-diff)
    ("D" . magit-discard)
    ("f" . magit-fetch)
    ("g" . vc-git-grep)
    ("G" . magit-gitignore)
    ("i" . magit-init)
    ("l" . magit-log)
    ("m" . magit)
    ("M" . magit-merge)
    ("n" . magit-notes-edit)
    ("p" . magit-pull)
    ("P" . magit-push)
    ("r" . magit-reset)
    ("R" . magit-rebase)
    ("s" . magit-status)
    ("S" . magit-stash)
    ("t" . magit-tag)
    ("T" . magit-tag-delete)
    ("u" . magit-unstage)
    ("U" . magit-update-index)))

;; taken from point-im.el
;; TODO: move to a separate library?
(defun magit-keys-define-keys (map keymap-alist)
  "Add key bindings to MAP taken from KEYMAP-ALIST."
  (mapc
   (lambda (keydef)
     (pcase keydef
       (`(,key . ,def)
        (define-key map (kbd key) def))))
   keymap-alist)
  map)

;;; Minor mode
(defvar magit-keys-command-map
  (let ((map (make-sparse-keymap)))
    (magit-keys-define-keys map magit-keys-keymap-alist)
    map)
  "Keymap for Magit commands after `magit-keys-keymap-prefix'.")
(fset 'magit-keys-command-map magit-keys-command-map)

(defvar magit-keys-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map magit-keys-keymap-prefix 'magit-keys-command-map)
    map)
  "Keymap for Magit keys mode.")

(define-minor-mode magit-keys-mode
  "Toggle Magit Keys mode."
  :init-value nil
  :keymap magit-keys-mode-map
  :group 'magit-keys
  :require 'magit-keys
  :global t)

(provide 'magit-keys)

;;; magit-keys.el ends here
