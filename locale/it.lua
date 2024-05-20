local Translations = {
    info = {
        open_shop = '[E] Negozio',
        deliver_e = '~g~E~w~ - Consegna prodotti',
        deliver = 'Consegna prodotti',
    },
    error = {
        missing_license = 'Licenza %s mancante per alcuni prodotti',
        no_deposit = '$%{value} Deposito richiesto',
        cancelled = 'Annullato',
        vehicle_not_correct = 'Questo non è un veicolo commerciale!',
        no_driver = 'Devi essere il conducente per fare questo...',
        no_work_done = 'Non hai ancora fatto nulla...',
        backdoors_not_open = 'Le porte posteriori del veicolo non sono aperte',
        get_out_vehicle = 'Devi uscire dal veicolo per effettuare questa azione',
        too_far_from_trunk = 'Devi prendere le casse dal bagagliaio del tuo veicolo',
        too_far_from_delivery = 'Devi essere più vicino al punto di consegna'
    },
    success = {
        dealer_verify = 'Il concessionario verifica la tua licenza',
        paid_with_cash = '$%{value} Deposito pagato in contanti',
        paid_with_bank = '$%{value} Deposito pagato dalla banca',
        refund_to_cash = '$%{value} Deposito pagato in contanti',
        you_earned = 'Hai guadagnato $%{value}',
        payslip_time = 'Hai visitato tutti i negozi... È ora della tua busta paga!',
    },
    mission = {
        store_reached = 'Negozio raggiunto, prendi un cofano con [E] e consegna al marcatore',
        take_box = 'Prendi un cofano di prodotti',
        deliver_box = 'Consegna un cofano di prodotti',
        another_box = 'Prendi un altro cofano di prodotti',
        goto_next_point = 'Hai consegnato tutti i prodotti, vai al prossimo punto',
        return_to_station = 'Hai consegnato tutti i prodotti, torna alla stazione',
        job_completed = 'Hai completato il tuo giro'
    },
}

if GetConvar('qb_locale', 'en') == 'it' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
