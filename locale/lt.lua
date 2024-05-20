local Translations = {
    info = {
        open_shop = '[E] Parduotuvė',
        deliver_e = '~g~E~w~ - Pristatyti Produktus',
        deliver = 'Pristatyti Produktus',
    },
    error = {
        missing_license = 'Trūksta %s licencijos tam tikriems produktams',
        no_deposit = '$%{value} Reikalingas Užstatas',
        cancelled = 'Atšaukta',
        vehicle_not_correct = 'Tai nėra komercinis automobilis!',
        no_driver = 'Turite būti vairuotojas, kad tai atliktumėte..',
        no_work_done = 'Dar nesate atlikę jokio darbo..',
        backdoors_not_open = 'Transporto priemonės galinės durys nėra atidarytos',
        get_out_vehicle = 'Turite išlipti iš transporto priemonės, kad atliktumėte šį veiksmą',
        too_far_from_trunk = 'Turite paimti dėžes iš savo transporto priemonės bagažinės',
        too_far_from_delivery = 'Turite būti arčiau pristatymo taško'
    },
    success = {
        dealer_verify = 'Prekeivis patikrina jūsų licenciją',
        paid_with_cash = '$%{value} Užstatas Sumokėtas Grynaisiais',
        paid_with_bank = '$%{value} Užstatas Sumokėtas Iš Banko',
        refund_to_cash = '$%{value} Užstatas Grąžintas Grynaisiais',
        you_earned = 'Uždirbote $%{value}',
        payslip_time = 'Aplankėte visas parduotuves .. Laikas jūsų atlyginimui!',
    },
    mission = {
        store_reached = 'Parduotuvė pasiekta, paimkite dėžę iš bagažinės su [E] ir pristatykite į žymeklį',
        take_box = 'Paimkite Produktų Dėžę',
        deliver_box = 'Pristatyti Produktų Dėžę',
        another_box = 'Paimkite kitą Produktų Dėžę',
        goto_next_point = 'Visus produktus pristatėte, eikite į kitą tašką',
        return_to_station = 'Visus produktus pristatėte, grįžkite į stotį',
        job_completed = 'Baigėte savo maršrutą'
    },
}

if GetConvar('qb_locale', 'en') == 'lt' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
