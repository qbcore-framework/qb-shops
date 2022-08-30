local Translations = {
    info = {
        open_shop = "[E] მაღაზია",
        sell_chips = "[E] Sell Chips"
    },
    error = {
        dealer_decline = "დილერს არ სურს გაჩვენოთ პროდუქცია ლიცენზიის გარეშე",
        talk_cop = "მიმართეთ ძალოვან სტრუქტურას ლიცენზიის ასაღებად.",
        black_market = "We notice you don't have a license, check out these black market items"
    },
    success = {
        dealer_verify = "დილერმა დაადასტურა ლიცენზიის ვარგისიანობა"
    },
}

Lang = Locale:new({phrases = Translations})
