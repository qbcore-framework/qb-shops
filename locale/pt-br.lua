local Translations = {
    info = {
        open_shop = "[E] Loja",
        sell_chips = "[E] Vender Chips"
    },
    error = {
        dealer_decline = "O vendedor se recusa a mostrar armas a você",
        talk_cop = "Fale com a aplicação da lei para obter uma licença de armas de fogo"
    },
    success = {
        dealer_verify = "O vendedor verifica sua licença"
    },
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
