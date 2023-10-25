local Translations = {
    info = {
        open_shop = '[E] Shop',
        sell_chips = '[E] Sell Chips'
    },
    error = {
        missing_license = 'Missing a %s license for certain products',
    },
    success = {
        dealer_verify = 'The dealer verifies your license'
    },
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})