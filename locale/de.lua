local Translations = {
    info = {
        open_shop = '[E] Geschäft',
        deliver_e = '~g~E~w~ - Produkte liefern',
        deliver = 'Produkte liefern',
    },
    error = {
        missing_license = 'Fehlende %s-Lizenz für bestimmte Produkte',
        no_deposit = '$%{value} Kaution erforderlich',
        cancelled = 'Abgebrochen',
        vehicle_not_correct = 'Dies ist kein gewerbliches Fahrzeug!',
        no_driver = 'Sie müssen der Fahrer sein, um dies zu tun..',
        no_work_done = 'Sie haben noch keine Arbeit geleistet..',
        backdoors_not_open = 'Die Hecktüren des Fahrzeugs sind nicht offen',
        get_out_vehicle = 'Sie müssen aus dem Fahrzeug aussteigen, um diese Aktion auszuführen',
        too_far_from_trunk = 'Sie müssen die Kisten aus dem Kofferraum Ihres Fahrzeugs holen',
        too_far_from_delivery = 'Sie müssen näher am Lieferpunkt sein'
    },
    success = {
        dealer_verify = 'Der Händler überprüft Ihre Lizenz',
        paid_with_cash = '$%{value} Kaution mit Bargeld bezahlt',
        paid_with_bank = '$%{value} Kaution von der Bank bezahlt',
        refund_to_cash = '$%{value} Kaution mit Bargeld zurückerstattet',
        you_earned = 'Sie haben $%{value} verdient',
        payslip_time = 'Sie haben alle Geschäfte besucht.. Zeit für Ihren Lohnzettel!',
    },
    mission = {
        store_reached = 'Geschäft erreicht, holen Sie eine Kiste aus dem Kofferraum mit [E] und liefern Sie sie zum Marker',
        take_box = 'Nehmen Sie eine Kiste mit Produkten',
        deliver_box = 'Liefern Sie eine Kiste mit Produkten',
        another_box = 'Holen Sie eine weitere Kiste mit Produkten',
        goto_next_point = 'Sie haben alle Produkte geliefert, zum nächsten Punkt',
        return_to_station = 'Sie haben alle Produkte geliefert, zurück zur Station',
        job_completed = 'Sie haben Ihre Route abgeschlossen'
    },
}

if GetConvar('qb_locale', 'en') == 'de' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
