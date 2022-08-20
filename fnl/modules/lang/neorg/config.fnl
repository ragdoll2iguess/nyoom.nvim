(import-macros {: nyoom-module-p!} :macros)
(local {: setup} (require :neorg))

(setup {:load {:core.defaults {}
               :core.norg.qol.toc {}
               :core.norg.concealer {}
               :core.gtd.base {:config {:workspace :personal}}
               :core.norg.completion {:config {:engine :nvim-cmp}}
               :core.norg.dirman {:config {:workspaces {:personal "~/neorg/notes"}
                                           :autodetect true
                                           :autochdir true}}}})
