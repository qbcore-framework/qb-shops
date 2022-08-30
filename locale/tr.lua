local Translations = {
    info = {
        open_shop = "[E] Market",
        sell_chips = "[E] Chips Sat"
    },
    error = {
        dealer_decline = "Satıcı size ateşli silahları göstermeyi reddediyor",
        talk_cop = "Silah ruhsatı almak için kolluk kuvvetleriyle konuşun",
        black_market = "We notice you don't have a license, check out these black market items"
    },
    success = {
        dealer_verify = "Satıcı lisansınızı doğruluyor"
    },
}

Lang = Locale:new({phrases = Translations})