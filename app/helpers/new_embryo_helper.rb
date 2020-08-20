module NewEmbryoHelper
    def detail_new_embryo_link(object)
        if !object || !object.embryo then 
            return
        end

        link_to object.embryo.name, embryos_path + "?result_no_form=" + sprintf("%d", object.result_no) + "&embryo_form= \"" + object.embryo.name + "\""
    end
end
