local Translations = {
    info = {
        open_shop = "[E] Furushgah",
        sell_chips = "[E] Sell Chips"
    },
    error = {
        dealer_decline = "Frushande Az Neshan Dadan Aslahe Be Shoma Khoddari Mikonad",
        talk_cop = "Baraye Daryaft Selah Garm Ba Mojriyan Ganun Sohbat Konid"
    },
    success = {
        dealer_verify = "Frushande Mojavez Shomara ra Tayid Kard"
    },
}

if GetConvar('qb_locale', 'en') == 'fa' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
