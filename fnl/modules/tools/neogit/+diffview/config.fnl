(local {: autoload} (require :core.lib.autoload))
(local {: setup} (require :core.lib.setup))
(local {: tbl-path-ensure : tbl-union-extend} (autoload :core.lib.tables))
(local actions (autoload :diffview.actions))

(setup :diffview
       {:diff_binaries false
        :enhanced_diff_hl true
        :git_cmd [:git]
        :use_icons true
        :icons {:folder_closed "" :folder_open ""}
        :signs {:fold_closed "" :fold_open ""}
        :view {:merge_tool {:layout :diff3_mixed :disable_diagnostics true}}
        :file_panel {:listing_style :tree
                     :tree_options {:flatten_dirs true
                                    :folder_statuses :only_folded}
                     :win_config {:position :left :width 35}}
        :file_history_panel {:log_options {:single_file {:diff_merges :combined}
                                           :multi_file {:diff_merges :first-parent}}
                             :win_config {:position :bottom :height 16}}
        :commit_log_panel {:win_config {}}
        :default_args {:DiffviewOpen {} :DiffviewFileHistory {}}
        :hooks {:view_opened (fn [view]
                               (fn post-layout []
                                 (tbl-path-ensure view :winopts.diff2.a)
                                 (tbl-path-ensure view :winopts.diff2.b)
                                 (set view.winopts.diff2.a
                                      (tbl-union-extend view.winopts.diff2.a
                                                        {:winhl ["DiffChange:DiffAddAsDelete"
                                                                 "DiffText:DiffDeleteText"]}))
                                 (set view.winopts.diff2.b
                                      (tbl-union-extend view.winopts.diff2.b
                                                        {:winhl ["DiffChange:DiffAdd"
                                                                 "DiffText:DiffAddText"]})))

                               (view.emitter:on :post_layout post-layout)
                               (post-layout))}
        :keymaps {:view {:gf actions.goto_file_edit
                         :- actions.toggle_stage_entry}
                  :file_panel {:<cr> actions.focus_entry
                               :s actions.toggle_stage_entry
                               :gf actions.goto_file_edit
                               :? "<Cmd>h diffview-maps-file-panel<CR>"}
                  :file_history_panel {:<cr> actions.focus_entry
                                       :gf actions.goto_file_edit
                                       :? "<Cmd>h diffview-maps-file-history-panel<CR>"}}})
