local Translations = {
    info = {
        open_shop = "[E] Pood",
        sell_chips = "[E] Müü chipid maha"
    },
    error = {
        dealer_decline = "Relvadiiler keeldub sulle relvade näitamisest.",
        talk_cop = "Räägi riigiametnikuga, et endale relvaluba taodelda.",
        black_market = "We notice you don't have a license, check out these black market items"
    },
    success = {
        dealer_verify = "Diiler kinnitas su relvaloa."
    },
}

Lang = Locale:new({phrases = Translations})
