c.InteractiveShellApp.extensions = [
        'powerline.bindings.ipython.post_0_11',
        'autoreload'

]

c.InteractiveShellApp.exec_lines = [
        '%autoreload 2'

]

# Better tab completion
# c.TerminalInteractiveShell.readline_parse_and_bind = ['tab: menu-complete', ... ]
