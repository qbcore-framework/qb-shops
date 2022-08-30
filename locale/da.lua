local Translations = {
    info = {
        open_shop = "[E] Butik",
        sell_chips = "[E] Sell Chips"
    },
    error = {
        dealer_decline = "Forhandleren nægter at vise dig våbene",
        talk_cop = "Snak med politiet for at få en våben licens",
        black_market = "We notice you don't have a license, check out these black market items"
    },
    success = {
        dealer_verify = "Forhandleren bekræfter din licens"
    },
}

Lang = Locale:new({phrases = Translations})
