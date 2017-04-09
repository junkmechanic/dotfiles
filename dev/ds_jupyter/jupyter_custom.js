define([
    'base/js/namespace',
    'base/js/events'
    ],
    function(IPython, events) {
        events.on("app_initialized.NotebookApp",
            function () {
                require("notebook/js/cell").Cell.options_default.cm_config.lineNumbers = true;
            }
        );
    }
);
