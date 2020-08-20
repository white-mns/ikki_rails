module NewSkillHelper
    def detail_new_skill_link(object)
        if !object || !object.skill then 
            return
        end

        link_to object.skill.name, skills_path + "?result_no_form=" + sprintf("%d", object.result_no) + "&skill_form= \"" + object.skill.name + "\""
    end

    def is_physics_img(flag)
        if !flag then return "" end
        
        if (flag == 1) then
            haml_tag :img, src: "https://archives.teiki.org/risu/ikki/1/result1/p/eb.gif"
        else
            haml_tag :img, src: "https://archives.teiki.org/risu/ikki/1/result1/p/em.gif"
        end
    end
end
