local Translations = {
    info = {
        open_shop = "[E] Kauppa",
        sell_chips = "[E] Myy casino pelimerkkejä"
    },
    error = {
        dealer_decline = "Myyjä kieltäytyy näyttämästä sinulle aseita",
        talk_cop = "Pyydä poliisilta aselupaa.",
        black_market = "We notice you don't have a license, check out these black market items"
    },
    success = {
        dealer_verify = "Myyjä tarkisti aselupasi"
    },
}

Lang = Locale:new({phrases = Translations})
