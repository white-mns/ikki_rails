module AssaultHelper
    def assault_text(assault_type)
        if !assault_type then return "" end
        text = ["", "PK","PKvsPK(襲)","被PKK","PKvsPK(被)","PKK","被PK"]
        return text[assault_type]
    end
end
