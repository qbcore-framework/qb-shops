local Translations = {
    info = {
        interact = "~g~E~w~ - Obchod"
    },
    error = {
        dealer_decline = "Prodejce zbraní vám nechce ukázat zbraně na prodej",
        talk_cop = "Promluvte si s policií pro získaní zbrojního průkazu"
    },
    success = {
        dealer_verify = "Prodejce úspěšně ověříl vaší licenci"
    },
}

Lang = Locale:new({phrases = Translations})
