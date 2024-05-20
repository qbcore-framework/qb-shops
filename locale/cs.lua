local Translations = {
    info = {
        open_shop = '[E] Obchod',
        deliver_e = '~z~E~w~ - Dodávat Produkty',
        deliver = 'Dodávat Produkty',
    },
    error = {
        missing_license = 'Chybí licence %s pro určité produkty',
        no_deposit = '$%{value} Záloha je požadována',
        cancelled = 'Zrušeno',
        vehicle_not_correct = 'Toto není obchodní vozidlo!',
        no_driver = 'Musíte být řidičem, abyste to udělali..',
        no_work_done = 'Ještě jste neudělali žádnou práci..',
        backdoors_not_open = 'Zadní dveře vozidla nejsou otevřené',
        get_out_vehicle = 'Musíte vystoupit z vozidla, abyste provedli toto akce',
        too_far_from_trunk = 'Musíte vzít bedny z kufru vašeho vozidla',
        too_far_from_delivery = 'Musíte být blíže k bodu doručení'
    },
    success = {
        dealer_verify = 'Dealer ověřuje vaši licenci',
        paid_with_cash = '$%{value} Záloha byla zaplacena v hotovosti',
        paid_with_bank = '$%{value} Záloha byla zaplacena z banky',
        refund_to_cash = '$%{value} Záloha byla zaplacena v hotovosti',
        you_earned = 'Vy jste vydělali $%{value}',
        payslip_time = 'Navštívili jste všechny obchody .. Čas pro váš výplatní list!',
    },
    mission = {
        store_reached = 'Obchod byl dosažen, vezměte bednu do kufru s [E] a dodávejte k značce',
        take_box = 'Vezměte bednu s produkty',
        deliver_box = 'Dodávejte bednu s produkty',
        another_box = 'Vezměte další bednu s produkty',
        goto_next_point = 'Vy jste dodali všechny produkty, k dalšímu bodu',
        return_to_station = 'Vy jste dodali všechny produkty, vraťte se na stanici',
        job_completed = 'Vy jste dokončili svou trasu'
    },
}

if GetConvar('qb_locale', 'en') == 'cs' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
