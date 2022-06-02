local Translations = {
    info = {
        open_shop = "[E] Магазин",
        sell_chips = "[E] Продай чипове"
    },
    error = {
        dealer_decline = "Дилърът отказва да ви покаже огнестрелни оръжия",
        talk_cop = "Говорете с правоприлагащите органи, за да получите лиценз за огнестрелно оръжие"
    },
    success = {
        dealer_verify = "Дилърът проверява вашия лиценз"
    },
}

Lang = Locale:new({phrases = Translations})
