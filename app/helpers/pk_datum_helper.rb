module PkDatumHelper
    def pk_history_link(e_no)
        if !e_no then 
            return
        end

        link_to "活動履歴", pk_histories_path + "?result_no_form=~" + sprintf("%d", @latest_result) + "&e_no_form=" + sprintf("%d", e_no)
    end
end
