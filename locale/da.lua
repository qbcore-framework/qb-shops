local Translations = {
    info = {
        interact = "[E] Butik"
    },
    error = {
        dealer_decline = "Forhandleren nægter at vise dig våbene",
        talk_cop = "Snak med politiet for at få en våben licens"
    },
    success = {
        dealer_verify = "Forhandleren bekræfter din licens"
    },
}

Lang = Locale:new({phrases = Translations})
