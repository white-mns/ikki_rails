class ApplicationController < ActionController::Base
    def placeholder_set
        @placeholder = {}
        @placeholder["Number"] = "例）1~10/50~100"
        @placeholder["Text"]   = "例）武器/\"防具\""
        @placeholder["Name"]   = "例）ラルフ/\"ルリアンナ\""
        @placeholder["Skill"]  = "例）タックル/\"ミサイル\""
        @placeholder["Item"]   = "例）武器/\"防具\""
        @placeholder["Embryo"]   = "例）メイド長/\"メイド\""
        @placeholder["Gift"]   = "例）不滅/\"反撃\""
        @placeholder["ItemKind"]   = "例）材料/\"武器\""
        @placeholder["Fuka"]   = "例）活力/\"回避撃\""
    end
end
