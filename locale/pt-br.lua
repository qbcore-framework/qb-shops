local Translations = {
    info = {
        open_shop = "[E] Loja",
        sell_chips = "[E] Vender Batatas Fritas"
    },
    error = {
        dealer_decline = "O vendedor se recusa a mostrar armas de fogo",
        talk_cop = "Converse com as autoridades para obter uma licença de armas de fogo"
    },
    success = {
        dealer_verify = "O vendedor verifica a sua licença"
    },
}


if GetConvar('qb_locale', 'en') == 'pt-br' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end