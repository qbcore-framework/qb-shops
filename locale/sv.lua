local Translations = {
    info = {
        open_shop = "[E] Affär",
        sell_chips = "[E] Sell Chips"
    },
    error = {
        dealer_decline = "Handlaren har nekat att visa dig sina vapen",
        talk_cop = "Prata med Polisen för att få en vapenlicens",
        black_market = "We notice you don't have a license, check out these black market items"
    },
    success = {
        dealer_verify = "Handlaren har godkänt din vapenlicens"
    },
}

Lang = Locale:new({phrases = Translations})
