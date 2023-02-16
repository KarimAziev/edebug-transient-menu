;;; edebug-transient-menu.el --- Transient menus for Edebug commands -*- lexical-binding: t; -*-

;; Copyright (C) 2023 Karim Aziiev <karim.aziiev@gmail.com>

;; Author: Karim Aziiev <karim.aziiev@gmail.com>
;; URL: https://github.com/KarimAziev/edebug-transient-menu
;; Version: 0.1.0
;; Keywords: lisp, tools
;; Package-Requires: ((emacs "28.1"))

;; This file is NOT part of GNU Emacs.

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; Transient menus for Edebug commands

;;; Code:

(require 'edebug)

;;;###autoload (autoload 'edebug-transient-menu-jumps "edebug-transient-menu.el" nil t)
(transient-define-prefix edebug-transient-menu-jumps ()
  "Menu for Edebug jumps commands.."
  [("f" "Forward Sexp" edebug-forward-sexp)
   ("s" "Step In" edebug-step-in)
   ("t" "Step Out" edebug-step-out)
   ("g" "Goto Here" edebug-goto-here)])

;;;###autoload (autoload 'edebug-transient-menu-breaks "edebug-transient-menu.el" nil t)
(transient-define-prefix edebug-transient-menu-breaks ()
  "Menu for Edebug breakpoint commands."
  [("s" "Set Breakpoint" edebug-set-breakpoint)
   ("u" "Unset Breakpoint" edebug-unset-breakpoint)
   ("n" "Unset Breakpoints In Form" edebug-unset-breakpoints)
   ("t" "Toggle Disable Breakpoint" edebug-toggle-disable-breakpoint)
   ("e" "Set Conditional Breakpoint" edebug-set-conditional-breakpoint)
   ("g" "Set Global Break Condition" edebug-set-global-break-condition)
   ("h" "Show Next Breakpoint" edebug-next-breakpoint :transient t)])

;;;###autoload (autoload 'edebug-transient-menu-views "edebug-transient-menu.el" nil t)
(transient-define-prefix edebug-transient-menu-views ()
  "Menu for Edebug view commands."
  [("w" "Where am I?" edebug-where)
   ("b" "Bounce to Current Point" edebug-bounce-point)
   ("v" "View Outside Windows" edebug-view-outside)
   ("p" "Previous Result" edebug-previous-result)
   ("s" "Show Backtrace" edebug-pop-to-backtrace)
   ("d" "Display Freq Count" edebug-display-freq-count)])

;;;###autoload (autoload 'edebug-transient-menu-eval "edebug-transient-menu.el" nil t)
(transient-define-prefix edebug-transient-menu-eval ()
  "Menu for Edebug evaluation commands."
  [("e" "Expression" edebug-eval-expression)
   ("l" "Last Sexp" edebug-eval-last-sexp)
   ("v" "Visit Eval List" edebug-visit-eval-list)])

;;;###autoload (autoload 'edebug-transient-menu-toggle-trace "edebug-transient-menu.el" nil t)
(transient-define-suffix edebug-transient-menu-toggle-trace ()
  "Toggle value of the variable `edebug-trace'."
  :transient t
  :description
  (lambda ()
    (concat "Tracing"
            (if (and (boundp 'edebug-trace)
                     edebug-trace)
                (propertize " (On)" 'face 'success)
              (propertize " (Off)" 'face 'error))))
  (interactive)
  (when (fboundp 'edebug-toggle)
    (edebug-toggle 'edebug-trace)))

;;;###autoload (autoload 'edebug-transient-menu-toggle-edebug-test-coverage "edebug-transient-menu.el" nil t)
(transient-define-suffix edebug-transient-menu-toggle-edebug-test-coverage ()
  "Toggle value of the variable `edebug-test-coverage'."
  :transient t
  :description
  (lambda ()
    (concat "Test Coverage"
            (if (and (boundp 'edebug-test-coverage)
                     edebug-test-coverage)
                (propertize " (On)" 'face 'success)
              (propertize " (Off)" 'face 'error))))
  (interactive)
  (when (fboundp 'edebug-toggle)
    (edebug-toggle 'edebug-test-coverage)))

;;;###autoload (autoload 'edebug-transient-menu-toggle-save-buffer-points "edebug-transient-menu.el" nil t)
(transient-define-suffix edebug-transient-menu-toggle-save-buffer-points ()
  "Toggle `edebug-save-displayed-buffer-points'."
  :transient t
  :description
  (lambda ()
    (concat "Save Point"
            (if (and (boundp 'edebug-save-displayed-buffer-points)
                     edebug-save-displayed-buffer-points)
                (propertize " (On)" 'face 'success)
              (propertize " (Off)" 'face 'error))))
  (interactive)
  (when (fboundp 'edebug-toggle)
    (edebug-toggle 'edebug-save-displayed-buffer-points)))

;;;###autoload (autoload 'edebug-transient-menu-options "edebug-transient-menu.el" nil t)
(transient-define-prefix edebug-transient-menu-options ()
  "Command dispatcher for edebug options."
  [("e" edebug-all-defs
    :description
    (lambda ()
      (concat "Edebug All Defs"
              (if edebug-all-defs
                  (propertize " (On)" 'face 'success)
                (propertize " (Off)" 'face 'error))))
    :transient t)
   ("d"  edebug-all-forms
    :description
    (lambda ()
      (concat "Edebug All Forms"
              (if edebug-all-forms
                  (propertize " (On)" 'face 'success)
                (propertize " (Off)" 'face 'error))))
    :transient t)
   ""
   ("t" edebug-transient-menu-toggle-trace)
   ("c" edebug-transient-menu-toggle-edebug-test-coverage)
   ("s" edebug-toggle-save-windows
    :description
    (lambda ()
      (concat "Save Windows"
              (if
                  (and (boundp 'edebug-save-windows)
                       edebug-save-windows)
                  (propertize
                   " (On)" 'face
                   'success)
                (propertize
                 " (Off)" 'face
                 'error))))
    :transient t)
   ("p" edebug-transient-menu-toggle-save-buffer-points)])

;;;###autoload (autoload 'edebug-transient-menu "edebug-transient-menu.el" nil t)
(transient-define-prefix edebug-transient-menu ()
  "Command dispatcher for edebug."
  [:description
   (lambda ()
     (concat "Edebug "
             (if (and (boundp 'edebug-mode)
                      edebug-mode)
                 (propertize " (On)" 'face 'success)
               (propertize " (Off)" 'face 'error))))
   [("s" "Stop" edebug-stop :transient t)
    ("t" "Step" edebug-step-mode :transient t)
    ("n" "Next" edebug-next-mode :transient t)
    ("r" "Trace" edebug-trace-mode :transient t)
    ("a" "Trace Fast" edebug-Trace-fast-mode :transient t)
    ("c" "Continue" edebug-continue-mode :transient t)
    ("F" "Continue Fast" edebug-Continue-fast-mode :transient t)
    ("g" "Go" edebug-go-mode :transient t)
    ("p" "Go Nonstop" edebug-Go-nonstop-mode :transient t)]
   [("h" "Help" edebug-help)
    ("b" "Abort" abort-recursive-edit)
    ("q" "Quit to Top Level" top-level)
    ("u" "Quit Nonstop" edebug-top-level-nonstop)]
   [("J" "Jumps" edebug-transient-menu-jumps)
    ("B" "Breaks" edebug-transient-menu-breaks)
    ("V" "Views" edebug-transient-menu-views)
    ("E" "Eval" edebug-transient-menu-eval)
    ("o" "Options" edebug-transient-menu-options)]])

(provide 'edebug-transient-menu)
;;; edebug-transient-menu.el ends here