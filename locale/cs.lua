local Translations = {
    info = {
        open_shop = "[E] Obchod",
        sell_chips = "[E] Sell Chips"
    },
    error = {
        dealer_decline = "Prodejce zbraní vám nechce ukázat zbraně na prodej",
        talk_cop = "Promluvte si s policií pro získaní zbrojního průkazu",
        black_market = "We notice you don't have a license, check out these black market items"
    },
    success = {
        dealer_verify = "Prodejce úspěšně ověříl vaší licenci"
    },
}

Lang = Locale:new({phrases = Translations})
