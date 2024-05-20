local Translations = {
    info = {
        open_shop = '[E] Butik',
        deliver_e = '~g~E~w~ - Leverera produkter',
        deliver = 'Leverera produkter',
    },
    error = {
        missing_license = 'Licens %s saknas för vissa produkter',
        no_deposit = '$%{value} Insättning krävs',
        cancelled = 'Avbruten',
        vehicle_not_correct = 'Detta är inte ett kommersiellt fordon!',
        no_driver = 'Du måste vara föraren för att göra detta...',
        no_work_done = 'Du har inte gjort någonting än...',
        backdoors_not_open = 'Bilens bakdörrar är inte öppna',
        get_out_vehicle = 'Du måste stiga ur fordonet för att utföra denna åtgärd',
        too_far_from_trunk = 'Du måste hämta lådorna från bagageutrymmet i ditt fordon',
        too_far_from_delivery = 'Du måste vara närmare leveranspunkten'
    },
    success = {
        dealer_verify = 'Återförsäljaren verifierar din licens',
        paid_with_cash = '$%{value} Insättning betald kontant',
        paid_with_bank = '$%{value} Insättning betald via bank',
        refund_to_cash = '$%{value} Insättning betald kontant',
        you_earned = 'Du har tjänat $%{value}',
        payslip_time = 'Du har besökt alla butiker... Dags för din lönebesked!',
    },
    mission = {
        store_reached = 'Butik nådd, ta en låda med [E] och leverera till markeringen',
        take_box = 'Ta en låda med produkter',
        deliver_box = 'Leverera en låda med produkter',
        another_box = 'Ta en annan låda med produkter',
        goto_next_point = 'Du har levererat alla produkter, gå till nästa punkt',
        return_to_station = 'Du har levererat alla produkter, återvänd till stationen',
        job_completed = 'Du har slutfört din runda'
    },
}

if GetConvar('qb_locale', 'en') == 'sv' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
