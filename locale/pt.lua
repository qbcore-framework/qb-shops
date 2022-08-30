local Translations = {
    info = {
        open_shop = "[E] Abrir Loja",
        sell_chips = "[E] Sell Chips"
    },
    error = {
        dealer_decline = "O Vendedor recusou mostrar o armeiro",
        talk_cop = "Fala com um agente para obteres o porte de arma",
        black_market = "We notice you don't have a license, check out these black market items"
    },
    success = {
        dealer_verify = "O vendedor está a verificar a tua licença"
    },
}

Lang = Locale:new({phrases = Translations})
