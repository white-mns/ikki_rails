module NewNextEnemyHelper
    def detail_new_next_enemy_link(object)
        if !object || !object.enemy then 
            return
        end

        link_to object.enemy.name, next_battle_infos_path + "?result_no_form=" + sprintf("%d", object.result_no) + "&enemy_form=\"" + object.enemy.name + "\""
    end

    def detail_new_next_boss_link(object)
        if !object || !object.enemy then 
            return
        end

        link_to "初予告", next_battle_infos_path + "?result_no_form=" + sprintf("%d", object.result_no) + "&enemy_form=\"" + object.enemy.name + "\""
    end

    def detail_new_battle_boss_link(object)
        if !object || !object.new_battle then 
            return
        end

        link_to "初戦闘", battle_results_path + "?result_no_form=" + sprintf("%d", object.new_battle.result_no) + "&enemy_form=\"" + object.enemy.name + "\""
    end

    def detail_new_defeat_boss_link(object)
        if !object || !object.new_defeat then 
            return
        end

        link_to "初突破", battle_results_path + "?result_no_form=" + sprintf("%d", object.new_defeat.result_no) + "&result_win=on&enemy_form=\"" + object.enemy.name + "\""
    end
end
