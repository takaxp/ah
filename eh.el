;;; eh.el --- Extended hooks -*- lexical-binding: t; -*-

;; Copyright (C) 2019 Takaaki ISHIKAWA

;; Author: Takaaki ISHIKAWA <takaxp at ieee dot org>
;; Keywords: convenience
;; Version: 0.9.0
;; Maintainer: Takaaki ISHIKAWA <takaxp at ieee dot org>
;; URL: https://github.com/takaxp/eh
;; Package-Requires: ((emacs "25.1"))
;; Twitter: @takaxp

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Commentary:

;; This package provides a set of extended hooks.
;; - eh-before-move-cursor-hook
;; - eh-after-move-cursor-hook

;;; Change Log:

;;; Code:

;; `eh-before-move-cursor-hook' and `eh-after-move-cursor-hook'

(defcustom eh-before-move-cursor-hook nil
  "Hook runs before moving the cursor."
  :type 'hook
  :group 'convenience)

(defcustom eh-after-move-cursor-hook nil
  "Hook runs after moving the cursor."
  :type 'hook
  :group 'convenience)

(defun eh--cur-next-line (f &optional arg try-vscroll)
  "Extend `next-line'.
F is the original function.
ARG and TRY-VSCROLL are identical to the original arguments."
  (run-hooks 'eh-before-move-cursor-hook)
  (funcall f arg try-vscroll)
  (run-hooks 'eh-after-move-cursor-hook))

(defun eh--cur-previous-line (f &optional arg try-vscroll)
  "Extend `previous-line'.
F is the original function.
ARG and TRY-VSCROLL are identical to the original arguments."
  (run-hooks 'eh-before-move-cursor-hook)
  (funcall f arg try-vscroll)
  (run-hooks 'eh-after-move-cursor-hook))

(defun eh--cur-forward-char (f &optional N)
  "Extend `forward-char'.
F is the original function.
N is identical to the original arguments."
  (run-hooks 'eh-before-move-cursor-hook)
  (funcall f N)
  (run-hooks 'eh-after-move-cursor-hook))

(defun eh--cur-backward-char (f &optional N)
  "Extend `backward-char'.
F is the original function.
N is identical to the original arguments."
  (run-hooks 'eh-before-move-cursor-hook)
  (funcall f N)
  (run-hooks 'eh-after-move-cursor-hook))

(defun eh--cur-syntax-subword-forward (f &optional N)
  "Extend `syntax-subword-forward'.
F is the original function.
N is identical to the original arguments."
  (run-hooks 'eh-before-move-cursor-hook)
  (funcall f N)
  (run-hooks 'eh-after-move-cursor-hook))

(defun eh--cur-syntax-subword-backward (f &optional N)
  "Extend `syntax-subword-backward'.
F is the original function.
N is identical to the original arguments."
  (run-hooks 'eh-before-move-cursor-hook)
  (funcall f N)
  (run-hooks 'eh-after-move-cursor-hook))

(defun eh--cur-move-beginning-of-line (f ARG)
  "Extend `move-beginning-of-line'.
F is the original function.
ARG is identical to the original arguments."
  (run-hooks 'eh-before-move-cursor-hook)
  (funcall f ARG)
  (run-hooks 'eh-after-move-cursor-hook))

(defun eh--cur-move-end-of-line (f ARG)
  "Extend `move-end-of-line'.
F is the original function.
ARG is identical to the original arguments."
  (run-hooks 'eh-before-move-cursor-hook)
  (funcall f ARG)
  (run-hooks 'eh-after-move-cursor-hook))

(defun eh--cur-beginning-of-buffer (f &optional ARG)
  "Extend `beginning-of-buffer'.
F is the original function.
ARG is identical to the original arguments."
  (run-hooks 'eh-before-move-cursor-hook)
  (funcall f ARG)
  (run-hooks 'eh-after-move-cursor-hook))

(defun eh--cur-end-of-buffer (f &optional ARG)
  "Extend `end-of-buffer'.
F is the original function.
ARG is identical to the original arguments."
  (run-hooks 'eh-before-move-cursor-hook)
  (funcall f ARG)
  (run-hooks 'eh-after-move-cursor-hook))

(defun eh--setup ()
  "Setup."
  ;; For `eh-before-move-cursor-hook' and `eh-after-move-cursor-hook'
  (advice-add 'next-line :around #'eh--cur-next-line)
  (advice-add 'previous-line :around #'eh--cur-previous-line)
  (advice-add 'forward-char :around #'eh--cur-forward-char)
  (advice-add 'backward-char :around #'eh--cur-backward-char)
  (advice-add 'syntax-subword-forward :around #'eh--cur-syntax-subword-forward)
  (advice-add 'syntax-subword-backward :around #'eh--cur-syntax-subword-backward)
  (advice-add 'move-beginning-of-line :around #'eh--cur-move-beginning-of-line)
  (advice-add 'move-end-of-line :around #'eh--cur-move-end-of-line)
  (advice-add 'beginning-of-buffer :around #'eh--cur-beginning-of-buffer)
  (advice-add 'end-of-buffer :around #'eh--cur-end-of-buffer))

(defun eh--abort ()
  "Abort."
  ;; For `eh-before-move-cursor-hook' and `eh-after-move-cursor-hook'
  (advice-remove 'next-line #'eh--cur-next-line)
  (advice-remove 'previous-line #'eh--cur-previous-line)
  (advice-remove 'forward-char #'eh--cur-forward-char)
  (advice-remove 'backward-char #'eh--cur-backward-char)
  (advice-remove 'syntax-subword-forward #'eh--cur-syntax-subword-forward)
  (advice-remove 'syntax-subword-backward #'eh--cur-syntax-subword-backward)
  (advice-remove 'move-beginning-of-line #'eh--cur-move-beginning-of-line)
  (advice-remove 'move-end-of-line #'eh--cur-move-end-of-line)
  (advice-remove 'beginning-of-buffer #'eh--cur-beginning-of-buffer)
  (advice-remove 'end-of-buffer #'eh--cur-end-of-buffer))

;;;###autoload
(define-minor-mode eh-mode
  "Toggle the minor mode `eh-mode'."
  :init-value nil
  :lighter " Hooks"
  :global t
  :group 'eh
  (if eh-mode
      (eh--setup)
    (eh--abort)))

(provide 'eh)

;;; eh.el ends here
