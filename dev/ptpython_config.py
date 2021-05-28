"""
Configuration example for ``ptpython``.

Copy this file to ~/.ptpython/config.py
"""
from __future__ import unicode_literals
from prompt_toolkit.filters import ViInsertMode
from prompt_toolkit.keys import Keys
from pygments.token import Token

from ptpython.layout import CompletionVisualisation

__all__ = (
    'configure',
)


def configure(repl):
    """
    Configuration method. This is called during the start-up of ptpython.

    :param repl: `PythonRepl` instance.
    """
    # Show function signature (bool).
    repl.show_signature = True

    # Show docstring (bool).
    repl.show_docstring = True

    # Show the "[Meta+Enter] Execute" message when pressing [Enter] only
    # inserts a newline instead of executing the code.
    repl.show_meta_enter_message = True

    # Show completions. (NONE, POP_UP, MULTI_COLUMN or TOOLBAR)
    repl.completion_visualisation = CompletionVisualisation.MULTI_COLUMN

    # When CompletionVisualisation.POP_UP has been chosen, use this
    # scroll_offset in the completion menu.
    repl.completion_menu_scroll_offset = 0

    # Show line numbers (when the input contains multiple lines.)
    repl.show_line_numbers = True

    # Show status bar.
    repl.show_status_bar = True

    # When the sidebar is visible, also show the help text.
    repl.show_sidebar_help = True

    # Highlight matching parethesis.
    repl.highlight_matching_parenthesis = True

    # Line wrapping. (Instead of horizontal scrolling.)
    repl.wrap_lines = True

    # Mouse support.
    repl.enable_mouse_support = True

    # Complete while typing. (Don't require tab before the
    # completion menu is shown.)
    repl.complete_while_typing = True

    # Vi mode.
    repl.vi_mode = False

    # Paste mode. (When True, don't insert whitespace after new line.)
    repl.paste_mode = False

    # Use the classic prompt. (Display '>>>' instead of 'In [1]'.)
    repl.prompt_style = 'ipython'  # 'classic' or 'ipython'

    # Don't insert a blank line after the output.
    repl.insert_blank_line_after_output = True

    # History Search.
    # When True, going back in history will filter the history on the records
    # starting with the current input. (Like readline.)
    # Note: When enable, please disable the `complete_while_typing` option.
    #       otherwise, when there is a completion available, the arrows will
    #       browse through the available completions instead of the history.
    repl.enable_history_search = True

    # Enable auto suggestions. (Pressing right arrow will complete the input,
    # based on the history.)
    repl.enable_auto_suggest = True

    # Enable open-in-editor. Pressing C-X C-E in emacs mode or 'v' in
    # Vi navigation mode will open the input in the current editor.
    repl.enable_open_in_editor = True

    # Enable system prompt. Pressing meta-! will display the system prompt.
    # Also enables Control-Z suspend.
    repl.enable_system_bindings = True

    # Ask for confirmation on exit.
    repl.confirm_exit = True

    # Enable input validation. (Don't try to execute when the input contains
    # syntax errors.)
    repl.enable_input_validation = True

    # Use this colorscheme for the code.
    repl.use_code_colorscheme('paraiso-dark')

    # Set color depth (keep in mind that not all terminals support true color).

    #repl.color_depth = 'DEPTH_1_BIT'  # Monochrome.
    #repl.color_depth = 'DEPTH_4_BIT'  # ANSI colors only.
    #repl.color_depth = 'DEPTH_8_BIT'  # The default, 256 colors.
    repl.color_depth = 'DEPTH_24_BIT'  # True color.

    # Syntax.
    repl.enable_syntax_highlighting = True

    # Install custom colorscheme named 'my-colorscheme' and use it.
    """
    repl.install_ui_colorscheme('my-colorscheme', _custom_ui_colorscheme)
    repl.use_ui_colorscheme('my-colorscheme')
    """

    # Add custom key binding for PDB.
    """
    @repl.add_key_binding(Keys.ControlB)
    def _(event):
        ' Pressing Control-B will insert "pdb.set_trace()" '
        event.cli.current_buffer.insert_text('\nimport pdb; pdb.set_trace()\n')
    """

    # Typing ControlE twice should also execute the current command.
    # (Alternative for Meta-Enter.)
    @repl.add_key_binding(Keys.ControlE, Keys.ControlE)
    def _(event):
        event.current_buffer.validate_and_handle()

    # Typing 'jj' in Vi Insert mode, should send escape. (Go back to navigation
    # mode.)
    """
    @repl.add_key_binding('j', 'j', filter=ViInsertMode())
    def _(event):
        " Map 'jj' to Escape. "
        event.cli.key_processor.feed(KeyPress(Keys.Escape))
    """

    # Custom key binding for some simple autocorrection while typing.
    corrections = {
        'impotr': 'import',
        'improt': 'import',
        'pritn': 'print',
        'form': 'from',
        'fomr': 'from',
    }

    @repl.add_key_binding(' ')
    def _1(event):
        ' When a space is pressed. Check & correct word before cursor. '
        b = event.cli.current_buffer
        w = b.document.get_word_before_cursor()

        if w is not None:
            if w in corrections:
                b.delete_before_cursor(count=len(w))
                b.insert_text(corrections[w])

        b.insert_text(' ')

    # Keybinding for function declaration completion
    @repl.add_key_binding(',', Keys.ControlJ)
    def _2(event):
        b = event.cli.current_buffer
        b.cursor_position += b.document.get_end_of_line_position()
        prev_line = b.document.current_line_before_cursor
        b.insert_text(':\n')
        for c in prev_line:
            if c.isspace():
                b.insert_text(c)
            else:
                break
        b.insert_text(' ' * 4)

    # Keybinding for autopair completions
    cpairs = {
        '(': ')',
        '[': ']',
        '{': '}',
        "'": "'",
        '"': '"',
    }

    def encloser(open_char):
        pairs = cpairs

        @repl.add_key_binding(open_char, Keys.Tab)
        def _3(event):
            b = event.cli.current_buffer
            b.insert_text(open_char + pairs[open_char])
            b.cursor_left()
        return _2

    for open_char in cpairs:
        encloser(open_char)

# Other changes made in the library:
# 1. In ptipython/entry_points/run_ptipython.py, the 'embed' function call was
#    modified to remove the passing of 'title' parameter that sets the title of
#    the terminal emulator. The same was done in run_ptpython.py, however that
#    is not a necessity.
# 2. In ptpython/key_bindings.py, in the function 'load_confirm_exit_bindings',
#    another decorator 'handle' was added for ContrlD
# 3. In ptpython/ipython.py, added a function to execute lines from the ipython
#    config file
# -----------------------------------------------------------------------------
# def execute_post_init_lines(shell, exec_lines):
#     """
#     Partial copy of 'InteractiveShellApp._run_exec_lines' from IPython.
#     """
#     try:
#         iter(exec_lines)
#     except TypeError:
#         pass  # no lines to execute
#     else:
#         for line in exec_lines:
#             try:
#                 shell.run_cell(line, store_history=False)
#             except:
#                 ipy_utils.warn.warn(
#                     "Error in executing line in user namespace: %s" % line +
#                     "\nCheck your config files in %s" % ipy_utils.path.get_ipython_dir())
#                 shell.showtraceback()
# -----------------------------------------------------------------------------
# execute_post_init_lines(shell, config['InteractiveShellApp']['exec_lines'])
# -----------------------------------------------------------------------------
