local Translations = {
    info = {
        open_shop = '[E] Pood',
        deliver_e = '~g~E~w~ - Toimeta Tooteid',
        deliver = 'Toimeta Tooteid',
    },
    error = {
        missing_license = 'Teatud toodete jaoks puudub %s litsents',
        no_deposit = '$%{value} Tagatis nõutud',
        cancelled = 'Tühistatud',
        vehicle_not_correct = 'See ei ole kaubanduslik sõiduk!',
        no_driver = 'Selle tegemiseks peate olema juht..',
        no_work_done = 'Te pole veel tööd teinud..',
        backdoors_not_open = 'Sõiduki tagauksed pole avatud',
        get_out_vehicle = 'Selle toimingu sooritamiseks peate sõidukist väljuma',
        too_far_from_trunk = 'Peate kastid võtma oma sõiduki pagasiruumist',
        too_far_from_delivery = 'Peate olema lähemal tarnepunktile'
    },
    success = {
        dealer_verify = 'Edasimüüja kontrollib teie litsentsi',
        paid_with_cash = '$%{value} Tagatis tasutud sularahas',
        paid_with_bank = '$%{value} Tagatis tasutud pangast',
        refund_to_cash = '$%{value} Tagatis tagastatud sularahas',
        you_earned = 'Teenisite $%{value}',
        payslip_time = 'Külastasite kõiki poode .. aeg palgalehele!',
    },
    mission = {
        store_reached = 'Pood jõudnud, võtke pagasiruumist kast [E] ja toimeta markerile',
        take_box = 'Võtke Toote Kast',
        deliver_box = 'Toimeta Toote Kast',
        another_box = 'Hankige veel üks Toote Kast',
        goto_next_point = 'Olete kõik tooted kohaletoimetanud, järgmine punkt',
        return_to_station = 'Olete kõik tooted kohaletoimetanud, naaske jaama',
        job_completed = 'Olete oma marsruudi lõpetanud'
    },
}

if GetConvar('qb_locale', 'en') == 'et' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
