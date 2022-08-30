local Translations = {
    info = {
        open_shop = "[E] Winkel",
        sell_chips = "[E] Verkoop Chips"
    },
    error = {
        dealer_decline = "De dealer weigert je vuurwapens te laten zien",
        talk_cop = "Praat met de politie om een wapenvergunning te krijgen",
        black_market = "We notice you don't have a license, check out these black market items"
    },
    success = {
        dealer_verify = "De dealer verifieert uw licentie"
    },
}

Lang = Locale:new({phrases = Translations})