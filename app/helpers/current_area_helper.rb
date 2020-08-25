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
end
