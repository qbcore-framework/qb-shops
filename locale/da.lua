local Translations = {
    info = {
        open_shop = '[E] Butik',
        deliver_e = '~g~E~w~ - Lever Produkter',
        deliver = 'Lever Produkter',
    },
    error = {
        missing_license = 'Mangler en %s-licens til visse produkter',
        no_deposit = '$%{value} Depositum Påkrævet',
        cancelled = 'Annulleret',
        vehicle_not_correct = 'Dette er ikke et erhvervskøretøj!',
        no_driver = 'Du skal være føreren for at gøre dette..',
        no_work_done = 'Du har ikke udført noget arbejde endnu..',
        backdoors_not_open = 'Bagdørene på køretøjet er ikke åbne',
        get_out_vehicle = 'Du skal stige ud af køretøjet for at udføre denne handling',
        too_far_from_trunk = 'Du skal tage kasserne fra bagagerummet på dit køretøj',
        too_far_from_delivery = 'Du skal være tættere på leveringspunktet'
    },
    success = {
        dealer_verify = 'Forhandleren verificerer din licens',
        paid_with_cash = '$%{value} Depositum Betalt Med Kontanter',
        paid_with_bank = '$%{value} Depositum Betalt Fra Bank',
        refund_to_cash = '$%{value} Depositum Tilbagebetalt Med Kontanter',
        you_earned = 'Du Tjente $%{value}',
        payslip_time = 'Du Har Besøgt Alle Butikkerne .. Tid Til Din Lønseddel!',
    },
    mission = {
        store_reached = 'Butik nået, tag en kasse i bagagerummet med [E] og lever til markøren',
        take_box = 'Tag En Kasse Med Produkter',
        deliver_box = 'Lever En Kasse Med Produkter',
        another_box = 'Hent en anden Kasse Med Produkter',
        goto_next_point = 'Du Har Levet Alle Produkter, Til Næste Punkt',
        return_to_station = 'Du Har Levet Alle Produkter, Returner Til Stationen',
        job_completed = 'Du Har Fuldført Din Rute'
    },
}

if GetConvar('qb_locale', 'en') == 'da' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
