module CurrentAreaHelper
    def area_total_link(result_no, area, advance, data)
        if !area then return end
        if !data then return end
        if data[[area.area_id, advance]] > 0 then
            link_to data[[area.area_id, advance]], current_areas_path + "?result_no_form=" + sprintf("%d", result_no) + "&name_form=" + area.name + "&advance_form=" + sprintf("%d", advance)
        else
            data[[area.area_id, advance]]
        end
    end

    def assault_text(assault_type)
        if !assault_type then return "" end
        text = ["", "PK","PKvsPK(襲)","被PKK","PKvsPK(被)","PKK","被PK"]
        return text[assault_type]
    end

    def pk_name_link(latest_result_no, e_no, pc_name)
        result_no_text = sprintf("%d", latest_result_no)
        file_name = sprintf("%d", e_no)
        haml_tag :a, href: "https://archives.teiki.org/risu/ikki/1/result"+result_no_text+"/k/k"+ file_name+".html", target: "_blank", style: "font-size:large;" do
            haml_concat pc_name_text(e_no, pc_name)
        end
    end


end
