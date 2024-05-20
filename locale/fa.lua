local Translations = {
    info = {
        open_shop = '[E] Furushgah',
        deliver_e = '~g~E~w~ - Tohfeh Kardan Mahsulat',
        deliver = 'Tohfeh Kardan Mahsulat',
    },
    error = {
        missing_license = 'Kamyabi dar Dashtan Mojavez %s baraye mahsulat makhsoos',
        no_deposit = '$%{value} Zaroori Ast',
        cancelled = 'Laghv Shod',
        vehicle_not_correct = 'In yak vasileye tijari nist!',
        no_driver = 'Baraye anjam dadan in amal bayad ranande bashid..',
        no_work_done = 'Shoma hanooz kari anjam nadadid..',
        backdoors_not_open = 'Darhaye aghab vasileye naghlieh baz nistand',
        get_out_vehicle = 'Baraye anjam dadan in amal bayad az vasileye naghlieh kharej shavid',
        too_far_from_trunk = 'Bayad az sandogh aghab vasileye naghlieh khod jabe bardarid',
        too_far_from_delivery = 'Bayad be nokteye tahvil nazdik tar bashid'
    },
    success = {
        dealer_verify = 'Frushande mojavez shoma ra taid mikonad',
        paid_with_cash = '$%{value} Zaroori Pardakht Shod Ba Naghd',
        paid_with_bank = '$%{value} Zaroori Pardakht Shod Az Bank',
        refund_to_cash = '$%{value} Zaroori Bargasht Ba Naghd',
        you_earned = '$%{value} Daray Shodid',
        payslip_time = 'Shoma be tamami furushgaha raftid .. vaght bara namaye shoma ast!',
    },
    mission = {
        store_reached = 'Furushgah resid, yek jabe az sandogh aghab ba [E] bardarid va be neshan tahvil dahid',
        take_box = 'Yek Jabe Mahsulat Bardarid',
        deliver_box = 'Jabe Mahsulat Tahvil Dahid',
        another_box = 'Yek Jabe Mahsulat Digar Bardarid',
        goto_next_point = 'Tamami mahsulat tahvil dade shod, be nokte badi beravid',
        return_to_station = 'Tamami mahsulat tahvil dade shod, be station bargardid',
        job_completed = 'Masir khod ra tamam kardid'
    },
}

if GetConvar('qb_locale', 'en') == 'fa' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
