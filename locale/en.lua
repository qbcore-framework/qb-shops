local Translations = {
    info = {
        open_shop = "[E] Shop",
        sell_chips = "[E] Sell Chips"
    },
    error = {
        dealer_decline = "The dealer declines to show you firearms",
        talk_cop = "Speak with law enforcement to get a firearms license",
        black_market = "We notice you don't have a license, check out these black market items"
    },
    success = {
        dealer_verify = "The dealer verifies your license"
    },
}

Lang = Locale:new({phrases = Translations})