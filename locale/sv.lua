local Translations = {
    info = {
        open_shop = "[E] Affär",
        sell_chips = "[E] Sell Chips"
    },
    error = {
        dealer_decline = "Handlaren har nekat att visa dig sina vapen",
        talk_cop = "Prata med Polisen för att få en vapenlicens"
    },
    success = {
        dealer_verify = "Handlaren har godkänt din vapenlicens"
    },
}

if GetConvar('qb_locale', 'en') == 'sv' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
