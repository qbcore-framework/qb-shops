local Translations = {
    info = {
        open_shop = '[E] Kauppa',
        deliver_e = '~g~E~w~ - Toimita Tuotteet',
        deliver = 'Toimita Tuotteet',
    },
    error = {
        missing_license = 'Puuttuva %s lisenssi tiettyihin tuotteisiin',
        no_deposit = '$%{value} Talletus vaaditaan',
        cancelled = 'Peruutettu',
        vehicle_not_correct = 'Tämä ei ole kaupallinen ajoneuvo!',
        no_driver = 'Sinun täytyy olla kuljettaja tehdäksesi tämän..',
        no_work_done = 'Et ole vielä tehnyt mitään työtä..',
        backdoors_not_open = 'Ajoneuvon takaovet eivät ole auki',
        get_out_vehicle = 'Sinun täytyy poistua ajoneuvosta suorittaaksesi tämän toiminnon',
        too_far_from_trunk = 'Sinun täytyy ottaa laatikot ajoneuvosi takakontista',
        too_far_from_delivery = 'Sinun täytyy olla lähempänä toimituspistettä'
    },
    success = {
        dealer_verify = 'Jälleenmyyjä vahvistaa lisenssisi',
        paid_with_cash = '$%{value} Talletus maksettu käteisellä',
        paid_with_bank = '$%{value} Talletus maksettu pankista',
        refund_to_cash = '$%{value} Talletus palautettu käteisellä',
        you_earned = 'Ansaitsit $%{value}',
        payslip_time = 'Kävit kaikissa kaupoissa.. Aika palkkalaskelmalle!',
    },
    mission = {
        store_reached = 'Kauppa saavutettu, ota laatikko takakontista [E] ja toimita merkille',
        take_box = 'Ota Tuotelaatikko',
        deliver_box = 'Toimita Tuotelaatikko',
        another_box = 'Hae toinen Tuotelaatikko',
        goto_next_point = 'Olet toimittanut kaikki tuotteet, seuraavaan pisteeseen',
        return_to_station = 'Olet toimittanut kaikki tuotteet, palaa asemalle',
        job_completed = 'Olet suorittanut reittisi'
    },
}

if GetConvar('qb_locale', 'en') == 'fi' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
