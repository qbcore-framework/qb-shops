local Translations = {
    info = {
        open_shop = '[E] Winkel',
        deliver_e = '~g~E~w~ - Producten leveren',
        deliver = 'Producten leveren',
    },
    error = {
        missing_license = 'Licentie %s ontbreekt voor bepaalde producten',
        no_deposit = '$%{value} Storting vereist',
        cancelled = 'Geannuleerd',
        vehicle_not_correct = 'Dit is geen commercieel voertuig!',
        no_driver = 'Je moet de bestuurder zijn om dit te doen...',
        no_work_done = 'Je hebt nog niets gedaan...',
        backdoors_not_open = 'De achterdeuren van het voertuig zijn niet open',
        get_out_vehicle = 'Je moet uit het voertuig stappen om deze actie uit te voeren',
        too_far_from_trunk = 'Je moet de dozen uit de kofferbak van je voertuig halen',
        too_far_from_delivery = 'Je moet dichter bij het leveringspunt zijn'
    },
    success = {
        dealer_verify = 'De dealer controleert je licentie',
        paid_with_cash = '$%{value} Storting betaald in contanten',
        paid_with_bank = '$%{value} Storting betaald via de bank',
        refund_to_cash = '$%{value} Storting betaald in contanten',
        you_earned = 'Je hebt $%{value} verdiend',
        payslip_time = 'Je hebt alle winkels bezocht... Het is tijd voor je loonstrookje!',
    },
    mission = {
        store_reached = 'Winkel bereikt, neem een doos met [E] en lever aan het markering',
        take_box = 'Neem een doos met producten',
        deliver_box = 'Lever een doos met producten',
        another_box = 'Neem nog een doos met producten',
        goto_next_point = 'Je hebt alle producten geleverd, ga naar het volgende punt',
        return_to_station = 'Je hebt alle producten geleverd, keer terug naar het station',
        job_completed = 'Je hebt je ronde voltooid'
    },
}

if GetConvar('qb_locale', 'en') == 'nl' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
