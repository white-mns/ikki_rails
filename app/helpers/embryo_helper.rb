module EmbryoHelper
    def is_physics_text(flag)
        if !flag then return "" end
        
        return (flag == 1) ? "物理" : "魔法"
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
