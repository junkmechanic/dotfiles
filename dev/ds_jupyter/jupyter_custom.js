require(['nbextensions/vim_binding/vim_binding'], function() {
    CodeMirror.Vim.defineOperator("comment_op",
                                  function(cm) { cm.toggleComment(); });
    CodeMirror.Vim.mapCommand("gc", "operator", "comment_op", {});
});

require([
  'nbextensions/vim_binding/vim_binding',
], function() {
//  CodeMirror.Vim.map(";", ":", "normal");
//  CodeMirror.Vim.map(":", ";", "normal");
});

Jupyter.keyboard_manager.actions.register({
    'help': 'run selected cells',
    'handler': function(env, event) {
        env.notebook.command_mode();
        var actions = Jupyter.keyboard_manager.actions;
        actions.call('jupyter-notebook:run-cell', event, env);
        actions.call('jupyter-notebook:scroll-cell-top', event, env);
        env.notebook.edit_mode();
    }
}, 'run-cell', 'vim-binding');
