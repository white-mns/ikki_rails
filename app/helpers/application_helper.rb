module ApplicationHelper
    def page_title
        title = "IkkiFantasyデータ小屋"
        title = @page_title + " | " + title if @page_title
        title
    end

    def top_result_no(result_no,generate_no)
        if !result_no then return "-" end
        text = ""
        generate_text = ""
        generate_text = "再" if generate_no > 0
        num = 2
        while num <= generate_no do
            num += 1
            generate_text += "々"
        end
        text = sprintf("%d", result_no) + "回" + generate_text
        text
    end

    def pc_name_text(e_no, pc_name)
        e_no_text = "(" + sprintf("%d",e_no) + ")"
        if pc_name then
            pc_name.name.html_safe + e_no_text
        else
            e_no_text
        end
    end

    def character_link(e_no)
        if e_no <= 0 then return end

        file_name = sprintf("%d",e_no)
        link_to " 最終回", "https://archives.teiki.org/risu/ikki/1/result69/k/k"+file_name+".html", :target => "_blank"
    end
    
    def character_old_link(latest_result_no, e_no, result_no, generate_no)
        if e_no <= 0 then return end
        if result_no == latest_result_no then return end

        result_no_text = sprintf("%d", result_no)
        generate_text  = generate_no > 0 ? "_" + sprintf("%d", generate_no) : ""
        file_name = sprintf("%d", e_no)
        link_to " 結果", "https://archives.teiki.org/risu/ikki/1/result"+result_no_text+generate_text+"/k/k"+file_name+".html", :target => "_blank"
    end

    def search_submit_button()
        haml_tag :button, class: "btn submit", type: "submit" do
            haml_concat fa_icon "search", text: "検索する"
        end
    end

    def help_icon()
        haml_concat fa_icon "question-circle"
    end

    def act_desc(is_opened)
        desc        = is_opened ? "（クリックで閉じます）" : "（クリックで開きます）"
        desc_closed = is_opened ? "（クリックで開きます）" : "（クリックで閉じます）"

        haml_tag :span, class: "act_desc" do
            haml_concat desc
        end

        haml_tag :span, class: "act_desc closed" do
            haml_concat desc_closed
        end
    end

    def act_icon(is_opened)
        icon        = is_opened ? "times" : "plus"
        icon_closed = is_opened ? "plus"  : "times"

        haml_tag :span, class: "act_desc" do
            haml_concat fa_icon icon, class: "fa-lg"
        end

        haml_tag :span, class: "act_desc closed" do
            haml_concat fa_icon icon_closed, class: "fa-lg"
        end
    end

    def td_form(f, form_params, placeholders, class_name: nil, colspan: nil, label: nil, params_name: nil, placeholder: nil, checkboxes: nil, label_td_class_name: nil)
        haml_tag :td, class: label_td_class_name do
            if label then
                haml_concat f.label params_name.to_sym, label
            end
        end

        # テキストフォームの描画
        if !class_name.nil? && !params_name.nil?  then
            td_text_form(f, form_params, placeholders, class_name: class_name, colspan: colspan, params_name: params_name, placeholder: placeholder)
        end

        # チェックボックス選択フォームの描画
        if !checkboxes.nil?  then
            td_text_checkbox(f, form_params, placeholders, class_name: class_name, colspan: colspan, checkboxes: checkboxes)
        end
    end

    def td_text_form(f, form_params, placeholders, class_name: nil, colspan: nil, params_name: nil, placeholder: nil)
        haml_tag :td, class: class_name, colspan: colspan do
            haml_concat text_field_tag params_name.to_sym, form_params[params_name], placeholder: placeholders[placeholder]
        end
    end

    def td_text_checkbox(f, form_params, placeholders, class_name: nil, colspan: nil, checkboxes: [])
        haml_tag :td, class: class_name, colspan: colspan do
            checkboxes.each do |hash|
                # チェックボックスの描画
                if !hash[:params_name].nil? then
                    haml_tag :span, class: hash[:class_name] do
                        haml_concat check_box_tag hash[:params_name].to_sym, form_params[hash[:params_name]], form_params[hash[:params_name]]
                        haml_concat label_tag hash[:params_name].to_sym, hash[:label]
                    end
                end

                # 改行指定
                if hash[:br] then
                    haml_tag :br
                end
            end
        end
    end

    def tbody_toggle(form_params, params_name: nil, label: {open: "", close: ""}, act_desc: nil, base_first: false)
        haml_tag :tbody, class: "tbody_toggle pointer"do
            haml_tag :tr do
                haml_tag :td, colspan: 5 do
                    if base_first then
                        haml_concat hidden_field_tag :base_first, form_params["base_first"]
                    end

                    haml_concat hidden_field_tag params_name.to_sym, form_params[params_name]

                    act_icon(false)

                    haml_concat label_tag params_name.to_sym, "　" + label[:open],  class: "act_desc"
                    haml_concat label_tag params_name.to_sym, "　" + label[:close], class: "act_desc closed"
                    if act_desc then
                        haml_tag :div, class: "act_desc" do
                           haml_concat "　" + act_desc
                        end
                    end
                end
            end
        end
    end

    def area_level_text(area)
        if !area then return end
        text = ["","平原","水辺","砂地","城内","森林","山岳"]
        return text[area.level]
    end

    def party_type_text(party)
        if !party then 
            return
        end

        if party.party_type == 0 then "今回攻城"
        elsif party.party_type == 1 then "次回攻城"
        elsif party.party_type == 10 then "今回対人"
        elsif party.party_type == 11 then "次回対人"
        else "？"
        end
    end

    def party_members_pc_name_text(party_members)
        if !party_members then 
            return
        end

        party_members.each do |party_member|
            if party_member.pc_name then
                haml_concat party_member.pc_name.name.html_safe
            end
            haml_concat "("

            result_no_text = sprintf("%d", party_member.result_no)
            generate_text  = party_member.generate_no > 0 ? "_" + sprintf("%d", party_member.generate_no) : ""
            file_name = sprintf("%d", party_member.e_no)
            haml_tag :a, href: "https://archives.teiki.org/risu/ikki/1/result"+result_no_text+generate_text+"/k/k"+ file_name+".html", target: "_blank" do
                haml_concat party_member.e_no
            end

            haml_concat ")"
            haml_tag :br
        end
    end

    def enemy_members_text(members)
        if !members then 
            return
        end

        members.each do |member|
            haml_concat member.enemy.name
            haml_tag :br
        end
    end

    def is_boss_text(object)
        if !object then 
            return
        end

        if object.is_boss == 0 then ""
        elsif object.is_boss == 1 then "○"
        else "？"
        end
    end

    def duel_type_text(object)
        if !object then 
            return
        end

        if object.battle_type == 0 then "練習"
        elsif object.battle_type == 1 then "デュエル"
        else "？"
        end
    end

    def assault_text(assault_type)
        if !assault_type then return "" end
        text = ["", "PK","PKvsPK(襲)","被PKK","PKvsPK(被)","PKK","被PK"]
        return text[assault_type]
    end
end
